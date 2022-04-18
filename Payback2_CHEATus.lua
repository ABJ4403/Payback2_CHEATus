-- (pre)Define local variables (can possibly improve performance according to lua-users.org wiki) --
local gg,susp_file,cfg_file,tmp,revert,memOzt,memOffset,t,curVal,CH = gg,gg.getFile()..'.suspend',gg.getFile()..'.conf',{},{},{},{},{}
-- Cheat menus --
function MENU()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Wall Hack",
		"2. Strong veichle",
		"3. No blast damage",
		"4. Pistol/SG Knockback",
		"5. Flood Respawn",
		"---\nOther cheats:",
		"6. God modes",
		"7. Client-side cheats",
		"8. Other cheats",
		"---",
		f"Settings",
		f"__about__",
		f"__exit__",
		f"Suspend"
	},nil,f"Title_Version")
	if CH == 1 then cheat_wallhack()
	elseif CH == 2 then cheat_strongveichle()
	elseif CH == 3 then cheat_noblastdamage()
	elseif CH == 4 then cheat_pistolknockback()
	elseif CH == 5 then cheat_floodspawn()
---Title:Othercheat..
	elseif CH == 7 then MENU_godmode()
	elseif CH == 8 then MENU_CSD()
	elseif CH == 9 then MENU_other()
---
	elseif CH == 11 then MENU_settings()
	elseif CH == 12 then show_about()
	elseif CH == 13 then exit()
	elseif CH == 14 then suspend() end
	CH = nil
	if type(tmp)=="table" then for k in pairs(tmp)do tmp[k]=nil end else tmp={}end
end
function MENU_CSD()
--Let the user choose stuff
	local CH = gg.choice({
		"Client-side cheats\nSome cheats won't affect other player",
		"1. Walk animation Wonkyness (client-side only)",
		"2. Change Name (EXPERIMENTAL)",
		"3. Change Name Color (EXPERIMENTAL)",
		"4. Change XP/Coin",
		"5. Explosion Power",
		"6. Explosion Direction",
		"7. Particle interval (Slow/Fast explosion)",
		"8. Reflection Graphics",
		"9. Colored trees",
		"10. Car drift",
		"11. Big body",
		"12. Big Flamethrower (Item)",
		"13. Shadows",
		"14. Colored Peoples (ESP)",
		"15. Delete All Names",
		"---",
		f"__back__"
	},nil,f"Title_Version")
--Title:CSD...
	if CH == 2 then cheat_walkwonkyness()
	elseif CH == 3 then cheat_changeplayername()
	elseif CH == 4 then cheat_changeplayernamecolor()
	elseif CH == 5 then cheat_xpmodifier()
	elseif CH == 6 then cheat_explodepow()
	elseif CH == 7 then cheat_explodedir()
	elseif CH == 8 then cheat_prtclintrvl()
	elseif CH == 9 then cheat_reflectiongraphics()
	elseif CH == 10 then cheat_coloredtree()
	elseif CH == 11 then cheat_cardrift()
	elseif CH == 12 then cheat_bigbody()
	elseif CH == 13 then cheat_bigflamethroweritem()
	elseif CH == 14 then cheat_shadowfx()
	elseif CH == 15 then cheat_clrdpplsp()
	elseif CH == 16 then cheat_deleteingameplaytext()
---
	elseif CH == 18 then MENU() end
end
function MENU_other()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Weapon ammo",
		"2. void mode",
		f"__back__"
	},nil,"Other cheats\nmost of these cheats might be experiment, or uncategorized or whatnot...")
	if CH == 1 then cheat_weaponammo()
	elseif CH == 2 then cheat_voidmatchmode()
	elseif CH == 3 then MENU() end
end
function MENU_settings()
--Let the user choose stuff
	local CH = gg.choice({
		"Change default player name and custom name",
		"Change language",
		"Change entity anchor searching method",
		"---",
		"Clear results",
		"Clear list items",
		"Clear results & list items",
		"Remove suspend file",
		"---",
		"Save settings",
		"Reset settings",
		f"__back__"
	},nil,f"Title_Version")
	if CH == 12 then MENU()
	elseif CH == 1 then
		local CH = gg.prompt({'Put your new default player name','Put your new default custom player name'},{cfg.PlayerCurrentName,cfg.PlayerCustomName},{'text','text'})
		if CH then
			if CH[1] ~= "" then cfg.PlayerCurrentName = CH[1] end
			if CH[2] ~= "" then cfg.PlayerCustomName = CH[1] end
		end
		CH = nil
		MENU_settings()
	elseif CH == 2 then
		if cfg.Language == "en_US" then tmp = 1
		elseif cfg.Language == "in" then tmp = 2
		elseif cfg.Language == "auto" then tmp = 3 end
		local CH = gg.choice({
			"🇺🇸️ English",
			"🇮🇩️ Indonesia",
			"Auto-detect (uses GameGuardian API, will use English as fallback if your language didn't exist)",
			f"__back__",
		},tmp,f"Title_Version")
		if CH then
			if CH == 4 then MENU_settings()
			elseif CH == 1 then cfg.Language = "en_US"
			elseif CH == 2 then cfg.Language = "in"
			elseif CH == 3 then cfg.Language = "auto" end
			update_language()
			MENU_settings()
		end
	elseif CH == 3 then
		tmp = nil
		if cfg.cheatSettings.findEntityAnchr.searchMethod == "wordWeaponAmmo" then tmp = 1
		elseif cfg.cheatSettings.findEntityAnchr.searchMethod == "holdWeapon" then tmp = 2
		elseif cfg.cheatSettings.findEntityAnchr.searchMethod == "mangyuFloatAnchor" then tmp = 3 end
		local CH = gg.choice({
			"1. Use word weapon ammo (simply finds the weapon ammo, slow for low-end phones especially when typing the numbers)",
			"2. Hold Weapon (tell you do hold pistol/knife and find those values, no typing lag involved)",
			"3. Mangyu's float anchor (Hold pistol but dont shoot, have a max health, little bit Hold-Weapon-like. Can't be used on cars, slow, fail sometimes)",
			f"__back__",
		},tmp,f"Title_Version")
		if CH then
			if CH == 5 then MENU_settings()
			elseif CH == 1 then cfg.cheatSettings.findEntityAnchr.searchMethod = "wordWeaponAmmo"
			elseif CH == 2 then cfg.cheatSettings.findEntityAnchr.searchMethod = "holdWeapon"
			elseif CH == 3 then cfg.cheatSettings.findEntityAnchr.searchMethod = "mangyuFloatAnchor" end
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
function MENU_godmode()
--Let the user choose stuff
	local CH = gg.multiChoice({
		"1. Weapon Ammo (No Freeze)",
		"2. Weapon Ammo (Freeze)",
		"3. Rel0ad Pistol,SG,Rocket,C4s",
		"4. Rel0ad Grenade",
		"5. Disable veichle stealing",
		"6. Immortality ON",
		"7. Immortality (Self-explode)",
		"8. C4 Drawing ON",
		"9. Speed Slide ON",
		"10 Float Hack ON",
		"11. Ragdoll Hack ON",
		"12. Anti-Burn body",
		"13. Burned body",
		"14. Burning body",
		"15. Dr0wned",
		"---",
		"16. Clone player",
		"17. Change vehicle color",
		"18. Enable veichle jet",
		"19. Fast car acceleration time",
		"20. Win (known to work on Rampage, others not tested yet)",
		"---",
		"20. Rel0ad OFF",
		"21. Immortality OFF",
		"22. C4 Drawing OFF",
		"23. Speed Slide OFF",
		"24. Float Hack OFF",
		"25. Ragdoll Hack OFF",
		"26. Normal body",
		"27. Normal drowned",
		"28. Disable veichle jet",
		"---",
		f"__back__"
	},nil,"God modes (idk wut to call this)\n\nWARNING:\n- DO NOT USE THIS TO ABUSE OTHER PLAYER!!! (eg. killing them continously)\n- DO NOT PvP with non-cheater!!\n- If you play 2P, only do it in isolated area")
	if CH then
		if CH[32] then MENU() end
		gg.setRanges(gg.REGION_OTHER + gg.REGION_ANONYMOUS)
		local anchorAddress = findEntityAnchr()
		if not anchorAddress then
			toast('Can\'t find the value, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			t = {}
			tmp.nca = anchorAddress
			if CH[1] or CH[2] then
				tmp.a = {
					{address=tmp.nca+0x1C,name="Shotgun"},
					{address=tmp.nca+0x1E,name="Rocket"},
					{address=tmp.nca+0x20,name="Flamethrower"},
					{address=tmp.nca+0x22,name="Grenade"},
					{address=tmp.nca+0x24,name="Minigun"},
					{address=tmp.nca+0x26,name="Explosives"},
					{address=tmp.nca+0x28,name="Turret"},
					{address=tmp.nca+0x2A,name="Laser"},
				}
				for i=1,#tmp.a do
					tmp.a[i].name = "Pb2Chts [Weapon]: "..(tmp.a[i].name)
					tmp.a[i].flags = gg.TYPE_WORD
					tmp.a[i].freeze = CH[2]
					tmp.a[i].value = 3e4
				end
				t = table.append(t,tmp.a)
				tmp.a = nil
			end
			if CH[3] then t = table.append(t,{
				{address=tmp.nca+0x84,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Rel0adTimer]: Default"}
			})
			end
			if CH[4] then
				tmp.a = {{address=tmp.nca+0x84,flags=gg.TYPE_WORD,freeze=true,name="Pb2Chts [Rel0adTimer]: Grenade"}}
				local grenadeRange = gg.prompt({"Put your grenade range\nHold your grenade if you use this setting\nignore the throw range and disables delay by setting this to 0 [0;100]"},{100},{"number"})
				if grenadeRange and grenadeRange[1] and grenadeRange[1] ~= "0" then
					toast("Wait for it")
					tmp.a[1].value = grenadeRange[1]
					gg.setValues({{address=tmp.nca+0x18,flags=gg.TYPE_WORD,value=3,name="Pb2Chts [CurrentlyHoldWeapon]: Grenade"}})
					gg.setValues(t)
					gg.addListItems(t)
					sleep(999)
				end
				tmp.a[1].value = -63
				t = table.append(t,tmp.a)
			end
			if CH[5] then
				tmp.isImmortal = CH[6] and 1 or 0
				t = table.append(t,{
					{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Antiburn"},
					{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=true,value=-501,name="Pb2Chts [Health]"},
					{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=true,value=tmp.isImmortal,name="Pb2Chts [RespawnInterval]"},
				})
				tmp.isImmortal = 0
			elseif CH[6] then t = table.append(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=true,value=800,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=true,value=9,name="Pb2Chts [RespawnInterval] (Immortal)"}
			})
			elseif CH[7] then t = table.append(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=true,value=3e4,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_WORD,freeze=true,value=1,name="Pb2Chts [RespawnInterval] (Immortal Self-explode)"}
			})
			end
			if CH[8] then t = table.append(t,{
				{address=tmp.nca+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4Position]: X"},
				{address=tmp.nca+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4Position]: Y"}
			})
			end
			if CH[9] then t = table.append(t,{
				{address=tmp.nca+0x86,flags=gg.TYPE_WORD,value=300,freeze=true,name="Pb2Chts [SpeedSlide]"}
			})
			end
			if CH[10] then t = table.append(t,{
				{address=tmp.nca-0x408,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [Float]"}
			})
			end
			if CH[11] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [Ragdoll]"},
				{address=tmp.nca+0x128,flags=gg.TYPE_DWORD,value=0,freeze=true,freezeType=gg.FREEZE_IN_RANGE,freezeFrom=0,freezeTo=120,name="Pb2Chts [Ragdoll]"}
			})
			end
			if CH[12] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Antiburn"},
			})
			end
			if CH[13] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Burned"},
			})
			end
			if CH[14] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=99,freeze=true,name="Pb2Chts [BodyBurningStateAndTimer]: Fire"},
			})
			end
			if CH[15] then t = table.append(t,{
				{address=tmp.nca-0x610,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [Dr0wned]"},
			})
			end
			---
			if CH[17] then
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
			t = table.append(t,{
				{address=tmp.nca+0xDA,flags=gg.TYPE_WORD,value=512,freeze=true,name="Pb2Chts [ControlState]"}
			})
			end
			if CH[19] then t = table.append(t,{
				{address=tmp.nca-0x1AC,flags=gg.TYPE_WORD,value=1,name="Pb2Chts [Enable jet]"},
			})
			end
			if CH[20] then
			--the fastest possible value is 1, setting it below 1 will make the veichle acceleration acts very weird
				t = table.append(t,{
					{address=tmp.nca-0x208,flags=gg.TYPE_FLOAT,freeze=true,value=1,name="Pb2Chts [Veichle Speed]"},
					{address=tmp.nca-0x204,flags=gg.TYPE_FLOAT,freeze=true,value=1,name="Pb2Chts [Veichle Speed]"}
				})
			end
			if CH[21] then t = table.append(t,{
				{address=tmp.nca+0x30,flags=gg.TYPE_DWORD,value=9e8,freeze=true,name="Pb2Chts [Win] (remove this after you win match)"},
			})
			end
			---
			if CH[23] then t = table.append(t,{
				{address=tmp.nca+0x84,flags=gg.TYPE_WORD,freeze=false,value=0,name="Pb2Chts [Rel0adTimer]"}
			})
			end
			if CH[24] then t = table.append(t,{
				{address=tmp.nca+0x08,flags=gg.TYPE_WORD,freeze=false,value=999,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=false,value=0,name="Pb2Chts [RespawnInterval] (Immortal)"}
			})
			end
			if CH[25] then t = table.append(t,{
				{address=tmp.nca+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: X"},
				{address=tmp.nca+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: Y"}
			})
			end
			if CH[26] then t = table.append(t,{
				{address=tmp.nca+0x86,flags=gg.TYPE_WORD,freeze=false,value=0,name="Pb2Chts [SpeedSlide]"}
			})
			end
			if CH[27] then t = table.append(t,{
				{address=tmp.nca-0x408,flags=gg.TYPE_DWORD,value=0,freeze=false,value=0,name="Pb2Chts [Float]"}
			})
			end
			if CH[28] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,name="Pb2Chts [Ragdoll]"},
				{address=tmp.nca+0x128,flags=gg.TYPE_DWORD,value=65536,freeze=false,name="Pb2Chts [Ragdoll]"}
			})
			end
			if CH[29] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,value=0,name="Pb2Chts [BodyBurningStateAndTimer]: Normal"},
			})
			end
			if CH[30] then t = table.append(t,{
				{address=tmp.nca-0x610,flags=gg.TYPE_DWORD,value=1,freeze=false,value=0,name="Pb2Chts [Dr0wned]"},
			})
			end
			if CH[31] then t = table.append(t,{
				{address=tmp.nca-0x1AC,flags=gg.TYPE_WORD,value=0,name="Pb2Chts [Enable jet]"},
			})
			end
			if CH[18] then
				local CH,PlyrClrCH = gg.choice({
					"1. Black (256)",
					"2. Blue (257)",
					"3. Green (258)",
					"4. Brown (259)",
					"5. Red (260)",
					"6. Gray (261)",
					"7. Yellow (262)",
					"8. White (263)",
					"9. Bold red (264)",
					"10. Exteme black (272)",
					"11. Rare green (304)",
					"12. Dark green (306)",
					"13. Dark red (315)",
					"14. Tomato red (321)",
					"----- [Click here to "..f"__cancel__".."]",
					"15. Rainbow (Experimental)"
				},nil,"Select the color you want")
				if CH == 1 then PlyrClrCH = 256
				elseif CH == 2 then PlyrClrCH = 257
				elseif CH == 3 then PlyrClrCH = 258
				elseif CH == 4 then PlyrClrCH = 259
				elseif CH == 5 then PlyrClrCH = 260
				elseif CH == 6 then PlyrClrCH = 261
				elseif CH == 7 then PlyrClrCH = 262
				elseif CH == 8 then PlyrClrCH = 263
				elseif CH == 9 then PlyrClrCH = 264
				elseif CH == 10 then PlyrClrCH = 272
				elseif CH == 11 then PlyrClrCH = 304
				elseif CH == 12 then PlyrClrCH = 306
				elseif CH == 13 then PlyrClrCH = 315
				elseif CH == 14 then PlyrClrCH = 321
				-----cancel
				elseif CH == 16 then PlyrClrCH = -1 end
				if PlyrClrCH and PlyrClrCH >= 0 then t = table.append(t,{
					{address=tmp.nca+0x94,flags=gg.TYPE_WORD,freeze=false,value=PlyrClrCH,name="Pb2Chts [Vehicle color]"},
				})
				elseif PlyrClrCH and PlyrClrCH == -1 then
					toast("Still in building phase, click GG to stop. while the rainbow animation playing, you cannot access GG until its stopped\nand this will not apply other cheats you select, make sure you activate cheat choice of yours before activating this")
					tmp.rnbwCurClr = 257
					tmp.rainbowCar = {{address=tmp.nca+0x94,flags=gg.TYPE_WORD,freeze=false,name="Pb2Chts [Vehicle color]"}}
    			gg.setValues(t)
    			gg.addListItems(t)
    			gg.clearResults()
					gg.setVisible(false)
					while not gg.isVisible() do
						if tmp.rnbwCurClr > 264 then tmp.rnbwCurClr = 256 end
						tmp.rainbowCar[1].value = tmp.rnbwCurClr
						gg.setValues(tmp.rainbowCar)
						sleep(77)
						tmp.rnbwCurClr = tmp.rnbwCurClr + 1
					end
					gg.setVisible(false)
				end
			end
			gg.setValues(t)
			gg.addListItems(t)
			gg.clearResults()
			toast('Selected operations done')
		end
	end
end
function cheat_weaponammo()
	gg.setRanges(gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	gg.searchNumber(1217115234,nil,nil,nil,table.unpack(cfg.memZones.Common_RegionOtherB))
	t = gg.getResults(1)
	if gg.getResultCount() == 0 then
		toast("Can't find the specific set of number")
	else
		t = t[1].address
		gg.setValues({
			{address=t+0x10C,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x110,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x114,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x118,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x11C,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x120,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x124,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x128,value=999,flags=gg.TYPE_DWORD},
			{address=t+0x21C,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x220,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x224,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x228,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x22C,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x230,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x234,value=30000,flags=gg.TYPE_DWORD},
			{address=t+0x238,value=999,flags=gg.TYPE_DWORD},
		})
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
		f"__back__"
	},nil,"Pistol/Shotgun knockback modifier\nCurrent: "..curVal.PstlSgKnckbck.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH then
		if CH == 10 then MENU()
		elseif CH == 1 then PISTOL_KNOCKBACK_VALUE = -20
		elseif CH == 2 then PISTOL_KNOCKBACK_VALUE = 20
		elseif CH == 3 then PISTOL_KNOCKBACK_VALUE = 0.25
		elseif CH == 4 then PISTOL_KNOCKBACK_VALUE = 1e-5
		elseif CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if CH and CH[1] then
				PISTOL_KNOCKBACK_VALUE = CH[1]
			else
				cheat_pistolknockback()
			end
		---
		elseif CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{curVal.PstlSgKnckbck},{'number'})
			if CH and CH[1] then curVal.PstlSgKnckbck = CH[1] end
			cheat_pistolknockback()
		elseif CH == 8 then
			revert.PistolKnockback = nil
			cheat_pistolknockback()
		elseif CH == 9 then
			memOzt.PistolKnockback = nil
			cheat_pistolknockback()
		end
		if PISTOL_KNOCKBACK_VALUE then
		-- + gg.REGION_ANONYMOUS
			gg.setRanges(gg.REGION_C_ALLOC)
			if not memOzt[memOztName] then
				gg.searchNumber(curVal.PstlSgKnckbck,gg.TYPE_FLOAT)
				tmp[1] = gg.getResults(gg.getResultCount())
				gg.clearResults()
				gg.searchNumber(1067869798,gg.TYPE_DWORD)
				tmp[2] = gg.getResults(gg.getResultCount())
				gg.loadResults(table.append(tmp[1],tmp[2]))
			end
			handleMemOzt("PistolKnockback",curVal.PstlSgKnckbck.."F;1067869798D::13",curVal.PstlSgKnckbck,gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				memOzt.PistolKnockback,revert.PistolKnockback = nil,nil
				toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i=1,#memOzt.PistolKnockback do
					memOzt.PistolKnockback[i].value = PISTOL_KNOCKBACK_VALUE
				end
				curVal.PstlSgKnckbck,PISTOL_KNOCKBACK_VALUE = PISTOL_KNOCKBACK_VALUE,nil
				toast("Pistol/SG Knockback "..curVal.PstlSgKnckbck)
				gg.setValues(memOzt.PistolKnockback)
			end
		end
	end
end
function cheat_wallhack()
	local CH = gg.choice({
		"ON (GKTV, wonky physics, fast to enable, survives multiple match, and can wallhack other entities not just a wall)",
		"ON (AGH, physics works best. need to reapplied every match, takes some time)",
		"OFF (GKTV)",
		"OFF (AGH, Not recommended if buffer is empty)",
		"---",
		"Restore previous value",
		"Use custom value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Wall Hack. Warn:\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for CTS in Metropolis, because there\'s less holes there")
	if CH then
		if CH == 9 then MENU()
 -- Set ranges
		elseif CH == 1 then tmp={1,{"3472W;5W;1e-3F;14979W::11","2W;16256W;1e-3F;14979W::7",1e-3},curVal.WallResist[2],"ON"}
		elseif CH == 2 then tmp={2,"1140457472D;500F::",curVal.WallResist[1],"ON"}
		elseif CH == 3 then tmp={1,{"3472W;5W;"..curVal.WallResist[2].."F;-16512W::15","2W;16256W;"..curVal.WallResist[2].."F;-16512W::7",curVal.WallResist[2]},1e-3,"OFF"}
		elseif CH == 4 then tmp={2,curVal.WallResist[1],1140457472,"OFF"}
		---
		elseif CH == 6 then
			gg.setValues(revert.wallhack)
			gg.setValues(revert.wallhack_gktv)
			revert.wallhack,revert.wallhack_gktv = nil,nil
			toast("Previous value restored, be warned though this will cause instability")
			cheat_wallhack()
		elseif CH == 7 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default:1140457472,Cheatus default:-500)',
				'Put your custom value for Alternative method (Game default:0.001,Cheatus default:-1.00001)',
			},curVal.WallResist,{'number','number'})
			if CH then
				if CH[1] ~= "" then curVal.WallResist[1] = CH[1] end
				if CH[2] ~= "" then curVal.WallResist[2] = CH[2] end
				if CH[3] ~= "" then curVal.WallResist[3] = CH[3] end
			end
			CH = nil
			cheat_wallhack()
		elseif CH == 8 then
			CH,memOzt.wallhack,memOzt.wallhack_gktv = nil,nil,nil
			toast("Memory buffer cleared")
			cheat_wallhack()
		end
		if tmp then
			if tmp[1] == 1 then
				gg.setRanges(gg.REGION_CODE_APP)
				if not memOzt.wallhack_gktv then
					toast('No previous memory buffer found, creating new buffer.')
					gg.searchNumber(tmp[2][1])
					gg.refineNumber(tmp[2][3],gg.TYPE_FLOAT)
					tmp[5] = gg.getResults(1)
					gg.clearResults()
					gg.searchNumber(tmp[2][2])
					gg.refineNumber(tmp[2][3],gg.TYPE_FLOAT)
					tmp[5] = {tmp[5][1],gg.getResults(1)[1]}
					memOzt.wallhack_gktv,revert.wallhack_gktv = tmp[5],tmp[5]
				else
					toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				end
				gg.loadResults(memOzt.wallhack_gktv)
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					for i=1,#memOzt.wallhack_gktv do
						memOzt.wallhack_gktv[i].value = tmp[3]
					end
					gg.setValues(memOzt.wallhack_gktv)
					toast("Wall Hack "..tmp[4])
				end
			elseif tmp[1] == 2 then
				gg.setRanges(gg.REGION_C_ALLOC)
				handleMemOzt("wallhack",tmp[2],nil,gg.TYPE_DWORD,50)
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					for i=1,#memOzt.wallhack do
						memOzt.wallhack[i].value = tmp[3]
					end
					gg.setValues(memOzt.wallhack)
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
		f"__back__"
	},nil,"Big body")
	if CH then
		local t
		if CH == 7 then MENU()
		elseif CH == 1 then
			gg.setRanges(gg.REGION_C_BSS + gg.REGION_C_ALLOC)
			t = handleMemOzt("bigbody_mangyu",1.09500002861,nil,gg.TYPE_FLOAT,555)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i=1,#t do
					t[i].value = curVal.BigBody[1]+0.09500002861
					t[i].freeze = true
				end
				toast("Big Body ON")
			end
			gg.setValues(t)
		elseif CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody_gktv",4.30000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(curVal.BigBody[2]+0.00000019073,gg.TYPE_FLOAT)
				toast("Big Body ON")
			end
		elseif CH == 3 then
			gg.setRanges(gg.REGION_C_BSS + gg.REGION_C_ALLOC)
			t =  handleMemOzt("bigbody_mangyu",curVal.BigBody[1]+0.09500002861,nil,gg.TYPE_FLOAT,555)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i=1,#t do t[i].value = 1.09500002861 end
				toast("Big body OFF")
			end
			gg.setValues(t)
		elseif CH == 4 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody_gktv",curVal.BigBody[2]+0.00000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(4.30000019073,gg.TYPE_FLOAT)
				toast("Big body OFF")
			end
		elseif CH == 5 then
			if revert.bigbody_gktv or revert.bigbody_mangyu then
				gg.setValues(revert.bigbody_gktv)
				gg.setValues(revert.bigbody_mangyu)
				toast("Big body previous value restored")
			else
				toast("No values to restore")
			end
			revert.bigbody_gktv,revert.bigbody_mangyu = nil,nil
		elseif CH == 6 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default: 1,Cheatus default: 3, offset: .09500002861)',
				'Put your custom value for Alternative method (Game default: 4.3,Cheatus default: 5.9, offset: .00000019073)'
			},{
				curVal.BigBody[1],
				curVal.BigBody[2]
			},{
				'number',
				'number'
			})
			if CH then
				if CH[1] ~= "" then curVal.BigBody[1] = CH[1] end
				if CH[2] ~= "" then curVal.BigBody[2] = CH[2] end
			end
			CH = nil
			cheat_bigbody()
		end
		t = nil
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
		f"__back__"
	},nil,"Veichle default health modifier")
	if CH then
		if CH == 9 then MENU()
		elseif CH == 1 then CAR_HEALTH_VALUE = 85e3
		elseif CH == 2 then CAR_HEALTH_VALUE = 125
		elseif CH == 3 then CAR_HEALTH_VALUE = -1
		elseif CH == 4 then
			local CH = gg.prompt({'Input your custom Veichle default health value'})
			if CH and CH[1] then
				CAR_HEALTH_VALUE = CH[1]
			else
				cheat_strongveichle()
			end
		---
		elseif CH == 6 then
			local CH = gg.prompt({'If you think the current Veichle default health value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Veichle default health value'},{curVal.CrDfltHlth},{'number'})
			if CH and CH[1] then curVal.CrDfltHlth = CH[1] end
			cheat_strongveichle()
		elseif CH == 7 then
			CH,revert.CarHealth = nil,nil
			cheat_strongveichle()
		elseif CH == 8 then
			CH,memOzt.CarHealth = nil,nil
			cheat_strongveichle()
		end
		if CAR_HEALTH_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("CarHealth",curVal.CrDfltHlth.."D;4D;1F::21",curVal.CrDfltHlth,gg.TYPE_DWORD,50)
			if gg.getResultCount() == 0 then
				memOzt.CarHealth,revert.CarHealth = nil,nil
				toast("Can't find the specific set of number. if you changed the veichle health value, and reopened the script, restore the actual current number using 'Change current health variable' menu")
			else
				for i=1,#memOzt.CarHealth do
					memOzt.CarHealth[i].value = CAR_HEALTH_VALUE
				end
				curVal.CrDfltHlth,CAR_HEALTH_VALUE = CAR_HEALTH_VALUE,nil
				toast("Veichles default health "..curVal.CrDfltHlth)
				gg.setValues(memOzt.CarHealth)
			end
		end
	end
end
function cheat_noblastdamage()
	local CH = gg.choice({
		"ON (0)",
		"Default (300)",
		"Feather death (3e3, dead with almost any explosed explosion)",
		"Custom",
		"---",
		"Change current damage value",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"No blast damage")
	if CH then
		if CH == 9 then MENU()
		elseif CH == 1 then DAMAGE_INTENSITY_VALUE = 0
		elseif CH == 2 then DAMAGE_INTENSITY_VALUE = 300
		elseif CH == 3 then DAMAGE_INTENSITY_VALUE = 3e3
		elseif CH == 4 then
			local CH = gg.prompt({'Input your custom damage intensity'})
			if CH and CH[1] then
				DAMAGE_INTENSITY_VALUE = CH[1]
			else
				cheat_noblastdamage()
			end
		---
		elseif CH == 6 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{curVal.DmgIntnsty},{'number'})
			if CH and CH[1] then curVal.DmgIntnsty = CH[1] end
			cheat_noblastdamage()
		elseif CH == 7 then
			CH,revert.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		elseif CH == 8 then
			CH,memOzt.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		end
		if DAMAGE_INTENSITY_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("NoBlastDamage","-5632W;"..curVal.DmgIntnsty.."F;1324247848D::7",curVal.DmgIntnsty,gg.TYPE_FLOAT,9)
			if gg.getResultCount() == 0 then
				memOzt.NoBlastDamage,revert.NoBlastDamage = nil,nil
				toast("Can't find the specific set of number. if you changed the blast intensity value and reopened the script, restore the actual current number using 'Change current damage value' menu")
			else
				for i=1,#memOzt.NoBlastDamage do
					memOzt.NoBlastDamage[i].value = DAMAGE_INTENSITY_VALUE
				end
				curVal.DmgIntnsty,DAMAGE_INTENSITY_VALUE = DAMAGE_INTENSITY_VALUE,nil
				toast("Blast damage intensity "..curVal.DmgIntnsty)
				gg.setValues(memOzt.NoBlastDamage)
			end
		end
	end
end
function cheat_floodspawn()
	CH = gg.choice({
		"Activate",
		"Clear memory buffer",
		"Clear buffer and Activate",
		"Back"
	},nil,"Flood Respawn\nDISCLAIMMER:\n- DO NOT USE THIS TO ABUSE OTHER PLAYER!!!\n- THIS CHEAT IS TECHINCALLY POWERFUL, BECAUSE IT DROPS SERVER TPS AND LAG PLAYERS. ONLY USE IT OFFLINE!!")
	if CH then
		if CH == 4 then MENU() end
		if CH == 2 or CH == 3 then
			memOzt.respawnCheat = nil
			cheat_floodspawn()
		end
		if CH == 1 or CH == 3 then
			gg.setRanges(gg.REGION_OTHER)
			t = handleMemOzt("respawnCheat",52428800,nil,gg.TYPE_DWORD,10,cfg.memZones.Common_RegionOtherB)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				searchWatchdog("Now trigger respawn animation (by respawning yourself through pause menu)","52428801~52429000","respawnCheat")
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					local respawnDur = gg.prompt({"Put the respawn duration (in seconds), set to 0 to disable duration [0;20]"},{1},{"number"})
					if respawnDur and respawnDur[1] then
						t[1].value = 52428801
						t[1].freeze = true
						t[1].name = "Pb2Chts [RespawnHack]"
						gg.setValues(t)
						gg.addListItems(t)
						respawnDur = respawnDur[1]
						if respawnDur == "0" then
							toast("Flood Respawn ON\nRemember to turn off again by suspending the script (press suspend button, below exit button), go to listItems, and unfreeze \"Pb2Chts [RespawnHack]\"")
						else
							toast("Flood Respawn ON for "..respawnDur.." seconds")
							sleep(1000*respawnDur)
							t[1].freeze = false
							gg.addListItems(t)
							toast("Flood Respawn OFF")
						end
					end
				end
			end
		end
	end
end
function cheat_voidmatchmode()
	gg.setRanges(gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	gg.searchNumber(1217115234,nil,nil,nil,table.unpack(cfg.memZones.Common_RegionOtherB))
	t = gg.getResults(1)
	if gg.getResultCount() == 0 then
		toast("Can't find the specific set of number, be noted that this cheat its kinda quirky so it might (not) work")
	else
		t = t[1].address
		gg.setValues({
			{address=t+0xB4,value=9,flags=gg.TYPE_DWORD},
			{address=t+0xD0,value=6,flags=gg.TYPE_DWORD},
			{address=t+0x1C4,value=9,flags=gg.TYPE_DWORD},
			{address=t+0x1E0,value=6,flags=gg.TYPE_DWORD}
		})
	end
	toast('void mode is set. to restore, simply change to any mode you desire\nbe noted that this cheat its kinda quirky so it might (not) work')
end
function cheat_xpmodifier()
--gg.REGION_C_BSS + // Not ready yet especially because JokerGGS mentioned a problem with CBSS Region.
	gg.setRanges(gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	local CH = gg.prompt({
		'Put your new XP (Play Game limit is 999999, while DWORD limit is 1.999.999.998)',
		'Put your new coin (maximum 32767, temporary, not recommend if you have infinite coin coz it might get reset)',
		'Freeze XP',
		'Freeze Coin',
	},{999999,-1,true,false},{'number','number','checkbox','checkbox'})
	if CH and CH[1] and CH[2] then
		tmp[1] = handleMemOzt("CustomXP",1014817001,nil,gg.TYPE_DWORD,1)
		if gg.getResultCount() == 0 then
			toast('Can\'t find the specific number.')
		else
			if CH[1] ~= "-1" then
				t = {{address=(tmp[1].address-0x804),value=CH[1],freeze=CH[3],name="Pb2Chts [PlayerCurrentXP]"}}
			end
			if CH[2] ~= "-1" then
				t = table.append(t,{{address=(tmp[1].address-0x608),value=CH[2],freeze=CH[4],name="Pb2Chts [PlayerCurrentCoin]"}})
			end
			gg.setValues(t)
			gg.addListItems(t)
			toast('XP changed to '..CH[1]..'\nWarn: XP won\'t applied permanently. to change it permanently, you have to modify Payback.sav file, which is impossible because it\'s encrypted')
		end
	end
end
function cheat_changeplayername()
	gg.setRanges(gg.REGION_C_ALLOC + gg.REGION_ANONYMOUS + gg.REGION_OTHER)
--request user to give player name
	local player_name = gg.prompt({
		'Put your current player name (case-sensitive, ":" or ";" is required at the beginning, because how GameGuardian search works)',
		'Put new player name (cant be longer than current name, you can change color/add icon by copy-pasting custom name edited using hex-editor (use hex 1-9 for color))'
	},{
		curVal.PlayerCurrentName,
		cfg.PlayerCustomName
	},{
		"text",
		"text"
	})
--search old player name
	if player_name and player_name[1] and player_name[1] ~= ":" then
		gg.searchNumber(player_name[1],gg.TYPE_BYTE)
		revert.PlayerName = gg.getResults(5e3)
		if gg.getResultCount() == 0 then
			toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			gg.editAll(player_name[2],gg.TYPE_BYTE)
			curVal.PlayerCurrentName = player_name[2]
			toast('"'..player_name[1]..'" changed to "'..player_name[2]..'"\nWarn: this is still in experimentation phase, the name might only apply on your client and not others')
		end
	end
end
function cheat_changeplayernamecolor()
	gg.setRanges(gg.REGION_C_ALLOC + gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	local CH,player_name,player_color_choice = gg.choice({
		"Invisible name (all values 1 byte, Experimental)",
		"Red (2)",
		"Blue (3)",
		"White (4)",
		"Yellow (5,9)",
		"Green (6h)",
		"Coin (7h)",
		"Man icon (8h)",
		"Corrupted (10h)",
		"---",
		"Remove all color/icon",
		f"__back__"
	},nil,"Select the color you want (Experimental)"),gg.prompt({'Put your current player name (case-sensitive)'},{curVal.PlayerCurrentName},{'text'})
	if CH then
		if CH == 1 then player_color_choice = 1
		elseif CH == 2 then player_color_choice = 2
		elseif CH == 3 then player_color_choice = 3
		elseif CH == 4 then player_color_choice = 4
		elseif CH == 5 then player_color_choice = 5
		elseif CH == 6 then player_color_choice = 6
		elseif CH == 7 then player_color_choice = 7
		elseif CH == 8 then player_color_choice = 8
		elseif CH == 9 then player_color_choice = 10
	---
		elseif CH == 11 then player_color_choice = 0
		elseif CH == 12 then MENU() end
		if player_color_choice then
			gg.searchNumber(player_name[1],gg.TYPE_BYTE)
			local t,removeOffset = gg.getResults(5e3),0
			revert.PlayerName = gg.getResults(5e3)
			if gg.getResultCount() == 0 then
				toast('Can\'t find the player name, this cheat is still in experimentation phase')
			else
			--if the chioce is 0, remove color/icons
				if player_color_choice == 0 then
					for i=1,#t do
					--if within the custom color/icon range
						if t[i].value >= 0 and t[i].value < 11 then
						--remove it
							t[i] = nil
							removeOffset = removeOffset + 1
						else
						--and -removeOffset for the rest
							t[i].address = (t[i].address - removeOffset)
						end
					end
			--else (numbers ranging from 2-10)
				else
				--this is where the problem arises, you know that the player names might be more than 1?, will this vvv work? probably not, mostly.
				--1. shift all addreses
					for i=1,#t do
						t[i].address = (t[i].address + 1)
					end
				--2. add value whatever
					table.insert(t,1,{
						address = (t[1].address - 1),
						freeze = false,
						flags = gg.TYPE_BYTE,
						value = player_color_choice
					})
				end
				curVal.PlayerCurrentName = table.concat(t)
				gg.setValues(t)
				toast('Color set to '..player_color_choice..'. PS: still in experimental phase, might not work')
			end
		end
	end
end
function cheat_walkwonkyness()
	local CH = gg.choice({
		"Default (0.004)",
		"ON (1)",
		"OFF (0)",
		"Restore",
		"Clear memory buffer",
		f"__back__"
	},nil,"Walk Wonkyness (fancy-cheat)")
	gg.setRanges(gg.REGION_CODE_APP)
	if CH == 5 then MENU()
	elseif CH == 1 then
		handleMemOzt("walkwonkyness","0~1;0.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(0.004,gg.TYPE_FLOAT)
		toast("Walk Wonkyness Default")
	elseif CH == 2 then
		handleMemOzt("walkwonkyness","0.004;0.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(1.004,gg.TYPE_FLOAT)
		toast("Walk Wonkyness ON")
	elseif CH == 3 then
		handleMemOzt("walkwonkyness","1.004;0.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(0,gg.TYPE_FLOAT)
		toast("Walk Wonkyness OFF")
	elseif CH == 4 then
		gg.setValues(revert.walkwonkyness)
		revert.walkwonkyness = nil
	elseif CH == 5 then
		revert.walkwonkyness = nil
	end
end
function cheat_coloredtree()
	local CH = gg.choice({
		"ON",
		"OFF",
		f"__back__"
	},nil,"Colored trees\nThis will change some shader stuff (actually idk wut this does lol) that affects trees")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={0.04,-999,"ON"}
	elseif CH == 2 then tmp={-999,0.04,"OFF"} end
	if tmp then
		gg.setRanges(gg.REGION_CODE_APP)
		local t = handleMemOzt("clrdtree","4.06176449e-39;0.06;"..tmp[1]..";-0.04;-0.02::17",tmp[1],gg.TYPE_FLOAT,1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			toast("Colored trees "..tmp[3])
		end
	end
end
function cheat_bigflamethroweritem()
	local CH = gg.choice({
		"ON",
		"OFF",
		f"__back__"
	},nil,"Big flamethrower (Item)\nInfo: this will not make the flame burst bigger")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={0.9,5.1403,"ON"}
	elseif CH == 2 then tmp={5.1403,0.9,"OFF"} end
	if tmp then
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("bigflmthrwritm","0.4;0.2;"..tmp[1]..";24e3::13",tmp[1],gg.TYPE_FLOAT,9)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			toast("Big flamethrower "..tmp[3])
		end
	end
end
function cheat_shadowfx()
	local CH = gg.choice({
		"OFF",
		"ON",
		f"__back__"
	},nil,"Shadow effects\nInfo: this wont affect your game performance at all (not making it lag/fast)\ndont use this for performance purpose :)")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={1e-4,-1.0012,"Disabled"}
	elseif CH == 2 then tmp={-1.0012,1e-4,"Enabled"} end
	if tmp then
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("shadow",tmp[1]..";-5.96152076e27;-2.55751098e30;-1.11590087e28;-5.59128595e24:17",tmp[1],gg.TYPE_FLOAT,1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			toast("Shadow "..tmp[3])
		end
	end
end
function cheat_clrdpplsp()
	local CH = gg.choice({
		"ON",
		"OFF",
		f"__back__"
	},nil,"Colored people ESP (ExtraSensoryPerception. i guess this is X-Ray Hack)\nPS: Not work on latest version")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={0.08,436,"ON"}
	elseif CH == 2 then tmp={436,0.08,"OFF"} end
	if tmp then
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("clrdpplsp",tmp[1],nil,gg.TYPE_FLOAT,9)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			toast("ESP "..tmp[3])
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
		gg.searchNumber(":"..tmp[i])
		gg.getResults(99)
		gg.editAll(0,gg.TYPE_BYTE)
		gg.clearResults()
	end
	toast("In-gameplay-text cleared, to restore, you have to restart the game\nPS: This might not work, idk why though..")
end
function cheat_reflectiongraphics()
	local CH = gg.choice({
		"ON",
		"OFF",
		f"__back__"
	},nil,"Reflection graphics\nWARNING: this can cause rendering issue that requires restart to fix it\nDont forget to disable this before you get in/out-of match\ni only recommend using this in offline mode so you can easily disable the reflection graphics before getting out of match")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={49,1,"ON"}
	elseif CH == 2 then tmp={1,49,"OFF"} end
	if CH and tmp[3] then
		gg.setRanges(gg.REGION_OTHER)
		handleMemOzt("RfTgraphics","144;"..tmp[1]..";50::9",tmp[1],gg.TYPE_DWORD,1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			memOzt.RfTgraphics[1].value = tmp[2]
			toast("Reflection Graphics "..tmp[3])
			gg.setValues(memOzt.RfTgraphics)
		end
	end
	t = nil
end
function cheat_explodepow()
	local CH = gg.choice({
		"Modify Explosion power",
		"---",
		"Change current Explosion power",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Explosion power modifier\nCurrent: "..curVal.XplodPow.."\n")
	if CH then
		if CH == 6 then MENU()
		elseif CH == 1 then
			local CH = gg.prompt({'Put your explosion power. Lower is more powerful\nSet to -1 to disable explosion\n PS:only applies to you'},{curVal.XplodPow},{'number'})
			if CH and CH[1] then
				EXPLOSION_POWER = CH[1]
			else
				cheat_explodepow()
			end
		---
		elseif CH == 3 then
			local CH = gg.prompt({'If you think the current explosion power is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current explosion power'},{curVal.PstlSgKnckbck},{'number'})
			if CH and CH[1] then curVal.XplodPow = CH[1] end
			cheat_explodepow()
		elseif CH == 4 then
			revert.explodePower = nil
			cheat_explodepow()
		elseif CH == 5 then
			memOzt.explodePower = nil
			cheat_explodepow()
		end
		if EXPLOSION_POWER then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("explodePower","15120W;"..curVal.XplodPow.."F::3",curVal.XplodPow,gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				memOzt.explodePower,revert.explodePower = nil,nil
				toast("Can't find the specific set of number. if you changed the explosion power and reopened the script, restore current number using 'Change current explosion power' menu")
			else
				memOzt.explodePower[1].value,curVal.XplodPow,EXPLOSION_POWER = EXPLOSION_POWER,EXPLOSION_POWER,nil
				toast("Explosion power modified to "..curVal.XplodPow)
				gg.setValues(memOzt.explodePower)
			end
		end
	end
end
function cheat_explodedir()
	local CH = gg.choice({
		"Default (50000)",
		"OFF (0)",
		"Attractive/magnet (-50000)",
		"Custom",
		"---",
		"Change current value",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"No blast damage")
	if CH then
		if CH == 8 then MENU()
		elseif CH == 1 then XPLODIR_VAL = 5e4
		elseif CH == 2 then XPLODIR_VAL = 0
		elseif CH == 3 then XPLODIR_VAL = -5e4
		elseif CH == 4 then
			local CH = gg.prompt({'Input your custom damage intensity'})
			if CH and CH[1] then
				XPLODIR_VAL = CH[1]
			else
				cheat_explodedir()
			end
		---
		elseif CH == 6 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{curVal.DmgIntnsty},{'number'})
			if CH and CH[1] then curVal.XplodDir = CH[1] end
			cheat_explodedir()
		elseif CH == 7 then
			CH,revert.explodeDir = nil,nil
			cheat_explodedir()
		elseif CH == 8 then
			CH,memOzt.explodeDir = nil,nil
			cheat_explodedir()
		end
		if XPLODIR_VAL then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("explodeDir","1259902592D;"..curVal.XplodDir.."F::5",curVal.XplodDir,gg.TYPE_FLOAT,9)
			if gg.getResultCount() == 0 then
				memOzt.explodeDir,revert.explodeDir = nil,nil
				toast("Can't find the specific set of number. if you changed the value and reopened the script, restore the actual current number using 'Change current value' menu")
			else
				for i=1,#memOzt.explodeDir do
					memOzt.explodeDir[i].value = XPLODIR_VAL
				end
				curVal.XplodDir,XPLODIR_VAL = XPLODIR_VAL,nil
				toast("Explosion direction is set to "..(curVal.XplodDir > 0 and "default" or curVal.XplodDir < 0 and "magnet" or curVal.XplodDir == 0 and "none"))
				gg.setValues(memOzt.explodeDir)
			end
		end
	end
end
function cheat_prtclintrvl()
	local CH = gg.choice({
		"No particle (0ms, recommended if too much particle/explosion caused lag)",
		"Fast (9ms)",
		"Default (120ms)",
		"Slow (2s)",
		"Custom",
		"---",
		"Change current interval variable",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Particle interval modifier\nCurrent: "..curVal.PrtclAnmtnIntrvl)
	if CH then
		if CH == 10 then MENU()
		elseif CH == 1 then PARTICLE_INT = 0
		elseif CH == 2 then PARTICLE_INT = 9
		elseif CH == 3 then PARTICLE_INT = 120
		elseif CH == 4 then PARTICLE_INT = 2000
		elseif CH == 5 then
			local CH = gg.prompt({'Input your custom interval value (in miliseconds)'})
			if CH and CH[1] then
				PARTICLE_INT = CH[1]
			else
				cheat_prtclintrvl()
			end
		---
		elseif CH == 7 then
			local CH = gg.prompt({'If you think the current interval value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current interval'},{curVal.PrtclAnmtnIntrvl},{'number'})
			if CH and CH[1] then curVal.PrtclAnmtnIntrvl = CH[1] end
			cheat_prtclintrvl()
		elseif CH == 8 then revert.PrtclAnmtnIntrvl = nil cheat_prtclintrvl()
		elseif CH == 9 then memOzt.PrtclAnmtnIntrvl = nil cheat_prtclintrvl()
		end
		if PARTICLE_INT then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("PrtclAnmtnIntrvl","-352321693D;"..curVal.PrtclAnmtnIntrvl.."F::5",curVal.PrtclAnmtnIntrvl,gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				memOzt.PrtclAnmtnIntrvl,revert.PrtclAnmtnIntrvl = nil,nil
				toast("Can't find the specific set of number. if you changed the interval and reopened the script, restore the actual current number using 'Change current interval' menu")
			else
				for i=1,#memOzt.PrtclAnmtnIntrvl do
					memOzt.PrtclAnmtnIntrvl[i].value = PARTICLE_INT
				end
				curVal.PrtclAnmtnIntrvl,PARTICLE_INT = PARTICLE_INT,nil
				toast("Particle interval "..curVal.PrtclAnmtnIntrvl.."ms")
				gg.setValues(memOzt.PrtclAnmtnIntrvl)
			end
		end
	end
end
function cheat_cardrift()
	local CH = gg.choice({
		"Modify drifting speed",
		"---",
		"Change current drifting speed",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Drifting speed modifier\nCurrent: "..curVal.DrftSpd.."\n")
	if CH then
		if CH == 6 then MENU()
		elseif CH == 1 then
			local CH = gg.prompt({'How fast you want the drifting rotation? Higher value is more powerful\nDefault:1 (1.3) [-1;20]'},{curVal.DrftSpd},{'number'})
			if CH and CH[1] then
				DRIFT_SPEED = CH[1]
			else
				cheat_cardrift()
			end
		---
		elseif CH == 3 then
			local CH = gg.prompt({'If you think the current explosion power is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current explosion power'},{curVal.DrftSpd},{'number'})
			if CH and CH[1] then curVal.DrftSpd = CH[1] end
			cheat_cardrift()
		elseif CH == 4 then
			revert.DrftSpd = nil
			cheat_cardrift()
		elseif CH == 5 then
			memOzt.DrftSpd = nil
			cheat_cardrift()
		end
		if DRIFT_SPEED then
			DRIFT_SPEED = tonumber(DRIFT_SPEED..".3")
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("DrftSpd",curVal.DrftSpd,nil,gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				memOzt.DrftSpd,revert.DrftSpd = nil,nil
				toast("Can't find the specific set of number. if you changed the drift speed and reopened the script, restore current number using 'Change current drift speed' menu")
			else
				memOzt.DrftSpd[1].value,curVal.DrftSpd,DRIFT_SPEED = DRIFT_SPEED,DRIFT_SPEED,nil
				toast("Explosion power modified to "..curVal.DrftSpd)
				gg.setValues(memOzt.explodePower)
			end
		end
	end
end
function show_about()
	local CH = gg.choice({
		f"__about__",
		"---",
		f"Disclaimmer",
		f"License",
		f"Credits",
		f"__back__"
	},nil,f"__about__")
	if CH == 1 then alert(f"About_Text") show_about()
	---
	elseif CH == 3 then alert(f"Disclaimmer_Text") show_about()
	elseif CH == 4 then alert(f"License_Text") show_about()
	elseif CH == 5 then alert(f"Credits_Text") show_about()
	elseif CH == 6 then CH = nil MENU() end
end

-- Helper functions --
function table.merge(...)
	--[[
		merge 2 tables, just like Object.assign on JS
		first table will be replaced by new table...
		also merge tables recursively
		recommended only on object-like tables, but not on array-like tables
	]]
	local r = {}
	for _,t in ipairs{...} do
		for k,v in pairs(t) do
			if type(r[k]) == "table" then
				r[k] = table.merge(r[k],v)
			else
				r[k] = v
			end
		end
	end
	return r
end
function table.mergeContents(valuesTable,modifierTable)
	--[[
		Same as table.merge but optimized for GameGuardian values
		this is used to "replace" (kindof) gg.editAll()
		how to use:table.mergeContents({ -- gg result, comes from searching whatever number using gg.searchNumber()
			{address:1,value:0,type:gg.TYPE_BYTE},
			{address:2,value:2,type:gg.TYPE_QWORD},
			{address:3,value:5,type:gg.TYPE_WORD},
		},{value:1,type:gg.TYPE_DWORD,freeze:true})
		{ {address:1,value:1,type:gg.TYPE_DWORD,freeze:true},
			{address:2,value:1,type:gg.TYPE_DWORD,freeze:true},
		} {address:3,value:1,type:gg.TYPE_DWORD,freeze:true},
	]]
--for each result
	for i=1,#valuesTable do
	--for each contents in modifier table...
		for k,v in pairs(modifierTable) do
		--change valuesTable contents to new modifierTable contents
			valuesTable[i][k] = modifierTable[k]
		end
	end
	return valuesTable
end
function table.append(t1,t2)
	--[[
		Creates new table then
		add table 1 and table 2
	]]
	for _,v in ipairs(t2) do
		t1[#t1+1]=v
	end
	return t1
end
function searchWatchdog(msg,refineVal,mmBfr)
--[[

]]
	if gg.getResultCount() < 2 then return gg.getResults(1)
	elseif msg then toast(msg.."\nClick GG Icon to abort the search") end
	local prvVl,foundTheValue = gg.getResults(100)
	while not foundTheValue do
		if gg.isVisible() then gg.setVisible(false) foundTheValue = 1 end
		gg.refineNumber(refineVal)
		if gg.getResultCount() > 0 then
			foundTheValue = 1
		else
			gg.loadResults(prvVl)
		end
		sleep(100)
	end
	t = gg.getResults(1)
	prvVl,foundTheValue,memOzt[mmBfr],revert[mmBfr] = nil,nil,t,t
	return t
end
function handleMemOzt(memOztName,val,valRefine,valTypes,desiredResultCount,memZones)
--[[
	This function handles memory buffer related stuff by saving previous
	result and return that instead the next time the same search is requested.
	This optimization can only apply if the values not always changing.
	Best for memory region that is huge and taking long time to search.
]]
--default configs
	memZones = memZones or {0,-1}
	desiredResultCount = desiredResultCount or 1
--if buffer is found
	if memOzt[memOztName] then
	--load previous result
		toast('Previous result found, using previous result')
		gg.loadResults(memOzt[memOztName])
	else
	--or search new ones
		toast('No buffer found, creating new buffer')
		gg.searchNumber(val,valTypes,nil,nil,memZones[1],memZones[2])
	--optionally refine if valRefine is defined
		if valRefine then
			gg.refineNumber(valRefine,valTypes)
		end
		memOzt[memOztName],revert[memOztName] = gg.getResults(desiredResultCount),gg.getResults(desiredResultCount)
	end
	return gg.getResults(desiredResultCount)
end
function loopSearch(desiredResultCount,valueType,msg1,restrictedMemArea)
	local num1,t = gg.prompt({msg1})
	restrictedMemArea = restrictedMemArea or {}
	if num1 and num1[1] then
	--Search within restricted memory address, which can be faster
		gg.searchNumber(num1[1],valueType,nil,nil,restrictedMemArea[1],restrictedMemArea[2])
		if gg.getResultCount() > 0 then
			while gg.getResultCount() > desiredResultCount do
				tmp[1] = gg.getResultCount()
			--old method:ask user their current ammo
			--because mostly the ammo will go down, we should use fuzzy and dont ask user about ammo anymore (but theres a bug with searchFuzzy itself, it wouldnt found anything AT ALL COST IF USED IN SCRIPT!!!)
				toast('3 seconds to change ammo value')
				sleep(3e3)
				num1 = gg.prompt({'Put your weapon ammo\nCurrently found: '..tmp},{num1[1]})
				if not (num1 and num1[1]) then break end
				gg.refineNumber(num1[1])
			--If found 2 result, check if 2 numbers are same, and return 1st value if so (this means user is on a veichle)
				tmp[1] = gg.getResultCount()
				if tmp[1] == 2 then
					t = gg.getResults(2)
					if t[1].value == t[2].value then
						return {t[1]}
					end
			--If nothing found...
				elseif tmp[1] == 0 then
					if not restrictedMemArea[1] then
					--If fail but have restricted memory, try again with no restriction
						break
					else
					--else break and return nothing, and let the 0 handler did its job
						toast("Oh, this is weird 🤔️... We don't find the value you're searching for 🔍️. We will try again, but without memory restriction")
						return loopSearch(desiredResultCount,valueType,msg1)
					end
				end
			end
			return gg.getResults(desiredResultCount)
		end
	end
end
function findEntityAnchr()
	gg.setRanges(gg.REGION_OTHER + gg.REGION_ANONYMOUS)
	if cfg.cheatSettings.findEntityAnchr.searchMethod == "holdWeapon" then
		toast("Hold your pistol")
		sleep(1e3)
		gg.searchNumber(13,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.HldWpn))
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
		gg.clearResults()
		return t[1].address - 0x18
	elseif cfg.cheatSettings.findEntityAnchr.searchMethod == "wordWeaponAmmo" then
		t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo',cfg.memZones.WpnAmmWrd)
		if gg.getResultCount() == 0 then return end
		t = t[1]
		t.value = 3e4
		gg.setValues({t})
		gg.clearResults()
		gg.searchNumber(20,gg.TYPE_WORD,nil,nil,t.address - 0x2A,t.address)
		if gg.getResultCount() > 0 then return gg.getResults(1)[1].address end
	elseif cfg.cheatSettings.findEntityAnchr.searchMethod == "mangyuFloatAnchor" then
		toast("Please wait for ~3 seconds... Don't shoot, Keep your health at max, Hold pistol.")
	--this ginormous packs of "battery" below is basically... just searching this in optimized way: "120Q;2.80259693e-44F;1~800D;512~513W::45(?ehh,definitely more than 45 though...)"
		gg.searchNumber(120,gg.TYPE_QWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOtherB)) -- 1/5
		tmp[1]=gg.getResults(5e3) for i=1,#tmp[1] do tmp[1][i].address = (tmp[1][i].address + 0x1C) tmp[1][i].flags = gg.TYPE_DWORD end gg.loadResults(tmp[1]) gg.refineNumber("1~800")        -- 2/5 (Health 1-800)
		tmp[1]=gg.getResults(5e3) for i=1,#tmp[1] do tmp[1][i].address = (tmp[1][i].address + 0x10) tmp[1][i].flags = gg.TYPE_DWORD end gg.loadResults(tmp[1]) gg.refineNumber(13)             -- 3/5 (HoldWeapon 13)
		tmp[1]=gg.getResults(5e3) for i=1,#tmp[1] do tmp[1][i].address = (tmp[1][i].address + 0xC2) tmp[1][i].flags = gg.TYPE_WORD  end gg.loadResults(tmp[1]) gg.refineNumber("512~513")      -- 4/5 (ControlCode 51{2/3})
		tmp[1]=gg.getResults(5e3) for i=1,#tmp[1] do tmp[1][i].address = (tmp[1][i].address - 0xDA) tmp[1][i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp[1]) gg.refineNumber(2.80259693e-44) -- 5/5 (Anchor 20)
		if gg.getResultCount() > 0 then return gg.getResults(1)[1].address end
	else
		toast("An error occured (InvalidConf): Exit out of script and see print log for more details.")
		print("[Error.InvalidConf]: Configuration value for \"cfg.cheatSettings.findEntityAnchr.searchMethod\" ("..cfg.cheatSettings.findEntityAnchr.searchMethod..") is invalid.\n         Possible values: wordWeaponAmmo, holdWeapon, mangyuFloatAnchor\n         Your Configuration:\n",cfg)
	end
end
function exit()
	gg.saveVariable(cfg,cfg_file)
	gg.clearResults()
	print(f"Exit_ThankYouMsg")
	os.exit()
end
function suspend()
	gg.saveVariable({
		revert=revert,
		memOzt=memOzt,
		cfg=cfg
	},susp_file)
	print(f"Suspend_Text")
	os.exit()
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
			findEntityAnchr={
				searchMethod="holdWeapon"
			}
		},
		memZones={
			Common_RegionOther={0xB0000000,0xD0000000},
			Common_RegionOtherB={0xB0000000,0xBFFFFFFF},
			WpnAmmWrd={0xB000051C,0xCD0FFD2A},
			HldWpn={0xB0000518,0xCDFFFD18}
		},
		Language="auto",
		PlayerCurrentName=":Player",
		PlayerCustomName=":CoolFoe",
		VERSION="2.1.8b",
		clearAllList=false
	}
	local cfg_load = loadfile(cfg_file)
	if cfg_load then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = table.merge(cfg,cfg_load)
	else
		toast("No configuration files detected, Creating new one...  💾️\nHi There! 👋️ Looks like You're new here.")
		gg.saveVariable(cfg,cfg_file)
	end
	cfg_load = nil
	curVal.PlayerCurrentName = cfg.PlayerCurrentName
	update_language()
end
function restoreSuspend()
	--[[
		Restore current session from suspend file and remove it afterwards
	]]
	local susp = loadfile(susp_file)
	if susp then
		toast(f"Suspend_Detected")
		susp = susp()
		cfg = susp.cfg
		revert = susp.revert
		memOzt = susp.memOzt
		os.remove(susp_file)
	end
	susp = nil
end

-- Initialization --
--generic functions
alert=function(str,...)
	gg.alert(f(str),...)
end
toast=function(str,fastmode)
	if fastmode == nil then fastmode = true end
	gg.toast(str,fastmode)
end
sleep=gg.sleep
curVal={
	PstlSgKnckbck=0.25,
	CrDfltHlth=125,
	DmgIntnsty=300,
	DrftSpd=1,
	WallResist={-500,-1e-5},
	BigBody={3,5.9},
	XplodPow=1e7,
	XplodDir=5e4,
	PrtclAnmtnIntrvl=120
}
-- Load settings and languages
loadConfig()

-- Modify gg.clearList (if enabled in config), to only remove Pb2Chts-related values
do if not cfg.clearAllList then
	local clearList = gg.clearList
	gg.clearList = function()
		tmp[1] = gg.getListItems()
		for i=1,#tmp[1] do
			if tmp[1][i].name and tmp[1][i].name:find"Pb2Chts" then
				tmp[1][i] = nil
			end
		end
		clearList()
		gg.addListItems(tmp[1])
		tmp[1] = nil
	end
end end

-- Initialize language
local lang = {
en_US={
Automatic				 = "Automatic",
About_Text			 = "Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number, even cheat menu which didnt show any numbers at all). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes",
Credits					 = "Credits",
Credits_Text		 = "Credit:\n+ Mangyu - Original script author\n+ mdp43140 - Main Contributor\n+ MisterCuteX - Mega Explosion,Respawn Hack\n+ tehtmi - unluac Creator (and decompile helper)\n+ Crystal_Mods100x - ICE Menu\n+ Latic AX & ToxicCoder - for providing removed script through YT & MediaFire\n+ AGH - for Wall Hack,Car Health GG Values (no thanks for ridicilous encrypted script though...)\n+ GKTV - PB2 GG script (wall hack,big body,colored tree,big flamethower item,shadow,esp)\n+ JokerGGS - for No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4 Drawing GG Values",
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
Credits_Text		 = "Kredit:\n+ Mangyu - Pembuat skrip original\n+ mdp43140 - Kontributor Utama\n+ MisterCuteX - Mega Explosion, Respawn Hack\n+ tehtmi - Pembuat unluac (dan helper dekompilasi)\n+ Crystal_Mods100x - Menu ICE\n+ Latic AX & ToxicCoder - untuk menyediakan skrip yang telah dihapus melalui YT & MediaFire\n+ AGH - Value WallHack,CarHealth GG (tidak terimakasih untuk enkripsi yang sangggat giilaaa)\n+ GKTV - Skrip GG Payback2 (wall hack,big body,colored tree,big flamethower item,shadow,esp)\n+ JokerGGS - Value No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4 Drawing GG",
Disclaimmer			 = "Disklaimmer (mohon untuk dibaca)",
Disclaimmer_Text = "DISKLAIMMER:\n	TOLONG JANGAN menyalahgunakan skrip ini untuk menjahili pemain lain.\n	Saya TIDAK BERTANGGUNG JAWAB atas kerusakan yang anda sebabkan karena MENGGUNAKAN skrip ini.\n	Ingat untuk menjaga kesabaran anda dari pemain lain.\n	Saya merekomendasikan menggunakan skrip ini HANYA di mode offline.\n	Saya membuat ini karena tidak ada orang lain yang membagikan skrip cheat mereka.",
Exit_ThankYouMsg = "	Jika Anda mengalami bug, laporkan pada laman GitHub saya: https://github.com/ABJ4403/Payback2_CHEATus/issues\n	Jika Anda memiliki sesuatu untuk ditanyakan, Anda dapat memulai diskusi di https://github.com/ABJ4403/Payback2_CHEATus/discussions\n	Jika Anda ingin tahu lebih banyak tentang cheat ini, atau hal-hal FAQ lainnya, kunjungi https://github.com/ABJ4403/Payback2_CHEATus/wiki",
License					 = "Lisensi",
License_Text		 = "Payback2 CHEATus, Cheat Skrip LUA untuk GameGuardian\n© 2021-2022 ABJ4403\n\nProgram ini adalah perangkat lunak gratis: Anda dapat mendistribusikan kembali dan/atau memodifikasi\ndi bawah ketentuan lisensi publik umum GNU seperti yang diterbitkan oleh\nFree Software Foundation, baik lisensi versi 3, atau\n(pada opsi Anda) versi yang lebih baru.\n\nProgram ini didistribusikan dengan harapan bahwa itu akan berguna,\nTETAPI TANPA JAMINAN; bahkan tanpa jaminan tersirat dari\nKELAYAKAN JUAL atau KELAYAKAN UNTUK KEGUNAAN TERTENTU.	Lihat\nGNU Lisensi Publik Umum untuk detail lebih lanjut.\n\nAnda seharusnya menerima salinan Lisensi Publik Umum GNU\nbersama dengan program ini. Jika tidak, lihat https://gnu.org/licenses",
Settings				 = "Pengaturan",
Suspend					 = "Suspensi",
Suspend_Detected = "File suspensi terdeteksi, melanjutkan dari suspensi...",
Suspend_Text		 = "Anda keluar dari program melalui opsi suspensi. Anda bisa melanjutkan sesi saat ini dengan meluncurkan skrip ini, Jika anda memulai ulang game, sesi sebelumya tidak akan berguna (Luncurkan skrip dan pilih keluar, atau hapus file suspensi untuk membuang sesi suspensi)",
Title_Version		 = "Payback2 CHEATus v"..cfg.VERSION..", oleh ABJ4403."
}
}
function f(i,...)return lang[curr_lang][i]or string.format(i,...)end

-- Restore suspend file if any
restoreSuspend()

--detect if gg gui was open/floating gg icon clicked. if so, close that & show our menu instead (dont worry, we have suspend feature now).
while true do
	if gg.isVisible() then
		gg.setVisible(false)
		MENU()
		gg.clearResults()
		collectgarbage()
	end
	sleep(100)
end
