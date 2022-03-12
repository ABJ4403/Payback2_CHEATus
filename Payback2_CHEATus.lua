-- (pre)Define local variables (can possibly improve performance according to lua-users.org wiki) --
local gg,susp_file,cfg_file,tmp,revert,memBuffer,memOffset,isStillOpen,t,CH,ShowMenu,VAL_PstlSgKnckbck,VAL_CrDfltHlth,VAL_DmgIntnsty,VAL_WallResist,VAL_BigBody = gg,gg.getFile()..'.suspend',gg.getFile()..'.conf',{},{},{},{},{},true

-- Cheat menus --
function MENU()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Weapon ammo",
		"2. Wall Hack",
		"3. Strong veichle",
		"4. No blast damage",
		"5. Pistol/SG Knockback",
		"---\nOther cheats:",
		"6. God modes",
		"7. Client-side cheats",
		"8. Incompatible cheats",
		"---",
		string.format("Settings"),
		string.format("__about__"),
		string.format("__exit__"),
		string.format("Suspend")
	},nil,string.format("Title_Version"))
	if CH == 1 then cheat_weaponammo()
	elseif CH == 2 then cheat_wallhack()
	elseif CH == 3 then cheat_strongveichle()
	elseif CH == 4 then cheat_noblastdamage()
	elseif CH == 5 then cheat_pistolknockback()
---Title:Othercheat..
	elseif CH == 7 then cheat_godmode()
	elseif CH == 8 then MENU_CSD()
	elseif CH == 9 then MENU_incompat()
---
	elseif CH == 11 then MENU_settings()
	elseif CH == 12 then show_about()
	elseif CH == 13 then exit()
	elseif CH == 14 then suspend() end
	CH = nil
	if type(tmp) == "table" then
	--This will clear tmp without creating memory garbage (doing tmp={} adds more memory garbage, try print({}) in Lua interpreter, you will see "table: 0xXXXXXXXXXXXX", that will be always different address)
	--well... assuming if the type is string lol
		for i in pairs(tmp) do tmp[i] = nil end
	else
		tmp = {}
	end
--Now collectgarbage can have an easy time to clear all that crap
	collectgarbage("collect")
end
function MENU_CSD()
--Let the user choose stuff
	local CH = gg.choice({
		"Client-side cheats\nSome cheats won't affect other people, it's only applied to you",
		"1. Walk animation Wonkyness (client-side only)",
		"2. Change Name (EXPERIMENTAL)",
		"3. Change Name Color (EXPERIMENTAL)",
		"4. Burning body", -- is this considered cosmetic? kinda not, coz it makes you 'immortal' too, but incompat lol.
		"5. Big body",
		"6. Colored trees",
		"7. Big Flamethrower (Item)",
		"8. Shadows",
		"9. Colored People's (ESP)",
		"10. Reflection Graphics",
		"11. Explosion Power",
		"12. Delete All Names",
		"---",
		string.format("__back__")
	},nil,string.format("Title_Version"))
--Title:CSD...
	if CH == 2 then cheat_walkwonkyness()
	elseif CH == 3 then cheat_changeplayername()
	elseif CH == 4 then cheat_changeplayernamecolor()
	elseif CH == 5 then cheat_firebody()
	elseif CH == 6 then cheat_bigbody()
	elseif CH == 7 then cheat_coloredtree()
	elseif CH == 8 then cheat_bigflamethroweritem()
	elseif CH == 9 then cheat_shadowfx()
	elseif CH == 10 then cheat_clrdpplsp()
	elseif CH == 11 then cheat_reflectiongraphics()
	elseif CH == 12 then cheat_explodepower()
	elseif CH == 13 then cheat_deleteingameplaytext()
---
	elseif CH == 15 then MENU() end
end
function MENU_incompat()
--Let the user choose stuff
	local CH = gg.choice({
		"Incompatible cheats (below PB2 v2.104.12.4/GG v101.0)\nThese cheats isn't compatible with the latest version of PB2. searching these will result in values not found, especially those that isnt located in CAlloc,Anonymous,Other,CodeApp\nSome of them are from ICE menu",
		"1. void mode",
		"2. Destroy all veichles",
		"3. Change XP",
		"4. Win Level",
		"5. Give Grenades",
		"6. Give C4s",
		"7. Give Laser",
		"---",
		string.format("__back__")
	},nil,string.format("Title_Version"))
--Title:CSD...
	if CH == 2 then cheat_togglevoidmode()
	elseif CH == 3 then cheat_destroycar()
	elseif CH == 4 then cheat_xpmodifier()
	elseif CH == 5 then cheat_win()
	elseif CH == 6 then cheat_givegrenade()
	elseif CH == 7 then cheat_givec4()
	elseif CH == 8 then cheat_givelaser()
---
	elseif CH == 10 then MENU() end
end
function MENU_settings()
--Let the user choose stuff
	local CH = gg.choice({
		"Change default player name",
		"Change default custom player name",
		"Change language",
		"---",
		"Clear results",
		"Clear list items",
		"Clear results & list items",
		"Remove suspend file",
		"---",
		"Save settings",
		"Reset settings",
		string.format("__back__")
	},nil,string.format("Title_Version"))
	if CH == 12 then MENU()
	elseif CH == 1 then
		local CH = gg.prompt({'Put your new default player name'},{cfg.PlayerCurrentName},{'text'})
		if (CH and CH[1]) then cfg.PlayerCurrentName = CH[1] end
		CH = nil
		MENU_settings()
	elseif CH == 2 then
		local CH = gg.prompt({'Put your new default custom player name'},{cfg.PlayerCustomName},{'text'})
		if (CH and CH[1]) then cfg.PlayerCustomName = CH[1] end
		CH = nil
		MENU_settings()
	elseif CH == 3 then
		if cfg.Language == "en_US" then tmp = 1
		elseif cfg.Language == "in" then tmp = 2
		elseif cfg.Language == "auto" then tmp = 3 end
		local CH = gg.choice({
			"🇺🇸️ English",
			"🇮🇩️ Indonesia",
			"Auto-detect (uses GameGuardian API, will use English as fallback if your language didn't exist)",
			string.format("__back__"),
		},tmp,string.format("Title_Version"))
		if CH then
			if CH == 4 then MENU_settings()
			elseif CH == 1 then cfg.Language = "en_US"
			elseif CH == 2 then cfg.Language = "in"
			elseif CH == 3 then cfg.Language = "auto" end
			update_language()
			MENU_settings()
		end
	---
	elseif CH == 5 then gg.clearResults() MENU_settings()
	elseif CH == 6 then gg.clearList() MENU_settings()
	elseif CH == 7 then gg.clearResults() gg.clearList() MENU_settings()
	elseif CH == 8 then os.remove(susp_file) MENU_settings()
	---
	elseif CH == 10 then
		gg.saveVariable(cfg,cfg_file)
		toast("your current settings is saved")
		MENU_settings()
	elseif CH == 11 then
		cfg = {
			enableLogging=false,
			Language="auto",
			PlayerCurrentName=":Player",
			PlayerCustomName=":CoolFoe",
			removeSuspendAfterRestoredSession=true,
			VERSION=cfg.VERSION
		}
		toast("your current settings was reset.\n- If you accidentally reset the settings, interrupt the script using the floating stop button and relaunch then script.\n- If you sure to reset, save the setting")
		MENU_settings()
	end
end
--[[
	A little note before looking at the cheat mechanics:
	On newer version of the game, now it stores data mostly on OTHER region (with the rest of the data stored in Calloc, and CodeApp),
	old version uses Ca,Ch,Jh,A (C++Alloc,C++Heap,JavaHeap,Anonymous)
	And also the previous value that is fail when tested, will fail even if you change memory region and still use same value
]]
function cheat_godmode()
--Let the user choose stuff
	local CH = gg.multiChoice({
		"1. Weapon Ammo (No Freeze)",
		"2. Weapon Ammo (Freeze)",
		"3. Rel0ad Pistol,SG,Rocket,C4s",
		"4. Rel0ad Grenade",
		"5. Immortality ON",
		"6. Immortality (Self-explode)",
		"7. C4 Drawing ON",
		"8. Speed Slide ON",
		"9. Float Hack ON",
		"10. Ragdoll Hack ON",
		"11. Anti-Burn body",
		"12. Burned body",
		"13. Burning body",
		"---",
		"14. Clone player",
		"---",
		"15. Rel0ad OFF",
		"16. Immortality OFF",
		"17. C4 Drawing OFF",
		"18. Speed Slide OFF",
		"19. Float Hack OFF",
		"20. Ragdoll Hack OFF",
		"21. Normal body",
		"---",
		string.format("__back__")
	},nil,"God modes (idk wut to call this)\n\nWARNING:\n- DO NOT USE THIS TO ABUSE OTHER PLAYER!!! (eg. killing them continously)\n- DO NOT PvP with non-cheater!!\n- If you play 2P, only do it in isolated area")
	if CH then
	--last option 21 + separator 3 + shift 1
		if CH[25] then MENU() end
		gg.setRanges(gg.REGION_OTHER | gg.REGION_ANONYMOUS)
		local anchorAddress = findAnchor20('Put one of your weapon ammo')
		if not anchorAddress then
			toast('Can\'t find the weapon you\'re holding, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			t = {}
			tmp.nca = anchorAddress
			if (CH[1] or CH[2]) then
				tmp.a = {
					{address=tmp.nca+0x1C,name="Pb2Chts [Weapon]: Shotgun"},
					{address=tmp.nca+0x1E,name="Pb2Chts [Weapon]: Rocket"},
					{address=tmp.nca+0x20,name="Pb2Chts [Weapon]: Flamethrower"},
					{address=tmp.nca+0x22,name="Pb2Chts [Weapon]: Grenade"},
					{address=tmp.nca+0x24,name="Pb2Chts [Weapon]: Minigun"},
					{address=tmp.nca+0x26,name="Pb2Chts [Weapon]: Explosives"},
					{address=tmp.nca+0x28,name="Pb2Chts [Weapon]: Turret"},
					{address=tmp.nca+0x2A,name="Pb2Chts [Weapon]: Laser"},
				}
				for i=1,#tmp.a do
					tmp.a[i].flags = gg.TYPE_WORD
					tmp.a[i].freeze = CH[2]
					tmp.a[i].value = 3e4
				end
			--Todo: add the word flag using forloop, if ch2 loop freeze, if ch3 loop unfreeze
				t = ConcatTable(t,tmp.a)
			end
			if CH[3] then t = ConcatTable(t,{
				{address=tmp.nca+0x84,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Rel0adTimer]: Default"}
			})
			end
			if CH[4] then
				tmp.a = {{address=tmp.nca+0x84,flags=gg.TYPE_WORD,freeze=true,name="Pb2Chts [Rel0adTimer]: Grenade"}}
				local grenadeRange = gg.prompt({"Put your grenade range\nHold your grenade if you use this setting\nignore the throw range and disables delay by setting this to 0 [0;100]"},{0},{"number"})
				if (grenadeRange and grenadeRange[1] ~= "0") then
					toast("Wait for it, dont forget to hold your grenade")
					sleep(999)
					tmp.a[1].value = grenadeRange[1]
					gg.setValues(t)
					gg.addListItems(t)
					sleep(999)
				end
				tmp.a[1].value = -63
				t = ConcatTable(t,tmp.a)
			end
			if CH[5] then t = ConcatTable(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=true,value=800,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=true,value=9,name="Pb2Chts [RespawnInterval] (Immortal)"}
			})
			end
			if CH[6] then t = ConcatTable(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=true,value=3e4,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_WORD,freeze=true,value=1,name="Pb2Chts [RespawnInterval] (Immortal Self-explode)"}
			})
			end
			if CH[7] then t = ConcatTable(t,{
				{address=tmp.nca+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4Position]: X"},
				{address=tmp.nca+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4Position]: Y"}
			})
			end
			if CH[8] then t = ConcatTable(t,{
				{address=tmp.nca+0x86,flags=gg.TYPE_WORD,value=300,freeze=true,name="Pb2Chts [SpeedSlide]"}
			})
			end
			if CH[9] then t = ConcatTable(t,{
				{address=tmp.nca-0x408,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [Float]"}
			})
			end
			if CH[10] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [Ragdoll]"},
				{address=tmp.nca+0x128,flags=gg.TYPE_DWORD,value=0,freeze=true,freezeType=gg.FREEZE_IN_RANGE,freezeFrom=0,freezeTo=120,name="Pb2Chts [Ragdoll]"}
			})
			end
			if CH[11] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Antiburn"},
			})
			end
			if CH[12] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Firebody"},
			})
			end
			if CH[13] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=99,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Burning"},
			})
			end
			---
			if CH[15] then
		--This will clone the player (you). How this is done?
		--First told user (you) to change the weapon to your loved weapon before the user cant do it anymore
			toast("[Clone Player] Change your weapon to your wanted weapon before you can\'t change it anymore")
			sleep(3e3)
		--Then, make the game think you are dead by changing 0xXXXXXXDA to 2000 (Wasted)
			tmp.a = {
				{address=tmp.nca+0xDA,flags=gg.TYPE_WORD,value=2e3}
			}
			gg.setValues(tmp.a)
			gg.addListItems(tmp.a)
			sleep(2e3)
		--And change it back to 512 so you can control it too :D
			t = ConcatTable(t,{
				{address=tmp.nca+0xDA,flags=gg.TYPE_WORD,value=512,freeze=true,name="Pb2Chts [ControlState]"}
			})
			end
			---
			if CH[17] then t = ConcatTable(t,{
				{address=tmp.nca+0x84,flags=gg.TYPE_WORD,freeze=false,name="Pb2Chts [Rel0adTimer]"}
			})
			end
			if CH[18] then t = ConcatTable(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=false,value=999,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=false,name="Pb2Chts [RespawnInterval] (Immortal)"}
			})
			end
			if CH[19] then t = ConcatTable(t,{
				{address=tmp.nca+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: X"},
				{address=tmp.nca+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: Y"}
			})
			end
			if CH[20] then t = ConcatTable(t,{
				{address=tmp.nca+0x86,flags=gg.TYPE_WORD,freeze=false,name="Pb2Chts [SpeedSlide]"}
			})
			end
			if CH[21] then t = ConcatTable(t,{
				{address=tmp.nca-0x408,flags=gg.TYPE_DWORD,value=0,freeze=false,name="Pb2Chts [Float]"}
			})
			end
			if CH[22] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,name="Pb2Chts [Ragdoll]"},
				{address=tmp.nca+0x128,flags=gg.TYPE_DWORD,value=65536,freeze=false,name="Pb2Chts [Ragdoll]"}
			})
			end
			if CH[23] then t = ConcatTable(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,name="Pb2Chts [BodyBurningStateAndTimer]: Normal"},
			})
			end
			gg.setValues(t)
			gg.addListItems(t)
			gg.clearResults()
			toast('Selected options opreation done\nWARN: Don\'t Drive/getoutof car, respawn, or get out of match')
		end
	end
end
function cheat_weaponammo()
	local CH = gg.choice({
		"1. DWORD (works by changing match settings. Requires respawn, works best in offline mode)",
		"2. Automatic (Mangyu method, old version)",
		"3. Automatic (v2, not work because dynamic memory stuff)",
		string.format("__back__")
	},nil,"Select method for modifying Weapon Ammo")
--gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS
	gg.setRanges(gg.REGION_OTHER | gg.REGION_ANONYMOUS)
	if CH == 6 then MENU()
	elseif CH == 1 then
		CH = gg.prompt({'Put all of your weapon ammo, divide each using ";"\neg. 100;200;..whatever\nbut i recommend diving each with ";0W;" instead (for more accuracy)'})
		if (CH and CH[1]) then
			tmp = 0xB6730000
			gg.searchNumber(CH[1]..":29",gg.TYPE_DWORD,nil,nil,tmp+0x3C4,tmp+0x4E0)
			gg.getResults(16)
			if gg.getResultCount() == 0 then
				toast("Can't find the said number, did you put the right number?")
			else
				gg.editAll(9999,gg.TYPE_DWORD)
				toast("Now respawn yourself (Pause,end,respawn,yes), to get the desired number")
			end
		end
	elseif CH == 2 then
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61",gg.TYPE_DWORD)
		local t = gg.getResults(999,nil,nil,nil,nil,nil,gg.TYPE_DWORD)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			for i=1,#t do
				t[i].value = 71131136
				t[i].freeze = true
			end
			gg.setValues(t)
			t = nil
			gg.clearResults()
			toast("Weapon ON")
		end
	elseif CH == 3 then
	--For modularity (just in case coz I know there's memory issue whatever stuff)
		tmp = 0xC2274300
	--set the cheated weapons
		gg.setValues({
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xC4,name="Pb2Chts [Weapon,1P] Shotgun"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xC8,name="Pb2Chts [Weapon,1P] Rocket"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xCC,name="Pb2Chts [Weapon,1P] Flamethower"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xD0,name="Pb2Chts [Weapon,1P] Grenade"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xD4,name="Pb2Chts [Weapon,1P] Machine Gun"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xD8,name="Pb2Chts [Weapon,1P] Explosives"},
			{flags=gg.TYPE_DWORD,value=9999,address=tmp+0xDC,name="Pb2Chts [Weapon,1P] Turret"},
			{flags=gg.TYPE_DWORD,value=999,address=tmp+0xE0,name="Pb2Chts [Weapon,1P] Laser"} -- Laser amount will be -1 if the number is >999
		})
	end
	gg.clearResults()
end
function cheat_firebody()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	},nil,"Burning body")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={9999,0,"ON"}
		elseif CH == 2 then tmp={0,9999,"OFF"} end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber('1.68155816e-43F;'..tmp[1]..'D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45',gg.TYPE_DWORD)
		local t = gg.getResults(555,nil,nil,nil,nil,nil,gg.TYPE_DWORD)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			for i=1,#t do
				t[i].value = tmp[2]
				t[i].freeze = true
			end
			gg.setValues(t)
			gg.clearResults()
			toast("Burning body "..tmp[3])
		end
	end
end
function cheat_pistolknockback()
	local CH = gg.choice({
		"Grapple gun/Pull (-20)",
		"Knockback/Push (20)",
		"Default (0.25)",
		"None (0.00001)",
		"Custom",
		"---",
		"Change current Knockback variable",
		"Restore previous value",
		"Clear memory buffer",
		string.format("__back__")
	},nil,"Pistol/Shotgun knockback modifier\nCurrent: "..VAL_PstlSgKnckbck.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH then
		if CH == 10 then MENU()
		elseif CH == 1 then PISTOL_KNOCKBACK_VALUE = -20
		elseif CH == 2 then PISTOL_KNOCKBACK_VALUE = 20
		elseif CH == 3 then PISTOL_KNOCKBACK_VALUE = 0.25
		elseif CH == 4 then PISTOL_KNOCKBACK_VALUE = 1e-5
		elseif CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if (CH and CH[1]) then
				PISTOL_KNOCKBACK_VALUE = CH[1]
			else
				cheat_pistolknockback()
			end
		---
		elseif CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = VAL_PstlSgKnckbck},{[1] = 'number'})
			if (CH and CH[1]) then VAL_PstlSgKnckbck = CH[1] end
			cheat_pistolknockback()
		elseif CH == 8 then
			revert.PistolKnockback = nil
			cheat_pistolknockback()
		elseif CH == 9 then
			memBuffer.PistolKnockback = nil
			cheat_pistolknockback()
		end
		if PISTOL_KNOCKBACK_VALUE then
		-- | gg.REGION_ANONYMOUS
			gg.setRanges(gg.REGION_C_ALLOC)
			if not memBuffer.PistolKnockback then
				toast('No buffer found, creating new buffer')
		 -- Find specific value
				gg.searchNumber(VAL_PstlSgKnckbck.."F;1067869798D::13",gg.TYPE_FLOAT,false,gg.SIGN_EQUAL)
		 -- Get float-type-only result, and make a backup.
				memBuffer.PistolKnockback,revert.PistolKnockback = gg.getResults(1,nil,nil,nil,nil,nil,gg.TYPE_FLOAT),gg.getResults(1,nil,nil,nil,nil,nil,gg.TYPE_FLOAT)
			else
				toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(memBuffer.PistolKnockback)
			end
	 -- Check if found any result
			if gg.getResultCount() == 0 then
				memBuffer.PistolKnockback,revert.PistolKnockback = nil,nil
				toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i=1,#memBuffer.PistolKnockback do
					memBuffer.PistolKnockback[i].value = PISTOL_KNOCKBACK_VALUE
				end
				VAL_PstlSgKnckbck = PISTOL_KNOCKBACK_VALUE
				PISTOL_KNOCKBACK_VALUE = nil
				toast("Pistol/SG Knockback "..VAL_PstlSgKnckbck)
				gg.setValues(memBuffer.PistolKnockback)
			end
			gg.clearResults()
		end
	end
end
function cheat_wallhack()
	local CH = gg.choice({
		"ON (GKTV, wonky physics, fast to enable, survives multiple match, and can wallhack other entities not just a wall)",
		"ON (AGH, physics works best. need to reapplied every match, takes some time)",
		"ON (Hydra, for old version, unknown disabilities)",
		"OFF (GKTV)",
		"OFF (AGH, Not recommended if buffer is empty)",
		"OFF (Hydra)",
		"---",
		"Restore previous value",
		"Use custom value",
		"Clear memory buffer",
		string.format("__back__")
	},nil,"Wall Hack. Warn:\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for CTS in Metropolis, because there\'s less holes there")
	if CH then
		if CH == 11 then MENU()
 -- Set ranges
		elseif CH == 1 then tmp={1,{"3472W;5W;1e-3F;14979W::11","2W;16256W;1e-3F;14979W::7",1e-3},VAL_WallResist[2],"ON"}
		elseif CH == 2 then tmp={2,"1140457472D;500F::",VAL_WallResist[1],"ON"}
		elseif CH == 3 then tmp={3,"1078618499;1094412911;1;1034868570;1050796852::493",VAL_WallResist[3],"ON"}
		elseif CH == 4 then tmp={1,{"3472W;5W;"..VAL_WallResist[2].."F;-16512W::15","2W;16256W;"..VAL_WallResist[2].."F;-16512W::7",VAL_WallResist[2]},1e-3,"OFF"}
		elseif CH == 5 then tmp={2,VAL_WallResist[1],1140457472,"OFF"}
		elseif CH == 6 then tmp={3,"1078618499;1094412911;"..VAL_WallResist[3]..";1034868570;1050796852::493",1,"OFF"}
		---
		elseif CH == 8 then
			gg.setValues(revert.wallhack)
			gg.setValues(revert.wallhack_gktv)
			gg.setValues(revert.wallhack_hydra)
			revert.wallhack,revert.wallhack_gktv,revert.wallhack_hydra = nil,nil,nil
			toast("Previous value restored, be warned though this will cause instability")
			cheat_wallhack()
		elseif CH == 9 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default:1140457472,Cheatus default:-500)',
				'Put your custom value for Alternative method (Game default:0.001,Cheatus default:-1.00001)',
				'Put your custom value for Hydra method (Game default:1,Cheatus default:-1)'
			},{VAL_WallResist[1],VAL_WallResist[2],VAL_WallResist[3]},{'number','number','number'})
			if CH then
				if CH[1] ~= "" then VAL_WallResist[1] = CH[1] end
				if CH[2] ~= "" then VAL_WallResist[2] = CH[2] end
				if CH[3] ~= "" then VAL_WallResist[3] = CH[3] end
			end
			CH = nil
			cheat_wallhack()
		elseif CH == 10 then
			CH,memBuffer.wallhack,memBuffer.wallhack_gktv = nil,nil,nil
			toast("Memory buffer cleared")
			cheat_wallhack()
		end
		if tmp then
			if tmp[1] == 1 then
				gg.setRanges(gg.REGION_CODE_APP)
				if not memBuffer.wallhack_gktv then
					toast('No previous memory buffer found, creating new buffer.')
					gg.searchNumber(tmp[2][1])
					gg.refineNumber(tmp[2][3],gg.TYPE_FLOAT)
					tmp[5] = gg.getResults(1)
					gg.clearResults()
					gg.searchNumber(tmp[2][2])
					gg.refineNumber(tmp[2][3],gg.TYPE_FLOAT)
					tmp[5] = {tmp[5][1],gg.getResults(1)[1]}
					memBuffer.wallhack_gktv,revert.wallhack_gktv = tmp[5],tmp[5]
				else
					toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				end
				gg.loadResults(memBuffer.wallhack_gktv)
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					for i=1,#memBuffer.wallhack_gktv do
						memBuffer.wallhack_gktv[i].value = tmp[3]
					end
					gg.setValues(memBuffer.wallhack_gktv)
					gg.clearResults()
					toast("Wall Hack "..tmp[4])
				end
			elseif tmp[1] == 2 then
				gg.setRanges(gg.REGION_C_ALLOC)
				if not memBuffer.wallhack then
					toast('No previous memory buffer found, creating new buffer.')
					gg.searchNumber(tmp[2])
					memBuffer.wallhack,revert.wallhack = gg.getResults(50,nil,nil,nil,nil,nil,gg.TYPE_DWORD),gg.getResults(50,nil,nil,nil,nil,nil,gg.TYPE_DWORD)
				else
					toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
					gg.loadResults(memBuffer.wallhack)
					gg.getResults(50,nil,nil,nil,nil,nil,gg.TYPE_DWORD)
				end
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					for i=1,#memBuffer.wallhack do
						memBuffer.wallhack[i].value = tmp[3]
					end
					gg.setValues(memBuffer.wallhack)
					gg.clearResults()
					toast("Wall Hack "..tmp[3])
				end
			elseif tmp[1] == 3 then
				gg.setRanges(gg.REGION_OTHER)
				if not memBuffer.wallhack_hydra then
					toast('No previous memory buffer found, creating new buffer.')
					gg.searchNumber(tmp[2],gg.TYPE_DWORD)
					gg.refineNumber(1)
					memBuffer.wallhack_hydra,revert.wallhack_hydra = gg.getResults(40),gg.getResults(40)
				else
					toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
					gg.loadResults(memBuffer.wallhack_hydra)
					gg.getResults(40)
				end
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					for i=1,#memBuffer.wallhack_hydra do
						memBuffer.wallhack_hydra[i].value = tmp[3]
					end
					gg.setValues(memBuffer.wallhack_hydra)
					gg.clearResults()
					toast("Wall Hack "..tmp[3])
				end
			end
		end
	end
end
function cheat_bigbody()
	local CH = gg.choice({
		"ON (Default, based on Mangyu original script)",
		"ON (Alternative, client-side only. affects everyone you see, not just you)",
		"OFF (Default)",
		"OFF (Alternative)",
		"Restore previous value",
		"Use custom value",
		string.format("__back__")
	},nil,"Big body")
	if CH then
		local t
		if CH == 7 then MENU()
		elseif CH == 1 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber(1+memOffset.BigBody[1],gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert.bigbody = gg.getResults(555)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i=1,#t do
					t[i].value = VAL_BigBody[1]+memOffset.BigBody[1]
					t[i].freeze = true
				end
				toast("Big Body ON")
			end
			gg.setValues(t)
		elseif CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber(4.3+memOffset.BigBody[2],gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert.bigbody = gg.getResults(22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(VAL_BigBody[2]+memOffset.BigBody[2],gg.TYPE_FLOAT)
				toast("Big Body ON")
			end
		elseif CH == 3 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber(VAL_BigBody[1]+memOffset.BigBody[1],gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert.bigbody = gg.getResults(555)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i=1,#t do
					t[i].value = 1+memOffset.BigBody[1]
					t[i].freeze = true
				end
				toast("Big body OFF")
			end
			gg.setValues(t)
		elseif CH == 4 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber(VAL_BigBody[2]+memOffset.BigBody[2],gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert.bigbody = gg.getResults(22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(4.3+memOffset.BigBody[2],gg.TYPE_FLOAT)
				toast("Big body OFF")
			end
		elseif CH == 5 then
			if not revert.bigbody then
				toast("No values to restore, this might be a bug. if you think so, report bug on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.setValues(revert.bigbody)
				revert.bigbody = nil
				gg.clearResults()
				toast("Big body previous value restored")
			end
		elseif CH == 6 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default: 1,Cheatus default: 3, offset: '..memOffset.BigBody[1]..')',
				'Put your custom value for Alternative method (Game default: 4.3,Cheatus default: 5.9, offset: '..memOffset.BigBody[2]..')'
			},{
				[1] = VAL_BigBody[1],
				[2] = VAL_BigBody[2]
			},{
				[1] = 'number',
				[2] = 'number'
			})
			if CH then
				if CH[1] ~= "" then VAL_BigBody[1] = CH[1] end
				if CH[2] ~= "" then VAL_BigBody[2] = CH[2] end
			end
			CH = nil
			cheat_bigbody()
		end
		t = nil
		gg.clearResults()
	end
end
function cheat_strongveichle()
	local CH = gg.choice({
		"ON (85000)",
		"OFF (125)",
		"Destroy (-1)",
		"Custom",
		"---",
		"Change current health variable",
		"Restore previous value",
		"Clear memory buffer",
		string.format("__back__")
	},nil,"Veichle default health modifier")
	if CH then
		if CH == 9 then MENU()
		elseif CH == 1 then CAR_HEALTH_VALUE = 85e3
		elseif CH == 2 then CAR_HEALTH_VALUE = 125
		elseif CH == 3 then CAR_HEALTH_VALUE = -1
		elseif CH == 4 then
			local CH = gg.prompt({'Input your custom Veichle default health value'})
			if (CH and CH[1]) then
				CAR_HEALTH_VALUE = CH[1]
			else
				cheat_strongveichle()
			end
		---
		elseif CH == 6 then
			local CH = gg.prompt({'If you think the current Veichle default health value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Veichle default health value'},{[1] = VAL_CrDfltHlth},{[1] = 'number'})
			if (CH and CH[1]) then VAL_CrDfltHlth = CH[1] end
			cheat_strongveichle()
		elseif CH == 7 then
			CH,revert.CarHealth = nil,nil
			cheat_strongveichle()
		elseif CH == 8 then
			CH,memBuffer.CarHealth = nil,nil
			cheat_strongveichle()
		end
		if CAR_HEALTH_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
			if not memBuffer.CarHealth then
				toast('No buffer found, creating new buffer')
				gg.searchNumber(VAL_CrDfltHlth.."D;4D;1F::21")
				gg.refineNumber(VAL_CrDfltHlth,gg.TYPE_DWORD)
				memBuffer.CarHealth,revert.CarHealth = gg.getResults(50),gg.getResults(50)
			else
				toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(memBuffer.CarHealth)
			end
			if gg.getResultCount() == 0 then
				memBuffer.CarHealth,revert.CarHealth = nil,nil
				toast("Can't find the specific set of number. if you changed the veichle health value, and reopened the script, restore the actual current number using 'Change current health variable' menu")
			else
				for i=1,#memBuffer.CarHealth do
					memBuffer.CarHealth[i].value = CAR_HEALTH_VALUE
				end
				VAL_CrDfltHlth,CAR_HEALTH_VALUE = CAR_HEALTH_VALUE,nil
				toast("Veichles default health "..VAL_CrDfltHlth)
				gg.setValues(memBuffer.CarHealth)
			end
			gg.clearResults()
		end
	end
end
function cheat_noblastdamage()
	local CH = gg.choice({
		"ON (0)",
		"OFF (300)",
		"Custom",
		"---",
		"Change current damage value",
		"Restore previous value",
		"Clear memory buffer",
		string.format("__back__")
	},nil,"No damage\nThis will make you unable to get killed using any explosion blasts (that means you still can get killed by sg,mg,laser,turret,any non explosive weapons)\nPS: this will make your character buggy though")
	if CH then
		if CH == 8 then MENU()
		elseif CH == 1 then DAMAGE_INTENSITY_VALUE = 0
		elseif CH == 2 then DAMAGE_INTENSITY_VALUE = 300
		elseif CH == 3 then
			local CH = gg.prompt({'Input your custom damage intensity'})
			if (CH and CH[1]) then
				DAMAGE_INTENSITY_VALUE = CH[1]
			else
				cheat_noblastdamage()
			end
		---
		elseif CH == 5 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{[1] = VAL_DmgIntnsty},{[1] = 'number'})
			if (CH and CH[1]) then VAL_DmgIntnsty = CH[1] end
			cheat_noblastdamage()
		elseif CH == 6 then
			CH,revert.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		elseif CH == 7 then
			CH,memBuffer.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		end
		if DAMAGE_INTENSITY_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
			if not memBuffer.NoBlastDamage then
				toast('No buffer found, creating new buffer')
				gg.searchNumber("-7264W;10W;-5632W;"..VAL_DmgIntnsty.."F;17302W::9")
				gg.refineNumber(VAL_DmgIntnsty,gg.TYPE_FLOAT)
				memBuffer.NoBlastDamage,revert.NoBlastDamage = gg.getResults(9),gg.getResults(9)
			else
				toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(memBuffer.NoBlastDamage)
			end
			if gg.getResultCount() == 0 then
				memBuffer.NoBlastDamage,revert.NoBlastDamage = nil,nil
				toast("Can't find the specific set of number. if you changed the blast intensity value and reopened the script, restore the actual current number using 'Change current damage value' menu")
			else
				for i=1,#memBuffer.NoBlastDamage do
					memBuffer.NoBlastDamage[i].value = DAMAGE_INTENSITY_VALUE
				end
				VAL_DmgIntnsty,DAMAGE_INTENSITY_VALUE = DAMAGE_INTENSITY_VALUE,nil
				toast("Blast damage intensity "..VAL_DmgIntnsty)
				gg.setValues(memBuffer.NoBlastDamage)
			end
			gg.clearResults()
		end
	end
end
function cheat_destroycar()
	local CH = gg.choice({
		"ON",
		"OFF",
		string.format("__back__")
	},nil,"Destroy cars")
	if CH then
		gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		if CH == 3 then MENU()
		elseif CH == 1 then
			gg.searchNumber("0.89868283272;0.91149836779;0.92426908016;0.93699574471;0.9496794343;0.9623208046;0.97492086887;0.98748034239;1;1.01248061657;1.02492284775;1.03732740879;1.04969501495;1.06202638149;1.07432198524;1.08658242226;1.09880852699;1.11100065708;1.12315940857;1.1352853775;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109",gg.TYPE_FLOAT)
			gg.refineNumber(1)
			gg.getResults(50)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(-500,gg.TYPE_FLOAT)
				toast("Destroy all cars ON")
			end
		elseif CH == 2 then
			gg.searchNumber("0.89868283272;-500;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109",gg.TYPE_FLOAT)
			gg.refineNumber(-500)
			gg.getResults(50)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(1,gg.TYPE_FLOAT)
				toast("Destroy all cars OFF")
			end
		end
		gg.clearResults()
	end
end
function cheat_togglevoidmode()
	local CH = gg.choice({
		"Default (not work for now due to memory address issue)",
		"Joker method (only works on older version)",
		string.format("__back__")
	},nil,"Void mode, select method")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then
			gg.setValues({
				{flags=gg.TYPE_DWORD,value=99,address=0xC20FC36C,name="Pb2Chts [Mode]: 1P"},
				{flags=gg.TYPE_DWORD,value=99,address=0xC1EBB47C,name="Pb2Chts [Mode]: 2P"},
				{flags=gg.TYPE_DWORD,value=99,address=0xC20FC3A0,name="Pb2Chts [AIDifficulty]"},
				{flags=gg.TYPE_DWORD,value=99,address=0xC20FC38C,name="Pb2Chts [CopsIntensity]"},
				{flags=gg.TYPE_DWORD,value=99,address=0xC132A8B8,name="Pb2Chts [TimeLimit]"}
			})
			toast('void mode is set. to restore, simply change to any mode you desire')
		elseif CH == 2 then
			gg.setRanges(gg.REGION_ANONYMOUS)
			gg.searchNumber(38654705671,gg.TYPE_QWORD)
			gg.getResults(100)
			gg.editAll(38654705673)
			toast('void mode is set. to restore, simply change to any mode you desire\nnote again that this only works on old version')
		end
	end
end
function cheat_xpmodifier()
--CAlloc for the gameplay and actual google play value
--Anonymous from joker video
--OTHER for the Chat and Displayed XP
--Won't affect stored xp (aka. temporary)
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
--request user to give player name
	local player_xp = gg.prompt({
		'Put your current XP (make sure that your XP value is differentiateable, because there\'s no looping thingy method yet.)',
		'Put new XP (Google Play Game limit is 999999, while the DWORD limit is 1.999.999.998)',
		'Freeze'
	},{},{
		[1]="number",
		[2]="number",
		[3]="checkbox"
	})
	if CH then
 -- Search current player xp
		gg.searchNumber(player_xp[1],gg.TYPE_DWORD)
		t,revert.PlayerXP = gg.getResults(10),gg.getResults(10)
 -- Check if found or not
		if gg.getResultCount() == 0 then
			toast('Can\'t find the player xp, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
	 -- and put the new XP
			for i=1,#t do
				t[i].value = player_xp[2]
				t[i].freeze = player_xp[3]
				t[i].name = "Pb2Chts [PlayerCurrentXP]"
			end
			gg.setValues(t)
			gg.clearResults()
			toast('"'..player_xp[1]..'" changed to "'..player_xp[2]..'"\nWarn: this is still in experimentation phase, the xp wont applied permanently, it will get reset to original. to chnage it permanently, you have to modify the .sav data, which is impossible because its encrypted')
		end
	end
end
function cheat_changeplayername()
	gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_OTHER)
--request user to give player name
	local player_name = gg.prompt({
		'Put your current player name (case-sensitive, ":" or ";" is required at the beginning, because how GameGuardian search works)',
		'Put new player name (cannot be longer than current name, you can change color/add icon by converting to hex and use hex 1-9 for color)'
	},{
		VAL_PlayerCurrentName,
		cfg.PlayerCustomName
	},{
		"number",
		"number"
	})
--search old player name
	if (player_name and player_name[1] and player_name[1] ~= ":") then
		gg.searchNumber(player_name[1],gg.TYPE_BYTE)
		revert.PlayerName = gg.getResults(5e3)
		if gg.getResultCount() == 0 then
			toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			gg.editAll(player_name[2],gg.TYPE_BYTE)
			VAL_PlayerCurrentName = player_name[2]
			gg.clearResults()
			toast('"'..player_name[1]..'" changed to "'..player_name[2]..'"\nWarn: this is still in experimentation phase, the name might only apply on your client and not others')
		end
	end
end
function cheat_changeplayernamecolor()
	gg.setRanges(gg.REGION_OTHER)
--request user to give player name
	local CH,player_name,player_color_choice = gg.choice({
		"Color:",
		"Invisible name (all values 1 byte, Experimental)",
		"Red (2)",
		"Blue (3)",
		"White (4)",
		"Yellow (5,9)",
		"Green (6h)",
		"---",
		"Icon (more will be added later...):",
		"Coin (7h)",
		"White people (8h)",
		"Corrupted (10h)",
		"---",
		"None (remove every color and icon)",
		"---",
		string.format("__back__")
	},nil,"Select the color you want (Experimental)"),gg.prompt({'Put your current player name (case-sensitive)'},{VAL_PlayerCurrentName},{'text'})
	if (CH or player_name and player_name[1] and player_name[1] ~= ":") then
	--Color
		if CH == 2 then player_color_choice = 1
		elseif CH == 3 then player_color_choice = 2
		elseif CH == 4 then player_color_choice = 3
		elseif CH == 5 then player_color_choice = 4
		elseif CH == 6 then player_color_choice = 5
		elseif CH == 7 then player_color_choice = 6
	---
	--Icon
		elseif CH == 10 then player_color_choice = 7
		elseif CH == 11 then player_color_choice = 8
		elseif CH == 12 then player_color_choice = 10
	---
		elseif CH == 14 then player_color_choice = 0
	---
		elseif CH == 16 then MENU() end

		if player_color_choice then
		--search old player name
			gg.searchNumber(player_name[1],gg.TYPE_BYTE)
		--fetch result,make backup result,make some temporary stuff
			local t,tmp0,removeOffset = gg.getResults(5e3),0,0x0
			revert.PlayerName = gg.getResults(5e3)
		--generic found stuff
			if gg.getResultCount() == 0 then
				toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
			else
			--if player color chioce was 0 (none), interpret that as request remove colors
				if player_color_choice == 0 then
					for i=1,#t do
					--if within the custom color/icon range
						if (t[i].value >= 0 and t[i].value < 20) then
						--remove it
							t[i] = nil
							removeOffset = removeOffset + 0x1
						else
						--and -removeOffset for the rest
							tmp0 = t[i].address
							t[i].address = tmp0 - removeOffset
							t[i].freeze = false
							t[i].flags = gg.TYPE_BYTE
						end
					end
			--else (colors ranging from 2-9)
				else
				--this is where the problem arises, you know that the player names might me more than 1?, will this vvv work? probably not, mostly.
				--1. shift all addreses
					for i=1,#t do
						tmp0 = t[i].address
						t[i].address = tmp0 + 0x1
						t[i].freeze = false
						t[1].flags = gg.TYPE_BYTE
					end
				--2. add value whatever
					table.insert(t,1,{})
					t[1].address = t[2].address - 0x1
					t[1].freeze = false
					t[1].flags = gg.TYPE_BYTE
					t[1].value = player_color_choice
				end
				gg.setValues(t)
				toast('Color set to '..player_color_choice..'. PS: still in experimental phase, might not work')
			end
			tmp0 = nil
		end
	end
end
function cheat_walkwonkyness()
	local CH = gg.choice({
		"Default (0.004)",
		"ON (1)",
		"OFF (0)",
		"Restore",
		string.format("__back__")
	},nil,"Walk Wonkyness (fancy-cheat)")
	if CH then
		gg.setRanges(gg.REGION_CODE_APP)
		if CH == 5 then MENU()
		elseif CH == 1 then
			gg.searchNumber("0~1;0.00999999978::5",gg.TYPE_FLOAT)
			revert.walkwonkyness = gg.getResults(1)
			gg.editAll(0.004,gg.TYPE_FLOAT)
			toast("Walk Wonkyness Default")
		elseif CH == 2 then
			gg.searchNumber("0.004;0.00999999978::5",gg.TYPE_FLOAT)
			revert.walkwonkyness = gg.getResults(1)
			gg.editAll(1.004,gg.TYPE_FLOAT)
			toast("Walk Wonkyness ON")
		elseif CH == 3 then
			gg.searchNumber("1.004;0.00999999978::5",gg.TYPE_FLOAT)
			revert.walkwonkyness = gg.getResults(1)
			gg.editAll(0,gg.TYPE_FLOAT)
			toast("Walk Wonkyness OFF")
		end
		gg.clearResults()
	end
end
function cheat_coloredtree()
	local CH = gg.choice({
		"ON",
		"OFF",
		string.format("__back__")
	},nil,"Colored trees\nThis will change some shader stuff (actually idk wut this does lol) that affects trees")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={0.04,-999,"ON"}
		elseif CH == 2 then tmp={-999,0.04,"OFF"} end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber("4.06176449e-39;0.06;"..tm0[1]..";-0.04;-0.02::17",gg.TYPE_FLOAT)
		gg.refineNumber(tmp[1])
		local t = gg.getResults(1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			gg.clearResults()
			toast("Colored trees "..tm0[3])
		end
	end
end
function cheat_bigflamethroweritem()
	local CH = gg.choice({
		"ON",
		"OFF",
		string.format("__back__")
	},nil,"Big flamethrower (Item)\nInfo: this will not make the flame burst bigger")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={0.9,5.1403,"ON"}
		elseif CH == 2 then tmp={5.1403,0.9,"OFF"} end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber("0.4;0.2;"..tmp[1]..";24000::13",gg.TYPE_FLOAT)
		gg.refineNumber(tmp[1])
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			gg.clearResults()
			toast("Big flamethrower "..tmp[3])
		end
	end
end
function cheat_shadowfx()
	local CH = gg.choice({
		"OFF",
		"ON",
		string.format("__back__")
	},nil,"Shadow effects\nInfo: this wont affect your game performance at all (not making it lag/fast)\ndont use this for performance purpose :)")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={1e-4,-1.0012,"Disabled"}
		elseif CH == 2 then tmp={-1.0012,1e-4,"Enabled"} end
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp[1]..";-5.96152076e27;-2.55751098e30;-1.11590087e28;-5.59128595e24:17",gg.TYPE_FLOAT)
		gg.refineNumber(tmp[1],gg.TYPE_FLOAT)
		revert.shadow = gg.getResults(1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			gg.clearResults()
			toast("Shadow "..tmp[3])
		end
	end
end
function cheat_clrdpplsp()
	local CH = gg.choice({
		"ON",
		"OFF",
		string.format("__back__")
	},nil,"Colored people ESP (ExtraSensoryPerception. i guess this is X-Ray Hack)\nPS: Not work on latest version")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={0.08,436,"ON"}
		elseif CH == 2 then tmp={436,0.08,"OFF"} end
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp[1],gg.TYPE_FLOAT)
		revert.clrdpplsp = gg.getResults(9)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			gg.addListItems(revert.clrdpplsp)
			gg.clearResults()
			toast("Colored people ESP "..tmp[3])
		end
	end
end
function cheat_deleteingameplaytext()
	gg.setRanges(gg.REGION_C_ALLOC)
	tmp = {
		"Toasted",
		"Wasted",
		"Nuked",
		"Drowned",
		"OBLITERATED",
		"Your team won",
		"You scored",
		"You finished",
		"You team scored",
		"DEFEND",
		"STEAL",
		"BASE",
		"SPLATTERED",
		"DELIVER",
		"DOMINATE",
		"CAPTURE",
		"KILL"
	}
	for i=1,#tmp do
		gg.searchNumber(":"..tmp[i],gg.TYPE_BYTE)
		gg.getResults(99)
		gg.editAll(0,gg.TYPE_BYTE)
		gg.clearResults()
	end
	toast("In-gameplay-text cleared, to restore, you have to restart the game\nPS: This might not work, idk why though..")
end
function cheat_reflectiongraphics()
	local CH = gg.choice({
		"ON (1)",
		"OFF (49)",
		"Restore previous value",
		string.format("__back__")
	},nil,"Reflection graphics\nWARNING: this can cause rendering issue that is irreversible and requires restart to fix it\nDont forget to disable this before you get out of match\ni only recommend using this in offline mode so you can easily disable the reflection graphics before getting out of match")
	if CH then
		gg.setRanges(gg.REGION_OTHER)
		if CH == 4 then MENU()
		elseif CH == 1 then tmp={49,1,"ON"}
		elseif CH == 2 then tmp={1,49,"OFF"} end
		if tmp[3] then
			if not memBuffer.rtxgraphics then
				gg.toast('No previous memory buffer found, creating new buffer.')
				gg.searchNumber("144;"..tmp[1]..";50::9",gg.TYPE_DWORD)
				gg.refineNumber(tmp[1])
				memBuffer.rtxgraphics,revert.rtxgraphics = gg.getResults(1),gg.getResults(1)
			else
				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(memBuffer.rtxgraphics)
			end
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				memBuffer.rtxgraphics[1].value = tmp[2]
				toast("Reflection Graphics "..tmp[3])
				gg.setValues(memBuffer.rtxgraphics)
			end
		elseif CH == 3 then
			if not revert.rtxgraphics then
				toast("No values to restore, this might be a bug. if you think so, report bug on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.setValues(revert.rtxgraphics)
				revert.rtxgraphics = nil
				gg.clearResults()
				toast("Reflection Graphics previous value restored")
			end
		end
		t = nil
		gg.clearResults()
	end
end
function cheat_explodepower()
	local CH = gg.choice({
		"Modify Explosion power",
		"---",
		"Change current Explosion power",
		"Restore previous value",
		"Clear memory buffer",
		string.format("__back__")
	},nil,"Explosion power modifier\nCurrent: "..VAL_XplodePowr.."\n")
	if CH then
		if CH == 5 then MENU()
		elseif CH == 1 then
			local CH = gg.prompt({'Put your explosion power. Lower is more powerful\nSet to -1 to disable explosion\n PS:only applies to you'},{VAL_XplodePowr},{'number'})
			if (CH and CH[1]) then
				EXPLOSION_POWER = CH[1]
			else
				cheat_explodepower()
			end
		---
		elseif CH == 3 then
			local CH = gg.prompt({'If you think the current explosion power is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current explosion power'},{[1] = VAL_PstlSgKnckbck},{[1] = 'number'})
			if (CH and CH[1]) then VAL_XplodePowr = CH[1] end
			cheat_explodepower()
		elseif CH == 4 then
			revert.ExplodePower = nil
			cheat_explodepower()
		elseif CH == 5 then
			memBuffer.ExplodePower = nil
			cheat_explodepower()
		end
		if EXPLOSION_POWER then
			gg.setRanges(gg.REGION_CODE_APP)
			if not memBuffer.ExplodePower then
				toast('No buffer found, creating new buffer')
				gg.searchNumber("15120W;"..VAL_XplodePowr.."F::3")
				gg.refineNumber(VAL_XplodePowr,gg.TYPE_FLOAT)
				memBuffer.ExplodePower,revert.ExplodePower = gg.getResults(1),gg.getResults(1)
			else
				toast('Previous result found, using previous result.')
				gg.loadResults(memBuffer.ExplodePower)
			end
			if gg.getResultCount() == 0 then
				memBuffer.ExplodePower,revert.ExplodePower = nil,nil
				toast("Can't find the specific set of number. if you changed the explosion power and reopened the script, restore current number using 'Change current explosion power' menu")
			else
				memBuffer.ExplodePower[1].value,VAL_XplodePowr,EXPLOSION_POWER = EXPLOSION_POWER,EXPLOSION_POWER,nil
				toast("Explosion power modified to "..VAL_XplodePowr)
				gg.setValues(memBuffer.ExplodePower)
			end
			gg.clearResults()
		end
	end
end
function cheat_givegrenade()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your grenade ammo')
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number')
	else
		gg.setValues({{
			address = t[1].address + 0x4,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		toast('Grenade ammo ON')
	end
end
function cheat_givec4()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your sticky bomb ammo')
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number')
	else
		gg.setValues({{
			address = t[1].address + 0x8,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		toast('C4 ammo ON')
	end
end
function cheat_givelaser()
	gg.setRanges(gg.REGION_C_BSS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put your laser ammo')
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number')
	else
		gg.setValues({{
			address = t[1].address + 0xC,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		toast('Laser ammo ON')
	end
	tmp = nil
end
function cheat_win()
	gg.setRanges(gg.REGION_ANONYMOUS)
	t = loopSearch(1,gg.TYPE_DWORD,'Put one of your weapon ammo (the original ICE Menu dev told that all ammo can work, this might wrong)')
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number')
	else
		gg.setValues({{
			address = t[1].address + 0x14,
			flags = gg.TYPE_FLOAT,
			value = 1
		}})
		gg.clearResults()
		toast('Level Win ON')
	end
end
function show_about()
	local CH = gg.choice({
		string.format("__about__"),
		"---",
		string.format("Disclaimmer"),
		string.format("License"),
		string.format("Credits"),
		string.format("__back__")
	},nil,string.format("__about__"))
	if CH == 1 then alert(string.format("About_Text")) show_about()
	---
	elseif CH == 3 then alert(string.format("Disclaimmer_Text")) show_about()
	elseif CH == 4 then alert(string.format("License_Text")) show_about()
	elseif CH == 5 then alert(string.format("Credits_Text")) show_about()
	elseif CH == 6 then CH = nil MENU() end
end

-- Helper functions --
table.merge=function(...)
	--[[
		merge 2 tables, just like Object.assign on JS
		first table will be replaced by new table...
		recommended only on object-like tables, but not on array-like tables
	]]
	local r = {}
	for _,t in ipairs{...} do
		for k,v in pairs(t) do
			r[k] = v
		end
	end
	return r
end
function exit()
	isStillOpen=false
	gg.saveVariable(cfg,cfg_file)
	gg.clearResults()
	print(string.format("Exit_ThankYouMsg"))
	os.exit()
end
function suspend()
	isStillOpen=false
	gg.saveVariable({
		revert=revert,
		memBuffer=memBuffer,
		cfg=cfg
	},susp_file)
	print(string.format("Suspend_Text"))
	os.exit()
end
function ConcatTable(t1,t2)
	--[[
		Creates new table then
		add table 1 and table 2
	]]
	for i=1,#t2 do
		t1[#t1+i] = t2[i]
	end
	return t1
end
function loopSearch(desiredResultCount,valueType,msg1,restrictedMemArea)
	local num1,t = gg.prompt({msg1})
	restrictedMemArea = restrictedMemArea or {}
	if (num1 and num1[1]) then
	--Search within restricted memory address, which can be faster
		gg.searchNumber(num1[1],valueType,nil,nil,restrictedMemArea[1],restrictedMemArea[2])
		if gg.getResultCount() > 0 then
			while gg.getResultCount() > desiredResultCount do
				tmp = gg.getResultCount()
				if (cfg.cheatSettings.loopSearch.useFuzzyDecrease and tonumber(num1[1]) > 20) then
					toast('Got '..tmp..' results\n3 seconds to reduce ammo value')
					sleep(999)
					toast('Got '..tmp..' results\n2 seconds to reduce ammo value')
					sleep(999)
					toast('Got '..tmp..' results\n1 seconds to reduce ammo value')
					sleep(999)
					toast('Timeout, searching...')
					gg.refineNumber("0~32767")
					gg.searchFuzzy(0,gg.SIGN_FUZZY_LESS)
				else
				--old method:ask user their current ammo
				--because mostly the ammo will go down, we should use fuzzy and dont ask user about ammo anymore (but theres a bug with searchFuzzy itself, it wouldnt found anything AT ALL COST IF USED IN SCRIPT!!!)
					toast('3 seconds to change ammo value')
					sleep(999)
					toast('2 seconds to change ammo value')
					sleep(999)
					toast('1 seconds to change ammo value')
					sleep(999)
					num1 = gg.prompt({'Put your weapon ammo\nCurrently found: '..tmp},{num1[1]})
					if not (num1 and num1[1]) then break end
					gg.refineNumber("0~32767")
					gg.refineNumber(num1[1])
				end
			--If found 2 result, check if 2 numbers are same, and return 1st value if so (this means user is on a veichle)
				tmp = gg.getResultCount()
				if tmp == 2 then
					t = gg.getResults(2)
					if t[1].value == t[2].value then
						return {t[1]}
					end
			--If nothing found...
				elseif tmp == 0 then
					if not restrictedMemArea[1] then
					--If fail but have restricted memory, try again with no restriction
						break
					else
					--else break and return nothing, and let the 0 handler did its job
						tmp = {}
						toast("Oh, this is weird 🤔️... We don't find the value you're searching for 🔍️. We will try again, but without memory restriction")
						return loopSearch(desiredResultCount,valueType,msg1)
					end
				end
			end
			return gg.getResults(desiredResultCount)
		end
	end
end
function findAnchor20(msg)
	gg.setRanges(gg.REGION_OTHER | gg.REGION_ANONYMOUS)
	if cfg.cheatSettings.findAnchor20.searchMethod == "holdWeapon" then
		toast("Hold your pistol")
		sleep(2e3)
		gg.searchNumber(13,gg.TYPE_WORD,nil,nil,cfg.memZones.HldWpn[1],cfg.memZones.HldWpn[2])
		t = gg.getResults(200)
		while gg.getResultCount() > 1 do
			toast("Hold your knife")
			sleep(2e3)
			gg.refineNumber(0)
			t = gg.getResults(200)
			if gg.getResultCount() == 1 then break
			elseif gg.getResultCount() == 0 then return
			elseif gg.getResultCount() == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then
					t = {t[1]}
					break
				end
			end
			toast("Hold your pistol")
			sleep(2e3)
			gg.refineNumber(13)
			t = gg.getResults(200)
			if gg.getResultCount() == 0 then return
			elseif gg.getResultCount() == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then
					t = {t[1]}
					break
				end
			end
		end
		t = t[1].address
		gg.clearResults()
		gg.searchNumber(20,gg.TYPE_WORD,nil,nil,t - 0x18,t - 0x18)
		if gg.getResultCount() > 0 then return gg.getResults(1)[1].address end
	elseif cfg.cheatSettings.findAnchor20.searchMethod == "useWordWeaponAmmo" then
		t = loopSearch(1,gg.TYPE_WORD,msg,cfg.memZones.WpnAmmWrd)
		if gg.getResultCount() == 0 then return end
		t = t[1]
		t.value = 3e4
		gg.setValues({t})
		gg.clearResults()
		gg.searchNumber(20,gg.TYPE_WORD,nil,nil,t.address - 0x2A,t.address)
		if gg.getResultCount() > 0 then return gg.getResults(1)[1].address end
	else
		toast("An error occured: Exit out of script for more details.")
		print("[Error]: Configuration \"cfg.cheatSettings.findAnchor20.searchMethod\" is invalid.\n         Please set it to right value\n         Possible values: useWordWeaponAmmo, holdWeapon\n         You set the value to "..cfg.cheatSettings.findAnchor20.searchMethod.."\n         Your Configuration:\n"..cfg)
		return
	end
end
function update_language()
	--[[
		Parse language strings...
	]]
	if cfg.Language == "auto" then
 -- Only English and Indonesian are supported (for now)
		curr_lang = gg.getLocale()
		if curr_lang ~= "in" then
			curr_lang = "en_US"
		end
	else
		curr_lang = cfg.Language
	end
end
function loadConfig()
	--[[
		Loads configuration file.
	]]
	cfg = {
		cheatSettings={
			noreload={
				displayFallback=false,
				useSearch20=true
			},
			c4paint={
				useSearch20=true
			},
			loopSearch={
				useFuzzyDecrease=false
			},
			findAnchor20={
				searchMethod="holdWeapon"
			}
		},
		memZones={
			WpnAmmWrd={0xB000051C,0xCD0FFD2A},
			HldWpn={0xB0000518,0xCDFFFD18}
		},
		Language="auto",
		PlayerCurrentName=":Player",
		PlayerCustomName=":CoolFoe",
		removeSuspendAfterRestoredSession=true,
		VERSION="2.0.6"
	}
--unfortunately, alot of people had problem with my script if i put memory restriction on. if you are experiencing the same thing, change the memZones in the .conf file from {????????;????????;} to {0;-1;}
	local cfg_load = loadfile(cfg_file)
	if cfg_load then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = table.merge(cfg,cfg_load)
	else
		toast("No configuration files detected, Creating new one... 💾️\nHi There! 👋️ Looks like You're new here.")
		gg.saveVariable(cfg,cfg_file)
	end
	VAL_PlayerCurrentName = cfg.PlayerCurrentName
	update_language()
end
function restoreSuspend()
	--[[
		Restore current session from suspend file and remove it afterwards
	]]
	local susp = loadfile(susp_file)
	if susp then
		toast(string.format("Suspend_Detected"))
		susp = susp()
		cfg = susp.cfg
		revert = susp.revert
		memBuffer = susp.memBuffer
		if cfg.removeSuspendAfterRestoredSession then
			os.remove(susp_file)
		end
	end
	susp = nil
end

-- Initialization --
--generic functions
alert = function(str,...)
	gg.alert(string.format(str),...)
end
toast = function(str,fastmode)
	if fastmode == nil then fastmode = true end
	gg.toast(str,fastmode)
end
sleep = gg.sleep
VAL_PstlSgKnckbck=0.25
VAL_CrDfltHlth=125
VAL_DmgIntnsty=300
VAL_WallResist={-500,-1e-5,-1}
VAL_BigBody={3,5.9}
VAL_XplodePowr=10000000
memOffset={
	BigBody={0.09500002861,0.00000019073}
}

-- Load settings and languages
loadConfig()

-- Initialize language
local lang = {
en_US={
Automatic				 = "Automatic",
About_Text			 = "Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number, even cheat menu which didnt show any numbers at all). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes",
Credits					 = "Credits",
Credits_Text		 = "Credit:\n+ Mangyu - Original script\n+ mdp43140 - Contributor\n+ tehtmi - unluac Creator (and decompile helper).\n+ Crystal_Mods100x - ICE Menu\n+ Latic AX and ToxicCoder - for providing removed script through YT & MediaFire.\n+ Alpha GG Hacker - Wall Hack & Car Health GameGuardian Values\n+ GKTV (Pumpkin Hacker) - Payback2 GG script.\n+ Joker - for providing No Blast Damage and No Reload GameGuardian Values.",
Disclaimmer			 = "Disclaimmer (please read)",
Disclaimmer_Text = "DISCLAIMMER:\n	Please DO NOT misuse the script to abuse other players.\n	I'm NOT RESPONSIBLE for your action with using this script.\n	Remember to keep your patience out of other players.\n	i recommend ONLY using this script in offline mode.\n	I made this because no one would share their cheat script.",
Exit_ThankYouMsg = "	If you experienced a bug, report it on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues\n	If you have something to ask, you can start a discussion at https://github.com/ABJ4403/Payback2_CHEATus/discussions\n	If you want to know more about this cheat, or other FAQ stuff, go to https://github.com/ABJ4403/Payback2_CHEATus/wiki",
License					 = "License",
License_Text		 = "Payback2 CHEATus, Cheat LUA Script for GameGuardian\n© 2021-2022 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.	If not, see https://gnu.org/licenses",
Settings				 = "Settings",
Suspend					 = "Suspend",
Suspend_Detected = "Suspend file detected, continuing from suspend...",
Suspend_Text		 = "You quit the program through suspend option. you can continue your current session by relaunching the script, If you restart the game, previous session wont be useful (Launch script and select exit, or remove the suspend file to purge suspended session)",
Title_Version		 = "Payback2 CHEATus v"..cfg.VERSION..", by ABJ4403."
},
['in']={
Automatic				 = "Otomatis",
About_Text			 = "Payback2 CHEATus, dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini?\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak membagikan skrip cheat mereka sama sekali. Tentu ini melanggar filosofi open-source, kita perlu melihat sumber kode untuk memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim (banyak sensor stiker/teks/zoom-in, speedup, apalagi sesuatu yang berkaitan dengan alamat memory, atau ya... nomor apapun, bahkan menu cheat yang tidak menampilkan nomor sama sekali). Bahkan jika ia memberikan tautan unduhan dari satu cheat (hack wall),\nitu masih proprietri, saya tidak dapat membaca sumber kode satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang",
Credits					 = "Kredit",
Credits_Text		 = "Kredit:\n+ Mangyu - Pembuat skrip original.\n+ mdp43140 - Kontributor.\n+ tehtmi - Pembuat unluac (dan helper dekompilasi).\n+ Crystal_Mods100x - Menu ICE\n+ Latic AX dan ToxicCoder - untuk menyediakan skrip yang telah dihapus melalui YT & MediaFire.\n+ Alpha GG Hacker - Values Wall Hack & Car Health GameGuardian \n+ GKTV (Pumpkin Hacker) - Skrip GG Payback2.\n+ Joker - Value No Blast Damage & No Reload GameGuardian.",
Disclaimmer			 = "Disklaimmer (mohon untuk dibaca)",
Disclaimmer_Text = "DISKLAIMMER:\n	TOLONG JANGAN menyalahgunakan skrip ini untuk menjahili pemain lain.\n	Saya TIDAK BERTANGGUNG JAWAB atas kerusakan yang anda sebabkan karena MENGGUNAKAN skrip ini.\n	Ingat untuk menjaga kesabaran anda dari pemain lain.\n	Saya merekomendasikan menggunakan skrip ini HANYA di mode offline.\n	Saya membuat ini karena tidak ada orang lain yang membagikan skrip cheat mereka.",
Exit_ThankYouMsg = "	Jika Anda mengalami bug, laporkan pada laman GitHub saya: https://github.com/ABJ4403/Payback2_CHEATus/issues\n	Jika Anda memiliki sesuatu untuk ditanyakan, Anda dapat memulai diskusi di https://github.com/ABJ4403/Payback2_CHEATus/discussions\n	Jika Anda ingin tahu lebih banyak tentang cheat ini, atau hal-hal FAQ lainnya, kunjungi https://github.com/ABJ4403/Payback2_CHEATus/wiki",
License					 = "Lisensi",
License_Text		 = "Payback2 CHEATus, Cheat Skrip LUA untuk GameGuardian\n© 2021-2022 ABJ4403\n\nProgram ini adalah perangkat lunak gratis: Anda dapat mendistribusikan kembali dan/atau memodifikasi\ndi bawah ketentuan lisensi publik umum GNU seperti yang diterbitkan oleh\nFree Software Foundation, baik lisensi versi 3, atau\n(pada opsi Anda) versi yang lebih baru.\n\nProgram ini didistribusikan dengan harapan bahwa itu akan berguna,\nTETAPI TANPA GARANSI; bahkan tanpa garansi tersirat dari\nMERCHANTABILITY atau FITNESS untuk tujuan tertentu.	Lihat\nGNU Lisensi Publik Umum untuk detail lebih lanjut.\n\nAnda seharusnya menerima salinan Lisensi Publik Umum GNU\nbersama dengan program ini. Jika tidak, lihat https://gnu.org/licenses",
Settings				 = "Pengaturan",
Suspend					 = "Suspensi",
Suspend_Detected = "File suspensi terdeteksi, melanjutkan dari suspensi...",
Suspend_Text		 = "Anda keluar dari program melalui opsi suspensi. Anda bisa melanjutkan sesi saat ini dengan meluncurkan skrip ini, Jika anda memulai ulang game, sesi sebelumya tidak akan berguna (Luncurkan skrip dan pilih keluar, atau hapus file suspensi untuk membuang sesi suspensi)",
Title_Version		 = "Payback2 CHEATus v"..cfg.VERSION..", oleh ABJ4403."
}
}
string.format2=string.format
string.format=function(input,...)
	local predefinedLanguages = {
		"Automatic",
		"About_Text",
		"Credits",
		"Credits_Text",
		"Disclaimmer",
		"Disclaimmer_Text",
		"Exit_ThankYouMsg",
		"License",
		"License_Text",
		"Settings",
		"Suspend",
		"Suspend_Detected",
		"Suspend_Text",
		"Title_Version"
	}
	for i=1,#predefinedLanguages do
		if input == predefinedLanguages[i] then
			return lang[curr_lang][input]
		end
	end
	return string.format2(input,...)
end

-- Restore suspend file if any
restoreSuspend()

--detect if gg gui was open/floating gg icon clicked. if so, close that and run OpenMenu (which will open our menu) instead (dont worry, we have suspend feature now).
ShowMenu = MENU
while isStillOpen do
	if gg.isVisible() then
		gg.setVisible(false)
		ShowMenu()
	end
end
