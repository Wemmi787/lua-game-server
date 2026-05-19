FROM luvit/luvit:latest

WORKDIR /app
COPY . .

EXPOSE 8080

CMD ["luvit", "server.lua"]