package main

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
		Action{
			Method: initClashMethod,
			Data:   handleInitClash(data),
		}.send()
		return
	case getIsInitMethod:
		handleGetIsInit()
		return
	case forceGcMethod:
		handleForceGc()
		return
	case validateConfigMethod:
		data := []byte(action.Data.(string))
		Action{
			Method: validateConfigMethod,
			Data:   handleValidateConfig(data),
		}.send()
		return
	case updateConfigMethod:
		data := []byte(action.Data.(string))
		Action{
			Method: updateConfigMethod,
			Data:   handleUpdateConfig(data),
		}.send()
		return
	case clearEffectMethod:
		id := action.Data.(string)
		handleClearEffect(id)
		return
	case getProxiesMethod:
		Action{
			Method: getProxiesMethod,
			Data:   handleGetProxies(),
		}.send()
		return
	case changeProxyMethod:
		data := action.Data.(string)
		handleChangeProxy(data)
		return
	case getTrafficMethod:
		Action{
			Method: getTrafficMethod,
			Data:   handleGetTraffic(),
		}.send()
		return
	case getTotalTrafficMethod:
		Action{
			Method: getTotalTrafficMethod,
			Data:   handleGetExternalProviders(),
		}.send()
		return
	case resetTrafficMethod:
		handleResetTraffic()
		return
	case asyncTestDelayMethod:
		data := action.Data.(string)
		handleAsyncTestDelay(data, func(value string) {
			Action{
				Method: asyncTestDelayMethod,
				Data:   value,
			}.send()
		})
		return
	case getConnectionsMethod:
		Action{
			Method: getConnectionsMethod,
			Data:   handleGetConnections(),
		}.send()
		return
	case closeConnectionsMethod:
		handleCloseConnections()
		return
	case closeConnectionMethod:
		id := action.Data.(string)
		handleCloseConnection(id)
		return
	case getExternalProvidersMethod:
	case getExternalProviderMethod:
	case updateGeoDataMethod:
	case updateExternalProviderMethod:
	case sideLoadExternalProviderMethod:
	case startLogMethod:
		handleStartLog()
		return
	case stopLogMethod:
		handleStopLog()
		return
	}
}
