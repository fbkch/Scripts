#!/usr/bin/env python3

import urllib.request
import json

request = urllib.request.Request('https://api.ipify.org?format=json')
response = urllib.request.urlopen(request)

raw_data = response.read().decode("utf-8")
json_data = json.loads(raw_data)

ipv4 = json_data["ip"]
print("My IPv4: " + ipv4[:]) 
