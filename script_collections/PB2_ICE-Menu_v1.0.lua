--main code
--Coder: TOXIC MODS
--Version: 1.0
--Game: Payback 2
--Desc: Payback 2 ice menu
function spd()
myMenu = gg.choice({
'☺Speed x50☺',
'☺Speed x100☺',
'☺Speed x500☺',
'😐Exit😐'}
,nil,"😔Speed Menu v1.0😌")
if myMenu==1 then
gg.setSpeed(50)
end
if myMenu==2 then
gg.setSpeed(100)
end
if myMenu==3 then
gg.setSpeed(500)
end
if myMenu==4 then
gg.alert('Script coded by: TOXIC MODS')
os.exit()
end
if myMenu==nil then end
end
function rl()
local gg = gg
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("20", gg.TYPE_DWORD)
gg.alert('Change Ammo to: 16, 10 seconds')
gg.sleep(10000)
gg.refineNumber("16", gg.TYPE_DWORD)
x = gg.getResults(1)
local y = {}
y[1] = {}
y[1].address = x[1].address + 0x4
y[1].flags = gg.TYPE_FLOAT
y[1].value = 1
gg.setValues(y)
gg.clearResults()
gg.toast('Grenades: ON')
end
function cFour()
local gg = gg
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("16", gg.TYPE_DWORD)
gg.alert('Change value to: 10, 10 seconds')
gg.sleep(10000)
gg.refineNumber("10", gg.TYPE_DWORD)
e = gg.getResults(1)
local v = {}
v[1] = {}
v[1].address = e[1].address + 0x8
v[1].flags = gg.TYPE_FLOAT
v[1].value = 1
gg.setValues(v)
gg.clearResults()
gg.toast('C4: ON')
end
function ls()
local gg = gg 
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("10", gg.TYPE_DWORD)
gg.alert('Change value to: 6, 10 seconds')
gg.sleep(10000)
gg.refineNumber("6", gg.TYPE_DWORD)
owo = gg.getResults(1)
local uwu = {}
uwu[1] = {}
uwu[1].address = owo[1].address + 0xC
uwu[1].flags = gg.TYPE_FLOAT
uwu[1].value = 1
gg.setValues(uwu)
gg.clearResults()
gg.toast('Laser: ON')
end
function win()
local gg = gg
gg.setRanges(gg.REGION_ANONYMOUS)
stpOne = gg.prompt({'ENTER AMMO'},{[1] = '0'},{[1] = 'number'})
gg.searchNumber(stpOne[1], gg.TYPE_DWORD)
gg.alert('10 seconds to change value')
gg.sleep(10000)
stpTwo = gg.prompt({'ENTER NEW VALUE'},{[1] = '0'},{[1] = 'number'})
sop = gg.refineNumber(stpTwo[1], gg.TYPE_DWORD)
local e = {}
e[1] = {}
e[1].address = sop[1].address + 0x14
e[1].flags = gg.TYPE_FLOAT
e[1].value = 1
gg.setValues(e)
gg.clearResults()
gg.toast('Level Won:ON')
end
function stop()
gg.alert('Thank you for using this script: please sub to TOXIC MODS')
gg.toast('Script by: TOXIC MODS')
os.exit()
end
menu = gg.choice({
  "📀Speed Menu v1.0📀",
  "😍Give Grenades😍",
  "🙃Give C4s🙃",
  "🛡Give Laser🛡",
  "😂Win Level😂",
  "📛Exit📛"
  },nil,"🛡😜ICE MENU v1.0😜🛡")
  if menu==1 then
  spd()
  end
  if menu==2 then
  rl()
  end
  if menu==3 then
  cFour()
  end
  if menu==4 then
  ls()
  end
  if menu==5 then
  win()
  end
  if menu==5 then
  stop()
  end
  if menu==nil then end
