local socket = require ("socket")
udp = socket.udp()
if udp:setsockname("192.168.1.101", 2947) then
	print("Conn")
	udp:settimeout()
  data = udp:receive()
  if data then
    print("Received Data: ", data)
  end
else
	print("Not Conn")
end
