package main

/*
#include <stdlib.h>
*/
import "C"
import (
	bridge "core/dart-bridge"
	"encoding/json"
	"os"
	"runtime"
	"sort"
	"unsafe"

	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/component/updater"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel/statistic"
)

//export initClash
func initClash(homeDirStr *C.char) bool {
	return handleInitClash(C.GoString(homeDirStr))
}

//export startListener
func startListener() {
	handleStartListener()
}

//export stopListener
func stopListener() {
	handleStopListener()
}

//export getIsInit
func getIsInit() bool {
	return handleGetIsInit()
}

//export restartClash
func restartClash() bool {
	execPath, _ := os.Executable()
	go restartExecutable(execPath)
	return true
}

//export shutdownClash
func shutdownClash() bool {
	stopListeners()
	executor.Shutdown()
	runtime.GC()
	isInit = false
	return true
}

//export forceGc
func forceGc() {
	handleForceGc()
}

//export validateConfig
func validateConfig(s *C.char, port C.longlong) {
	i := int64(port)
	bytes := []byte(C.GoString(s))
	go func() {
		bridge.SendToPort(i, handleValidateConfig(bytes))
	}()
}

//export updateConfig
func updateConfig(s *C.char, port C.longlong) {
	i := int64(port)
	bytes := []byte(C.GoString(s))
	go func() {
		bridge.SendToPort(i, handleUpdateConfig(bytes))
	}()
}

//export clearEffect
func clearEffect(s *C.char) {
	id := C.GoString(s)
	handleClearEffect(id)
}

//export getProxies
func getProxies() *C.char {
	return C.CString(handleGetProxies())
}

//export changeProxy
func changeProxy(s *C.char) {
	paramsString := C.GoString(s)
	handleChangeProxy(paramsString)
}

//export getTraffic
func getTraffic() *C.char {
	return C.CString(handleGetTraffic())
}

//export getTotalTraffic
func getTotalTraffic() *C.char {
	return C.CString(handleGetTotalTraffic())
}

//export resetTraffic
func resetTraffic() {
	handleResetTraffic()
}

//export asyncTestDelay
func asyncTestDelay(s *C.char, port C.longlong) {
	i := int64(port)
	paramsString := C.GoString(s)
	handleAsyncTestDelay(paramsString, func(value string) {
		bridge.SendToPort(i, value)
	})
}

//export getConnections
func getConnections() *C.char {
	return C.CString(handleGetConnections())
}

//export closeConnections
func closeConnections() {
	handleCloseConnections()
}

//export closeConnection
func closeConnection(id *C.char) {
	connectionId := C.GoString(id)
	handleCloseConnection(connectionId)
}

//export getExternalProviders
func getExternalProviders() *C.char {
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
		return C.CString("")
	}
	return C.CString(string(data))
}

//export getExternalProvider
func getExternalProvider(name *C.char) *C.char {
	runLock.Lock()
	defer runLock.Unlock()
	externalProviderName := C.GoString(name)
	externalProvider, exist := externalProviders[externalProviderName]
	if !exist {
		return C.CString("")
	}
	e, err := toExternalProvider(externalProvider)
	if err != nil {
		return C.CString("")
	}
	data, err := json.Marshal(e)
	if err != nil {
		return C.CString("")
	}
	return C.CString(string(data))
}

//export updateGeoData
func updateGeoData(geoType *C.char, geoName *C.char, port C.longlong) {
	i := int64(port)
	geoTypeString := C.GoString(geoType)
	geoNameString := C.GoString(geoName)
	go func() {
		path := constant.Path.Resolve(geoNameString)
		switch geoTypeString {
		case "MMDB":
			err := updater.UpdateMMDBWithPath(path)
			if err != nil {
				bridge.SendToPort(i, err.Error())
				return
			}
		case "ASN":
			err := updater.UpdateASNWithPath(path)
			if err != nil {
				bridge.SendToPort(i, err.Error())
				return
			}
		case "GeoIp":
			err := updater.UpdateGeoIpWithPath(path)
			if err != nil {
				bridge.SendToPort(i, err.Error())
				return
			}
		case "GeoSite":
			err := updater.UpdateGeoSiteWithPath(path)
			if err != nil {
				bridge.SendToPort(i, err.Error())
				return
			}
		}
		bridge.SendToPort(i, "")
	}()
}

//export updateExternalProvider
func updateExternalProvider(providerName *C.char, port C.longlong) {
	i := int64(port)
	providerNameString := C.GoString(providerName)
	go func() {
		externalProvider, exist := externalProviders[providerNameString]
		if !exist {
			bridge.SendToPort(i, "external provider is not exist")
			return
		}
		err := externalProvider.Update()
		if err != nil {
			bridge.SendToPort(i, err.Error())
			return
		}
		bridge.SendToPort(i, "")
	}()
}

//export sideLoadExternalProvider
func sideLoadExternalProvider(providerName *C.char, data *C.char, port C.longlong) {
	i := int64(port)
	bytes := []byte(C.GoString(data))
	providerNameString := C.GoString(providerName)
	go func() {
		externalProvider, exist := externalProviders[providerNameString]
		if !exist {
			bridge.SendToPort(i, "external provider is not exist")
			return
		}
		err := sideUpdateExternalProvider(externalProvider, bytes)
		if err != nil {
			bridge.SendToPort(i, err.Error())
			return
		}
		bridge.SendToPort(i, "")
	}()
}

//export initNativeApiBridge
func initNativeApiBridge(api unsafe.Pointer) {
	bridge.InitDartApi(api)
}

//export initMessage
func initMessage(port C.longlong) {
	i := int64(port)
	Port = i
}

//export freeCString
func freeCString(s *C.char) {
	C.free(unsafe.Pointer(s))
}

//export startLog
func startLog() {
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

//export stopLog
func stopLog() {
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
