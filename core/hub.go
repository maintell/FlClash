package main

import "C"
import "github.com/metacubex/mihomo/constant"

const (
	initClashMethod = `json:"initClash"`
)

type Method string

type Action struct {
	Method Method      `json:"method"`
	Data   interface{} `json:"data"`
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
