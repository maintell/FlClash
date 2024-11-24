package main

import "encoding/json"

const (
	initClashMethod = `json:"initClash"`
	getIsInitMethod = `json:"getIsInit"`
	forceGcMethod   = `json:"forceGc"`
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

func (action Action) send() {
	if conn == nil {
		return
	}
	res, _ := action.Json()
	_, _ = conn.Write(res)
}
