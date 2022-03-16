--[[
	Coder: CrystalMods (uploader: TOXIC MODS)
	Version: 1.1
	Game: Payback 2
	Desc: Payback 2 ICE menu
]]
function Menu()
	CH = gg.choice({
		"📀Speed Menu v1.0📀",
		"😍Give Grenades😍",
		"🙃Give C4s🙃",
		"🛡Give Laser🛡",
		"😂Win Level😂",
		"📛Exit📛"
	},nil,"🛡😜ICE MENU v1.1😜🛡")
	if CH==1 then spd() end
	if CH==2 then rl() end
	if CH==3 then c4() end
	if CH==4 then ls() end
	if CH==5 then win() end
	if CH==6 then os.exit() end
end
function spd()
CH = gg.choice({
'☺Speed x50☺',
'☺Speed x100☺',
'☺Speed x500☺',
'😐Exit😐'}
,nil,"😔Speed Menu v1.0😌")
if CH==1 then
gg.setSpeed(50)
end
if CH==2 then
gg.setSpeed(100)
end
if CH==3 then
gg.setSpeed(500)
end
end
function rl()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your grenade ammo')
	if gg.getResultCount() == 0 then
		gg.toast("Can't find the ammo")
	else
		gg.setValues({{
			address = t[1].address + 0x4,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		gg.toast('Grenade ammo ON')
	end
end
function c4()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your sticky bomb ammo')
	if gg.getResultCount() == 0 then
		gg.toast("Can't find the ammo")
	else
		gg.setValues({{
			address = t[1].address + 0x8,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		gg.toast('C4 ammo ON')
	end
end
function ls()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your laser ammo')
	if gg.getResultCount() == 0 then
		gg.toast("Can't find the ammo")
	else
		gg.setValues({{
			address = t[1].address + 0xC,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		gg.toast('Laser ammo ON')
	end
	tmp = nil
end
function win()
	gg.setRanges(gg.REGION_ANONYMOUS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put one of your weapon ammo (the original ICE Menu dev told that all ammo can work, this might wrong)')
	if gg.getResultCount() == 0 then
		gg.toast("Can't find the ammo")
	else
		gg.setValues({{
			address = t[1].address + 0x14,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		gg.toast('Level Win ON')
	end
end

function loopSearch(dsrdRsltCnt,valType,msg1)
	local num1,t = gg.prompt({msg1})
	if (num1 and num1[1]) then
		gg.searchNumber(num1[1],valType,nil,nil)
		if gg.getResultCount() > 0 then
			while gg.getResultCount() > dsrdRsltCnt do
				tmp = gg.getResultCount()
				gg.toast('3 seconds to change ammo value')
				gg.sleep(3e3)
				num1 = gg.prompt({'Put your weapon ammo\nfound '..tmp},{num1[1]})
				if not (num1 and num1[1]) then break end
				gg.refineNumber("0~32767")
				gg.refineNumber(num1[1])
				tmp = gg.getResultCount()
				return gg.getResults(dsrdRsltCnt)
			end
		end
	end
end

while true do
	if gg.isVisible() then
		gg.setVisible(false)
		Menu()
	end
end
