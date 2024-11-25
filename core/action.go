package main

import "encoding/json"

const (
	messageMethod                  = `json:"message"`
	initClashMethod                = `json:"initClash"`
	getIsInitMethod                = `json:"getIsInit"`
	forceGcMethod                  = `json:"forceGc"`
	validateConfigMethod           = `json:"validateConfig"`
	updateConfigMethod             = `json:"updateConfig"`
	clearEffectMethod              = `json:"clearEffect"`
	getProxiesMethod               = `json:"getProxies"`
	changeProxyMethod              = `json:"changeProxy"`
	getTrafficMethod               = `json:"getTraffic"`
	getTotalTrafficMethod          = `json:"getTotalTraffic"`
	resetTrafficMethod             = `json:"resetTraffic"`
	asyncTestDelayMethod           = `json:"asyncTestDelay"`
	getConnectionsMethod           = `json:"getConnections"`
	closeConnectionsMethod         = `json:"closeConnections"`
	closeConnectionMethod          = `json:"closeConnection"`
	getExternalProvidersMethod     = `json:"getExternalProviders"`
	getExternalProviderMethod      = `json:"getExternalProvider"`
	updateGeoDataMethod            = `json:"updateGeoData"`
	updateExternalProviderMethod   = `json:"updateExternalProvider"`
	sideLoadExternalProviderMethod = `json:"sideLoadExternalProvider"`
	startLogMethod                 = `json:"startLog"`
	stopLogMethod                  = `json:"stopLog"`
)

type Method string

type Action struct {
	Method Method      `json:"method"`
	Data   interface{} `json:"data"`
}

func (action Action) Json() ([]byte, error) {
	data, err := json.Marshal(action)
	return data, err
}

func (action Action) send() bool {
	if conn == nil {
		return false
	}
	res, err := action.Json()
	if err != nil {
		return false
	}
	_, err = conn.Write(res)
	if err != nil {
		return false
	}
	return true
}
