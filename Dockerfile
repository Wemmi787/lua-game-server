FROM alpine:latest

# Install dependencies
RUN apk add --no-cache curl unzip lua5.1 lua5.1-socket

# Download Luau binary
RUN curl -L https://github.com/Roblox/luau/releases/latest/download/luau-linux.zip -o luau.zip \
    && unzip luau.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/luau

WORKDIR /app
COPY . .

EXPOSE 8080

CMD ["lua5.1", "server.lua"]
