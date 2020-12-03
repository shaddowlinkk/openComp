local component = require("component")
local event = require("event")

local m = component.modem -- get primary modem component
m.open(123)
print(m.isOpen(123))

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
  local _, _, _, _, _, message = event.pull("modem_message")
  local data = split(message,"|")
  print(data[0])
end