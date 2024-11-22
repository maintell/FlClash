package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
	"os"
)

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
		conn, err := listener.Accept()
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
		handleInitClash(data)
	}
}
