from python:alpine
label org.opencontainers.image.source https://github.com/yodasoda1219/kube-playground
run mkdir -p /app/server
workdir /app/server
copy server.py .
cmd [ "python", "server.py" ]