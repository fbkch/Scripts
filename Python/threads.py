#!/usr/bin/env python3

import threading
def counter(nameThread):
	for i in range(3):
		print(nameThread + " : " + str(i))
threadA = threading.Thread(None, counter, None, ("Thread A",),{})
threadB = threading.Thread(None, counter, None, ("Thread B",),{})
threadA.start()
threadB.start()
