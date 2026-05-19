local socket = require("socket")

local move = require("routes.move")
local state = require("routes.state")

local server = assert(socket.bind("*", 8080))
print("Lua API server running on port 8080")

local function read_request(client)
    local line = client:receive()
    if not line then return nil end
    local method, path = line:match("^(%w+)%s+(.-)%s+HTTP")
    return method, path
end

local function send(client, body)
    client:send("HTTP/1.1 200 OK\r\n")
    client:send("Content-Type: text/plain\r\n\r\n")
    client:send(body)
end

while true do
    local client = server:accept()
    client:settimeout(1)

    local method, path = read_request(client)

    if path == "/" then
        send(client, "Lua server running")
    elseif path == "/move" then
        send(client, move())
    elseif path == "/state" then
        send(client, state())
    else
        send(client, "Not found")
    end

    client:close()
end
