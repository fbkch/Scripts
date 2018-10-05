#!/usr/bin/env python3

import urllib.request
import json

request = urllib.request.Request('http://api.open-notify.org/iss-now.json')
response = urllib.request.urlopen(request)

raw_data = response.read().decode("utf-8")
json_data = json.loads(raw_data)

position = json_data["iss_position"]
print("ISS longitude: " + position["longitude"] + " and latitude "+ position["latitude"] + ". ")

