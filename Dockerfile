FROM alpine:latest

# Install Lua + LuaSocket
RUN apk add --no-cache lua5.1 lua5.1-socket

WORKDIR /app
COPY . .

EXPOSE 8080

CMD ["lua5.1", "server.lua"]
