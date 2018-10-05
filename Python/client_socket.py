#!/usr/bin/env python3

import socket
port=50000
address="127.0.0.1"
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((address, port))
print("Connected to the server")
client.send("Hi, I'm the client".encode("utf-8"))
response = client.recv(255)
print(response.decode("utf-8"))
print("Connection closed")
client.close()
