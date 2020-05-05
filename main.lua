
function getFrame()
  local socket = require("socket")
  udp = socket.udp()

  local ip_address = "192.168.1.1"
  local port = 2947
  
  if udp:setsockname(ip_address, port) then
    print("Connected to HTTP server")
    while true do
      data = udp:receivefrom()
      checkPinOutput(data)
      if data then
        print("\nReceived old data:", data)
      else
        print("No recived data")
      end
    end
  else
    print("Not connected to HTTP server")
  end
end

function checkPinOutput(data)
  local handle = io.popen("gpio.sh get DOUT1", 'r')
  local result_read = handle:read("*a")
  handle:close() 
  whiteSpaceStringOutput(result_read, data)
end

function whiteSpaceStringOutput(result_read, data)
  result = string.gsub(result_read, "^%s*(.-)%s*$", "%1")
  --print("gpio button status:", result, "\n")
  setNewFrame(result, data)
end

function setNewFrame(button, data)
  local number = 'newarg1'
  local Error = 'newarg2'
  local value_checked = '1'

  print("Value checked:", value_checked)

  if button == value_checked then
    newData = data..",".. number..",".. Error
    --print("new data:", newData)
    sendNewFrame(newData)
  else 
    sendNewFrame(data)
  end
end

function sendNewFrame(newData)
  local socket_server = require("socket")
  udp_sock = socket_server.udp()
  
  local ip_address = "127.0.0.1"
  local port = 80

  if udp:setsockname(ip_address, port) then
    print ("Connected to host")
    udp:sendto(newData, ip_address, port)
  else 
    print("Not connected to host")
  end
  print("New Frame:", newData)
end

getFrame()
