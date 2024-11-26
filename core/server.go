package main

import "C"
import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
	"os"
)

var conn net.Conn

func init() {
	listener, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		os.Exit(1)
	}
	fmt.Printf("%d\n ", listener.Addr().(*net.TCPAddr).Port)
	defer func(listener net.Listener) {
		_ = listener.Close()
	}(listener)

	for {
		conn, err = listener.Accept()
		if err != nil {
			fmt.Printf("Accept err: %s\n ", err.Error())
			continue
		}
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer func(conn net.Conn) {
		_ = conn.Close()
	}(conn)

	reader := bufio.NewReader(conn)

	for {
		data, err := reader.ReadString('\n')
		if err != nil {
			return
		}

		var action = &Action{}

		err = json.Unmarshal([]byte(data), action)

		if err != nil {
			return
		}

		handleAction(action)
	}
}

func handleAction(action *Action) {
	switch action.Method {
	case initClashMethod:
		data := action.Data.(string)
		action.callback(handleInitClash(data))
		return
	case getIsInitMethod:
		action.callback(handleGetIsInit())
		return
	case forceGcMethod:
		handleForceGc()
		return
	case shutdownMethod:
		action.callback(handleShutdown())
		return
	case validateConfigMethod:
		data := []byte(action.Data.(string))
		action.callback(handleValidateConfig(data))
		return
	case updateConfigMethod:
		data := []byte(action.Data.(string))
		action.callback(handleUpdateConfig(data))
		return
	case getProxiesMethod:
		action.callback(handleGetProxies())
		return
	case changeProxyMethod:
		data := action.Data.(string)
		action.callback(handleChangeProxy(data))
		return
	case getTrafficMethod:
		action.callback(handleGetTraffic())
		return
	case getTotalTrafficMethod:
		action.callback(handleGetExternalProviders())
		return
	case resetTrafficMethod:
		handleResetTraffic()
		return
	case asyncTestDelayMethod:
		data := action.Data.(string)
		handleAsyncTestDelay(data, func(value string) {
			action.callback(value)
		})
		return
	case getConnectionsMethod:
		action.callback(handleGetConnections())
		return
	case closeConnectionsMethod:
		action.callback(handleCloseConnections())
		return
	case closeConnectionMethod:
		id := action.Data.(string)
		action.callback(handleCloseConnection(id))
		return
	case getExternalProvidersMethod:
		action.callback(handleGetExternalProviders())
		return
	case getExternalProviderMethod:
		externalProviderName := action.Data.(string)
		action.callback(handleGetExternalProvider(externalProviderName))
	case updateGeoDataMethod:
		paramsString := action.Data.(string)
		var params = map[string]string{}
		err := json.Unmarshal([]byte(paramsString), &params)
		if err != nil {
			action.callback(err.Error())
			return
		}
		geoType := params["geoType"]
		geoName := params["geoName"]
		handleUpdateGeoData(geoType, geoName, func(value string) {
			action.callback(value)
		})
		return
	case updateExternalProviderMethod:
		providerName := action.Data.(string)
		handleUpdateExternalProvider(providerName, func(value string) {
			action.callback(value)
		})
		return
	case sideLoadExternalProviderMethod:
		paramsString := action.Data.(string)
		var params = map[string]string{}
		err := json.Unmarshal([]byte(paramsString), &params)
		if err != nil {
			action.callback(err.Error())
			return
		}
		providerName := params["providerName"]
		data := params["data"]
		handleSideLoadExternalProvider(providerName, []byte(data), func(value string) {
			action.callback(value)
		})
		return
	case startLogMethod:
		handleStartLog()
		return
	case stopLogMethod:
		handleStopLog()
		return
	case startListenerMethod:
		action.callback(handleStartListener())
		return
	case stopListenerMethod:
		handleStartListener()
		return
	}

}
