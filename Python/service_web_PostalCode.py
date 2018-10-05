#!/usr/bin/env python3

import urllib.request
import json

while True:
	postalCode = input("Enter postal code: ")
	request = urllib.request.Request('http://api.zippopotam.us/FR/' + postalCode)
	response = urllib.request.urlopen(request)

	raw_data = response.read().decode("utf-8")
	json_data = json.loads(raw_data)

	listCities = json_data["places"]
	print("Cities with postal code " + postalCode + " : ")

	for city in listCities:
		print(" - " + city["place name"])
