package main

import "C"
import (
	"encoding/json"
	"github.com/metacubex/mihomo/constant"
)

const (
	initClashMethod = `json:"initClash"`
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

var (
	isInit = false
)

func handleInitClash(homeDirStr string) bool {
	if !isInit {
		constant.SetHomeDir(homeDirStr)
		isInit = true
	}
	return isInit
}
