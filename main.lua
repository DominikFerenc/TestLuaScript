function getFrame()
  local socket = require("socket")
  udp = socket.udp()
  if udp:setsockname("192.168.1.1", 2947) then
    print("Connected to HTTP server")
    
    while true do
      data = udp:receivefrom()
      checkPinOutput(data)
      if data then
        print("\nReceived Data: ", data)
      else
        print("No recived data")
      end
    end
  else
    print("Not Connected to HTTP Server")
  end
end

function checkPinOutput(data)
  button = os.execute("gpio.sh get DOUT1\n")
  print("gpio button status:", button, "\n")
  setNewFrame(button, data)
end

function setNewFrame(button, data)
  number = "nummber"
  Error = "Erorrx1"

  if button == 1 then
    newData = data..",".. number..",".. Error
    print("new data:", newData)
    sendNewFrame(newData)
  else 
    sendNewFrame(data)
  end
end

function sendNewFrame(newData)
  local socket = require("socket")
  udp = socket.udp()

  if udp:setsockname("", 80) then
    print ("Connected to host")
    udp:send(newData)
  else 
    print("Not connected to host")
  end

  print("New Frame: ", newData)
end




getFrame()
