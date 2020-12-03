local component = require("component")
local event = require("event")
local gpu = component.gpu
local m = component.modem -- get primary modem component
m.open(123)
print(m.isOpen(123))

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function disp(cur,max)
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
  disp(tonumber(data[1]),tonumber(data[2]))
end