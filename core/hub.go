package main

import "C"
import (
	"context"
	"core/state"
	"encoding/json"
	"fmt"
	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outboundgroup"
	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/common/observable"
	"github.com/metacubex/mihomo/common/utils"
	"github.com/metacubex/mihomo/component/updater"
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	cp "github.com/metacubex/mihomo/constant/provider"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/listener"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel"
	"github.com/metacubex/mihomo/tunnel/statistic"
	"runtime"
	"sort"
	"time"
)

var (
	isInit            = false
	configParams      = ConfigExtendedParams{}
	externalProviders = map[string]cp.Provider{}
	logSubscriber     observable.Subscription[log.Event]
)

func handleInitClash(homeDirStr string) bool {
	if !isInit {
		constant.SetHomeDir(homeDirStr)
		isInit = true
	}
	return isInit
}

func handleStartListener() {
	runLock.Lock()
	defer runLock.Unlock()
	isRunning = true
}

func handleStopListener() {
	runLock.Lock()
	go func() {
		defer runLock.Unlock()
		isRunning = false
		listener.StopListener()
	}()
}

func handleGetIsInit() bool {
	return isInit
}

func handleForceGc() {
	go func() {
		log.Infoln("[APP] request force GC")
		runtime.GC()
	}()
}

func handleValidateConfig(bytes []byte) string {
	_, err := config.UnmarshalRawConfig(bytes)
	if err != nil {
		return err.Error()
	}
	return ""
}

func handleUpdateConfig(bytes []byte) string {
	runLock.Lock()
	defer runLock.Unlock()
	var params = &GenerateConfigParams{}
	err := json.Unmarshal(bytes, params)
	if err != nil {
		return err.Error()
	}
	configParams = params.Params
	prof := decorationConfig(params.ProfileId, params.Config)
	state.CurrentRawConfig = prof
	err = applyConfig()
	if err != nil {
		return err.Error()
	}
	return ""
}

func handleClearEffect(id string) {
	go func() {
		_ = removeFile(getProfilePath(id))
		_ = removeFile(getProfileProvidersPath(id))
	}()
}

func handleGetProxies() string {
	runLock.Lock()
	defer runLock.Unlock()
	data, err := json.Marshal(tunnel.ProxiesWithProviders())
	if err != nil {
		return ""
	}
	return string(data)
}

func handleChangeProxy(data string) {
	runLock.Lock()
	defer runLock.Unlock()
	var params = &ChangeProxyParams{}
	err := json.Unmarshal([]byte(data), params)
	if err != nil {
		log.Infoln("Unmarshal ChangeProxyParams %v", err)
	}
	groupName := *params.GroupName
	proxyName := *params.ProxyName
	proxies := tunnel.ProxiesWithProviders()
	group, ok := proxies[groupName]
	if !ok {
		return
	}
	adapterProxy := group.(*adapter.Proxy)
	selector, ok := adapterProxy.ProxyAdapter.(outboundgroup.SelectAble)
	if !ok {
		return
	}
	if proxyName == "" {
		selector.ForceSet(proxyName)
	} else {
		err = selector.Set(proxyName)
	}
	if err == nil {
		log.Infoln("[SelectAble] %s selected %s", groupName, proxyName)
	}
}

func handleGetTraffic() string {
	up, down := statistic.DefaultManager.Current(state.CurrentState.OnlyProxy)
	traffic := map[string]int64{
		"up":   up,
		"down": down,
	}
	data, err := json.Marshal(traffic)
	if err != nil {
		fmt.Println("Error:", err)
		return ""
	}
	return string(data)
}

func handleGetTotalTraffic() string {
	up, down := statistic.DefaultManager.Total(state.CurrentState.OnlyProxy)
	traffic := map[string]int64{
		"up":   up,
		"down": down,
	}
	data, err := json.Marshal(traffic)
	if err != nil {
		fmt.Println("Error:", err)
		return ""
	}
	return string(data)
}

func handleResetTraffic() {
	statistic.DefaultManager.ResetStatistic()
}

func handleAsyncTestDelay(paramsString string, fn func(string)) {
	b.Go(paramsString, func() (bool, error) {
		var params = &TestDelayParams{}
		err := json.Unmarshal([]byte(paramsString), params)
		if err != nil {
			fn("")
			return false, nil
		}

		expectedStatus, err := utils.NewUnsignedRanges[uint16]("")
		if err != nil {
			fn("")
			return false, nil
		}

		ctx, cancel := context.WithTimeout(context.Background(), time.Millisecond*time.Duration(params.Timeout))
		defer cancel()

		proxies := tunnel.ProxiesWithProviders()
		proxy := proxies[params.ProxyName]

		delayData := &Delay{
			Name: params.ProxyName,
		}

		if proxy == nil {
			delayData.Value = -1
			data, _ := json.Marshal(delayData)
			fn(string(data))
			return false, nil
		}

		delay, err := proxy.URLTest(ctx, constant.DefaultTestURL, expectedStatus)
		if err != nil || delay == 0 {
			delayData.Value = -1
			data, _ := json.Marshal(delayData)
			fn(string(data))
			return false, nil
		}

		delayData.Value = int32(delay)
		data, _ := json.Marshal(delayData)
		fn(string(data))
		return false, nil
	})
}

func handleGetConnections() string {
	runLock.Lock()
	defer runLock.Unlock()
	snapshot := statistic.DefaultManager.Snapshot()
	data, err := json.Marshal(snapshot)
	if err != nil {
		fmt.Println("Error:", err)
		return ""
	}
	return string(data)
}

func handleCloseConnections() {
	runLock.Lock()
	defer runLock.Unlock()
	statistic.DefaultManager.Range(func(c statistic.Tracker) bool {
		err := c.Close()
		if err != nil {
			return false
		}
		return true
	})
}

func handleCloseConnection(connectionId string) {
	runLock.Lock()
	defer runLock.Unlock()
	c := statistic.DefaultManager.Get(connectionId)
	if c == nil {
		return
	}
	_ = c.Close()
}

func handleGetExternalProviders() string {
	runLock.Lock()
	defer runLock.Unlock()
	externalProviders = getExternalProvidersRaw()
	eps := make([]ExternalProvider, 0)
	for _, p := range externalProviders {
		externalProvider, err := toExternalProvider(p)
		if err != nil {
			continue
		}
		eps = append(eps, *externalProvider)
	}
	sort.Sort(ExternalProviders(eps))
	data, err := json.Marshal(eps)
	if err != nil {
		return ""
	}
	return string(data)
}

func handleGetExternalProvider(externalProviderName string) string {
	runLock.Lock()
	defer runLock.Unlock()
	externalProvider, exist := externalProviders[externalProviderName]
	if !exist {
		return ""
	}
	e, err := toExternalProvider(externalProvider)
	if err != nil {
		return ""
	}
	data, err := json.Marshal(e)
	if err != nil {
		return ""
	}
	return string(data)
}

func handleUpdateGeoData(geoType string, geoName string, fn func(value string)) {
	go func() {
		path := constant.Path.Resolve(geoName)
		switch geoType {
		case "MMDB":
			err := updater.UpdateMMDBWithPath(path)
			if err != nil {
				fn(err.Error())
				return
			}
		case "ASN":
			err := updater.UpdateASNWithPath(path)
			if err != nil {
				fn(err.Error())
				return
			}
		case "GeoIp":
			err := updater.UpdateGeoIpWithPath(path)
			if err != nil {
				fn(err.Error())
				return
			}
		case "GeoSite":
			err := updater.UpdateGeoSiteWithPath(path)
			if err != nil {
				fn(err.Error())
				return
			}
		}
		fn("")
	}()
}

func handleUpdateExternalProvider(providerName string, fn func(value string)) {
	go func() {
		runLock.Lock()
		defer runLock.Unlock()
		externalProvider, exist := externalProviders[providerName]
		if !exist {
			fn("external provider is not exist")
			return
		}
		err := externalProvider.Update()
		if err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}()
}

func handleSideLoadExternalProvider(providerName string, data []byte, fn func(value string)) {
	go func() {
		runLock.Lock()
		defer runLock.Unlock()
		externalProvider, exist := externalProviders[providerName]
		if !exist {
			fn("external provider is not exist")
			return
		}
		err := sideUpdateExternalProvider(externalProvider, data)
		if err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}()
}

func handleStartLog() {
	if logSubscriber != nil {
		log.UnSubscribe(logSubscriber)
		logSubscriber = nil
	}
	logSubscriber = log.Subscribe()
	go func() {
		for logData := range logSubscriber {
			if logData.LogLevel < log.Level() {
				continue
			}
			message := &Message{
				Type: LogMessage,
				Data: logData,
			}
			SendMessage(*message)
		}
	}()
}

func handleStopLog() {
	if logSubscriber != nil {
		log.UnSubscribe(logSubscriber)
		logSubscriber = nil
	}
}

func init() {
	provider.HealthcheckHook = func(name string, delay uint16) {
		delayData := &Delay{
			Name: name,
		}
		if delay == 0 {
			delayData.Value = -1
		} else {
			delayData.Value = int32(delay)
		}
		SendMessage(Message{
			Type: DelayMessage,
			Data: delayData,
		})
	}
	statistic.DefaultRequestNotify = func(c statistic.Tracker) {
		SendMessage(Message{
			Type: RequestMessage,
			Data: c,
		})
	}
	executor.DefaultProviderLoadedHook = func(providerName string) {
		SendMessage(Message{
			Type: LoadedMessage,
			Data: providerName,
		})
	}
}
