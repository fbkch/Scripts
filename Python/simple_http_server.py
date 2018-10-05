#!/usr/bin/env python3

import http.server
port = 80
address = ("", port)
server = http.server.HTTPServer
handler = http.server.CGIHTTPRequestHandler
handler.cgi_directories = ["/tmp"]
print("Server listening on port ", port)

httpd = server(address, handler)
httpd.serve_forever()
