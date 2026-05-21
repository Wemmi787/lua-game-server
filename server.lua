local socket = require("socket")
local server = assert(socket.bind("*", 8080))
server:settimeout(0)

local queues = {}  -- queues[serverID] = { list of requests }

-- receive messages
local function receiveMessages()
    local client = server:accept()
    if client then
        client:settimeout(1)
        local msg = client:receive("*l")
        if msg then
            local serverID = msg:match("^(.-)|")
            queues[serverID] = queues[serverID] or {}
            table.insert(queues[serverID], msg)
        end
        client:close()
    end
end

-- send batches every second
local function sendBatches()
    for serverID, list in pairs(queues) do
        if #list > 0 then
            -- send to host (HTTP POST or socket)
            sendToHost(serverID, table.concat(list, "\n"))
            queues[serverID] = {}
        end
    end
end

-- main loop
while true do
    receiveMessages()
    sendBatches()
    socket.sleep(0.01)
end
