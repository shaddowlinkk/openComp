local comp = require("component")
local react= comp.list("br_reactor")
local reactor = comp.proxy(next(react))
local m = component.modem 
--local eng = comp.list("energy_device")
local gpu = comp.gpu

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

--local address = next(eng)

while true do
  local cur,max = getTotal()
  
  if (reactor.getActive) then	
    if(cur >= (max*.99))then
      reactor.setActive(false)
  end
  elseif (cur <= (max*.01)) then
    reactor.setActive(true)
  end
  m.broadcast(123, cur..."|"...max)
  disp(cur,max)
 --local cell= comp.proxy(address)
 --disp(cell.getEnergyStored(),cell.getMaxEnergyStored())
 -- disp(2,3)
end  