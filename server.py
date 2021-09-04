from http.server import *
address = ("", 8080)
httpd = HTTPServer(address, SimpleHTTPRequestHandler)
httpd.serve_forever()