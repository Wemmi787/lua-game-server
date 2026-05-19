local socket = require("socket")

local server = assert(socket.bind("*", 8080))
print("Lua API server running on port 8080")

local function read_request(client)
    local line = client:receive()
    if not line then return nil end

    local method, path = line:match("^(%w+)%s+(.-)%s+HTTP")
    return method, path
end

local function send(client, body, contentType)
    client:send("HTTP/1.1 200 OK\r\n")
    client:send("Content-Type: " .. (contentType or "text/plain") .. "\r\n\r\n")
    client:send(body)
end

while true do
    local client = server:accept()
    client:settimeout(1)

    local method, path = read_request(client)

    if path == "/" then
        send(client, "Lua server running")
    elseif path == "/move" then
        send(client, "Move received")
    elseif path == "/state" then
        send(client, "Game state here")
    else
        send(client, "Not found", "text/plain")
    end

    client:close()
end
