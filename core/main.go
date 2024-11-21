package main

import "C"
import (
	"bufio"
	"fmt"
	"net"
	"os"
)

func main() {
	listener, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		fmt.Println("Error starting server:", err)
		os.Exit(1)
	}
	fmt.Println("Server is listening on port", listener.Addr().String())
	defer func(listener net.Listener) {
		_ = listener.Close()
	}(listener)

	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}
		fmt.Println("Client connected:", conn.RemoteAddr())

		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer func(conn net.Conn) {
		_ = conn.Close()
	}(conn)

	reader := bufio.NewReader(conn)
	for {
		message, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("Connection closed by client:", conn.RemoteAddr())
			return
		}

		fmt.Printf("Message from %s: %s", conn.RemoteAddr(), message)

		_, err = conn.Write([]byte("Message received: " + message))
		if err != nil {
			fmt.Println("Error writing to client:", err)
			return
		}
	}
}
