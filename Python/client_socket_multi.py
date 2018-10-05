#!/usr/bin/env python3

import socket
address = "127.0.0.1"
port = input("Choose port number: \n")
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((address, int(port)))
print("Connected to the server")
print("Tap END to close the connection.")
message = ""
while message.upper() != "END":
	message = input("> ")
	client.send(message.encode("utf-8"))
	response = client.recv(255)
	print(response.decode("utf-8"))
print("Connection closed")
client.close()
