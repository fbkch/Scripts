#!/usr/bin/env python3

import socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('',50000))		# listen on port 50000
server.listen(5)

while True:
	client, infosClient = server.accept()
	print("Connected client. Address "+ infosClient[0])
	request = client.recv(255)
	print(request.decode("utf-8"))
	response = "Hi, I'm the server"
	client.send(response.encode("utf-8"))
	print("Connection closed")
	client.close()
server.close()
