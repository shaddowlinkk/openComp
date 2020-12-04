local comp = require("component")
local react= comp.list("br_reactor")
local reactor = comp.br_reactor
local m = comp.modem
local gpu = comp.gpu 
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
function getTotal()
  local eng = comp.list("energy_device")
  local max=0
  local cur=0
  for addr, type in eng do
    local cell = comp.proxy(addr)
    cur= cur+cell.getEnergyStored()
    max=max+cell.getMaxEnergyStored()
  end
    cur =cur+reactor.getEnergyStored()
    max=max+10000000
  return cur,max
end

while true do
  local cur,max = getTotal()
  if (reactor.getActive()) then
    if(cur >= (max*.99)) then
      reactor.setActive(false)
    end
  else
    if (cur <= (max*.01)) then
      reactor.setActive(true)
    end
  end
  m.broadcast(123, cur.."|"..max)
  disp(cur,max)
end  