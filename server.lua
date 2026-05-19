local socket = require("socket")
local server = assert(socket.bind("*", 8080))
print("Luau server running on port 8080")

while true do
    local client = server:accept()
    client:settimeout(1)

    local line = client:receive()
    if line then
        client:send("HTTP/1.1 200 OK\r\n")
        client:send("Content-Type: text/plain\r\n\r\n")
        client:send("Luau server running on Railway!")
    end

    client:close()
end
