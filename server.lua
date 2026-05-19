local http = require('http')

http.createServer(function (req, res)
  res:setHeader("Content-Type", "text/plain")
  res:finish("Lua server running on Railway!")
end):listen(8080)

print("Server running on port 8080")
