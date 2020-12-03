local component = require("component")
local event = require("event")

function disp(cur,max,alive)
  gpu.setResolution(23,5)
  gpu.setBackground(0x000000,false)
  gpu.fill(1,1,23,5, " ")
  gpu.setBackground(0x000000,false)
  gpu.set((1),(2),cur.."/"..max.."rf")
  gpu.fill(1,3,23,1, "-")
  local w = math.floor(cur*(23/max),false)
  gpu.setBackground(0xffffff) 
  gpu.fill(1,3,w,1, " ")
end
while true do
  local _, _, from, port, _, message = event.pull("modem_message")
  print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
end