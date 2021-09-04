from python:alpine
run mkdir -p /app/server
workdir /app/server
copy server.py .
cmd [ "python", "server.py" ]