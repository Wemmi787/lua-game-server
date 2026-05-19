FROM alpine:latest

# Install dependencies
RUN apk add --no-cache curl unzip lua5.1 lua5.1-socket jq

# Fetch latest Luau release asset name
RUN LATEST=$(curl -s https://api.github.com/repos/Roblox/luau/releases/latest \
    | jq -r '.assets[] | select(.name | contains("Linux")) | .browser_download_url') \
    && curl -L "$LATEST" -o luau.zip \
    && unzip luau.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/luau

WORKDIR /app
COPY . .

EXPOSE 8080

CMD ["lua5.1", "server.lua"]
