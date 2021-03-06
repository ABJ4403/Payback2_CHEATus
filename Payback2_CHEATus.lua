-- predefine local variables (can possibly improve performance according to lua-users.org wiki)
local gg,io,os = gg,io,os -- precache the usual call function (faster function call)
gg.getFile,gg.getTargetInfo,gg.getTargetPackage = gg.getFile(),gg.getTargetInfo(),gg.getTargetPackage() -- prefetch the gg output (faster data fetching w/o recall same function over&over, and cuts some MBs of used RAM)
gg.getFile = gg.getFile:gsub(".lua$","") -- strip the .lua for .conf and stuff
local susp_file,cfg_file = gg.getFile..'.suspend.json',gg.getFile..'.conf' -- define config and suspend files
local tmp,revert,memOzt,memOffset,t,curVal,CH = {},{},{},{},{} -- blank stuff for who knows...
-- Cheat menus --
function MENU()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Wall Hack",
		"2. Strong veichle",
		"3. No blast damage",
		"4. Pistol/SG Knockback",
		"5. Flood Respawn/RC Spam/Win Brawl/Swag Deliver 0 timer",
		"6. C4 auto-trigger",
		"——\nOther cheats:",
		"7. God modes",
		"8. Client-side cheats",
		"9. Match modifier",
		"——",
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
	elseif CH == 6 then cheat_c4autorigg()
---Title:Othercheat..
	elseif CH == 8 then MENU_godmode()
	elseif CH == 9 then MENU_CSD()
	elseif CH == 10 then MENU_matchmode()
---
	elseif CH == 12 then MENU_settings()
	elseif CH == 13 then show_about()
	elseif CH == 14 then exit()
	elseif CH == 15 then suspend() end
	CH = nil
	if type(tmp)=="table" then for k in pairs(tmp)do tmp[k]=nil end else tmp={}end
end
function MENU_CSD()
--Let the user choose stuff
	local CH = gg.choice({
		"Client-side cheats\nSome cheats won't affect other player",
		"1. Running speed modifier",
		"2. Walk animation Wonkyness (client-side only)",
		"3. Change Name (EXPERIMENTAL)",
		"4. Change Name Color (EXPERIMENTAL)",
		"5. Change XP/Coin",
		"6. Explosion Power",
		"7. Explosion Direction",
		"8. Particle interval (Slow/Fast explosion)",
		"9. Reflection Graphics",
		"10. Colored trees",
		"11. Car drift",
		"12. Big body",
		"13. Big Flamethrower (Item)",
		"14. Shadows",
		"15. Colored Peoples (ESP)",
		"16. Delete All Names",
		"——",
		f"__back__"
	},nil,f"Title_Version")
--Title:CSD...
	if CH == 2 then cheat_runspeedmod()
	elseif CH == 3 then cheat_walkwonkyness()
	elseif CH == 4 then cheat_changeplayername()
	elseif CH == 5 then cheat_changeplayernamecolor()
	elseif CH == 6 then cheat_xpmodifier()
	elseif CH == 7 then cheat_explodepow()
	elseif CH == 8 then cheat_explodedir()
	elseif CH == 9 then cheat_prtclintrvl()
	elseif CH == 10 then cheat_reflectiongraphics()
	elseif CH == 11 then cheat_coloredtree()
	elseif CH == 12 then cheat_cardrift()
	elseif CH == 13 then cheat_bigbody()
	elseif CH == 14 then cheat_bigflamethroweritem()
	elseif CH == 15 then cheat_shadowfx()
	elseif CH == 16 then cheat_clrdpplsp()
	elseif CH == 17 then cheat_deleteingameplaytext()
---
	elseif CH == 19 then MENU() end
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
		"——",
		"Clear results",
		"Clear list items",
		"Clear results & list items",
		"Remove suspend file",
		"——",
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
		if cfg.entityAnchrSearchMethod == "wordWeaponAmmo" then tmp = 1
		elseif cfg.entityAnchrSearchMethod == "holdWeapon" then tmp = 2
		elseif cfg.entityAnchrSearchMethod == "abjAutoAnchor" then tmp = 3 end
		local CH = gg.choice({
			"1. Weapon ammo (finds the weapon ammo, slowest method)",
			"2. Hold weapon (tells you to hold pistol/knife and find those values. faster, ~6 seconds)",
			"3. ABJ4403's Automatic anchor (Hold pistol, dont shoot, little bit Hold-Weapon-like. rarely fails)",
			f"__back__",
		},tmp,f"Title_Version")
		if CH then
			if CH == 5 then MENU_settings()
			elseif CH == 1 then cfg.entityAnchrSearchMethod = "wordWeaponAmmo"
			elseif CH == 2 then cfg.entityAnchrSearchMethod = "holdWeapon"
			elseif CH == 3 then cfg.entityAnchrSearchMethod = "abjAutoAnchor" end
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
		saveConfig()
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
	- On newer version of the game, now it stores data mostly on OTHER region (with the rest of the data stored in Calloc, and CodeApp),
	old version uses Ca,Ch,Jh,A (C++Alloc,C++Heap,JavaHeap,Anonymous)
	And also the previous value that is fail when tested, will fail even if you change memory region and still use same value
	- on version 121+ (specifically build 126), some offsets has been changed (specifically the Xa stuff)
	- If you play on buila 126, use Payback2_CHEATus.126.lua instead.
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
		"——",
		"16. Clone player",
		"17. Change vehicle color",
		"18. Veichle jet",
		"19. Fast car acceleration",
		"20. Change car wheel height",
		"21. Win (known to work on Rampage, others not tested yet)",
		"——",
		"22. Rel0ad OFF",
		"23. Immortality OFF",
		"24. C4 Drawing OFF",
		"25. Speed Slide OFF",
		"26. Float Hack OFF",
		"27. Ragdoll Hack OFF",
		"28. Normal body",
		"29. Normal drowned",
		"30. Disable veichle jet",
		"——",
		f"__back__"
	},nil,"God modes\nWARN: DON'T USE THIS TO ABUSE/HARM OTHER NON-CHEATER PLAYERS IN ANY WAY!!")
	if CH then
		if CH[34] then MENU()return end
		gg.setRanges(gg.REGION_OTHER + gg.REGION_ANONYMOUS)
		local anchorAddress = findEntityAnchr()
		if not anchorAddress then
			toast('Can\'t find the value, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			t = {}
			tmp.nca = anchorAddress
			if CH[1] or CH[2] then
				tmp.a = {
					{a=0x1C,n='Shotgun'},
					{a=0x1E,n='Rocket'},
					{a=0x20,n='Flamethrower'},
					{a=0x22,n='Grenade'},
					{a=0x24,n='Minigun'},
					{a=0x26,n='Explosives'},
					{a=0x28,n='Turret'},
					{a=0x2A,n='Laser'},
				}
				for i=1,#tmp.a do
					tmp.a[i].address = (tmp.nca + tmp.a[i].a)
					tmp.a[i].name = 'Pb2Chts [Weapon]: '..(tmp.a[i].n)
					tmp.a[i].flags = gg.TYPE_WORD
					tmp.a[i].freeze = CH[2]
					tmp.a[i].value = 3e4
					tmp.a[i].a = nil
					tmp.a[i].n = nil
				end
				if CH[2] then
				--if freeze enabled addListItems must be used, just using setValues wont work...
					t = table.append(t,tmp.a)
				else
				--if freeze disabled, addListItems will make a mess instead, so just set values here, and dont add to list item.
					gg.setValues(tmp.a)
				end
				tmp.a = nil
			end
			if CH[3] or CH[4] then
				tmp.a = {{address=tmp.nca+0x84,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Rel0adTimer]"}}
				if CH[4] then
					local grenadeRange = gg.prompt({"Put your grenade range\nHold your grenade if you use this setting\nignore the throw range and disables delay by setting this to 0 [0;100]"},{100},{"number"})
					if grenadeRange and grenadeRange[1] and grenadeRange[1] ~= "0" then
						toast("Wait for it")
						tmp.a[1].value = grenadeRange[1]
						gg.setValues({{address=tmp.nca+0x18,flags=gg.TYPE_WORD,value=3,name="Pb2Chts [HoldWeapon]: Grenade"}})
						gg.setValues(tmp.a)
						gg.addListItems(tmp.a)
						sleep(999)
					end
					tmp.a[1].value = -63
				end
				t = table.append(t,tmp.a)
			end
			if CH[5] or CH[6] or CH[7] then -- is this a good idea?
				tmp.isNoSteal = CH[5]
				tmp.isImmortal = CH[6]
				tmp.isDestroy = CH[7]
				t = table.append(t,{
					{address=tmp.nca+0x8,flags=gg.TYPE_WORD,freeze=true,value=(tmp.isNoSteal and -501 or 800),name="Pb2Chts [Health]"},
					{address=tmp.nca+0x158,flags=(tmp.isDestroy and gg.TYPE_WORD or gg.TYPE_FLOAT),freeze=true,value=((tmp.isImmortal or tmp.isDestroy) and 1 or 0),name="Pb2Chts [RespawnInterval]"},
				})
				tmp.isNoSteal,tmp.isImmortal,tmp.isDestroy = nil,nil,nil
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
			if CH[12] or CH[5] then t = table.append(t,{
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
				{address=tmp.nca-0x60E,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Dr0wned]"},
			})
			end
			---
			if CH[17] then
			--This will clone the player (you). How this is done?
			--First told user (you) to change the weapon to your loved weapon before the user cant do it anymore
				toast("[ClonePlayer] Change the weapon you want before you can\'t change it anymore")
				sleep(3e3)
			--Then, make the game think you are dead by changing 0xXXXXXXDA (Control state code) from 512 (Control.Player) to 2000 (Died.Wasted)
				gg.setValues({{address=tmp.nca+0xDA,flags=gg.TYPE_WORD,value=2e3}})
				sleep(2e3)
				t = table.append(t,{
					{address=tmp.nca+0xDA,flags=gg.TYPE_WORD,value=512,freeze=true,name="Pb2Chts [ControlState]"}
				})
			end
			if CH[19] then t = table.append(t,{
				{address=tmp.nca-0x1AC,flags=gg.TYPE_WORD,value=1,name="Pb2Chts [Enable jet]"},
			})
			end
			if CH[20] then t = table.append(t,{
				{address=tmp.nca-0x210,flags=gg.TYPE_WORD,value=3,name="Pb2Chts [CarAccelEngType]"},
				{address=tmp.nca-0x206,flags=gg.TYPE_WORD,value=0,name="Pb2Chts [CarSpeed]"},
				{address=tmp.nca-0x202,flags=gg.TYPE_WORD,value=2e4,name="Pb2Chts [CarSpeed]"}
			})
			end
			if CH[21] then
				local wheelHeight = gg.prompt({"Set your custom wheel height [-1;16000]"},{15000},{"number"})
				if wheelHeight and wheelHeight[1] and wheelHeight[1] ~= "-1" then
					t = table.append(t,{
						{address=tmp.nca-0x3EA,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel1]: Height"},
						{address=tmp.nca-0x3DE,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel2]: Height"},
						{address=tmp.nca-0x3D2,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel3]: Height"},
						{address=tmp.nca-0x3C6,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel4]: Height"},
						{address=tmp.nca-0x3BA,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel5]: Height"},
						{address=tmp.nca-0x3AE,flags=gg.TYPE_WORD,value=wheelHeight[1],name="Pb2Chts [CarWheel6]: Height"}
					})
				end
			end
			if CH[22] then t = table.append(t,{
				{address=tmp.nca+0x30,flags=gg.TYPE_DWORD,value=9e8,freeze=true,name="Pb2Chts [Win] (remove this after you win match)"},
			})
			end
			---
			if CH[24] then t = table.append(t,{
				{address=tmp.nca+0x84,flags=gg.TYPE_WORD,freeze=false,value=0,name="Pb2Chts [Rel0adTimer]"}
			})
			end
			if CH[25] then t = table.append(t,{
				{address=tmp.nca+0x8,flags=gg.TYPE_WORD,freeze=false,value=999,name="Pb2Chts [Health]"},
				{address=tmp.nca+0x158,flags=gg.TYPE_FLOAT,freeze=false,value=0,name="Pb2Chts [RespawnInterval] (Immortal)"}
			})
			end
			if CH[26] then t = table.append(t,{
				{address=tmp.nca+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: X"},
				{address=tmp.nca+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=false,name="Pb2Chts [C4Position]: Y"}
			})
			end
			if CH[27] then t = table.append(t,{
				{address=tmp.nca+0x86,flags=gg.TYPE_WORD,freeze=false,value=0,name="Pb2Chts [SpeedSlide]"}
			})
			end
			if CH[28] then t = table.append(t,{
				{address=tmp.nca-0x408,flags=gg.TYPE_DWORD,value=0,freeze=false,value=0,name="Pb2Chts [Float]"}
			})
			end
			if CH[29] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,name="Pb2Chts [Ragdoll]"},
				{address=tmp.nca+0x128,flags=gg.TYPE_DWORD,value=65536,freeze=false,name="Pb2Chts [Ragdoll]"}
			})
			end
			if CH[30] then t = table.append(t,{
				{address=tmp.nca-0x4,flags=gg.TYPE_DWORD,value=0,freeze=false,value=0,name="Pb2Chts [BodyBurningStateAndTimer]: Normal"},
			})
			end
			if CH[31] then t = table.append(t,{
				{address=tmp.nca-0x610,flags=gg.TYPE_DWORD,value=1,freeze=false,value=0,name="Pb2Chts [Dr0wned]"},
			})
			end
			if CH[32] then t = table.append(t,{
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
					"——— [Click here to "..f"__cancel__".."]",
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
				---cancel
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
function MENU_matchmode()
--Let the user choose stuff
	local CH = gg.multiChoice({
		"Weapon Ammo",
		"void mode (+void/no time limit)",
		"——",
		f"__back__"
	},nil,"Match mode modifier")
	if CH then
		if CH[4] then MENU()return end
		gg.setRanges(gg.REGION_ANONYMOUS + gg.REGION_OTHER)
		local ta = handleMemOzt('MatchOffset',1217115234,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther)
		if not ta[1] then
			toast('Can\'t find the value, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
		--Set 1P and 2P anchor on map seperately instead of using orignal anchor above.
			t = {}
			ta = ta[1].address
			ta = {
				ta+0xB4,
				ta+0x1C4
			}

		--whatever cheat & offset bits & bobs begin here...
			if CH[1] then
				tmp.a = {
					{a=0x58,v=3e4},
					{a=0x5C,v=3e4},
					{a=0x60,v=3e4},
					{a=0x64,v=3e4},
					{a=0x68,v=3e4},
					{a=0x6C,v=3e4},
					{a=0x70,v=3e4},
					{a=0x74,v=1e3},
				}
				for i=1,#tmp.a do
					tmp.a[i].f = gg.TYPE_DWORD
				end
				t = table.append(t,tmp.a)
			end
			if CH[2] then
				tmp.a = {
					{a=0,v=9},
					{a=0x1C,v=6},
				}
				for i=1,#tmp.a do
					tmp.a[i].f = gg.TYPE_DWORD
				end
				t = table.append(t,tmp.a)
			end

		--unpack the "minified" tables to be usable with GG API
			for i=1,#t do
			--Apply for both 1P and 2P
			--Make 1st offset for 1P
				t[i].address = (ta[1] + t[i].a)
				t[i].value = t[i].v
				t[i].flags = t[i].f
			--and make a 2nd copy
				t[i+#t] = {
					address = (ta[2] + t[i].a),
					value = t[i].value,
					flags = t[i].flags
				}
			--nil ununsed shortened hashes
				t[i].a = nil
				t[i].v = nil
				t[i].f = nil
			end
		--clear temporary random table
			tmp.a = nil
		--set the value like usual
			gg.setValues(t)
			gg.addListItems(t)
			gg.clearResults()
			toast('Selected operations done')
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
		"——",
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
			if not memOzt.PistolKnockback then
				gg.searchNumber(1067869798,gg.TYPE_DWORD)
				tmp[1]=gg.getResults(5e3)
				for i=1,#tmp[1] do
					tmp[1][i].address = (tmp[1][i].address - 0xC)
					tmp[1][i].flags = gg.TYPE_FLOAT
				end
				gg.loadResults(tmp[1])
				gg.refineNumber(curVal.PstlSgKnckbck)
			end
		--specially crafted for above conditions
			handleMemOzt("PistolKnockback",curVal.PstlSgKnckbck,nil,gg.TYPE_FLOAT,2)
			if gg.getResultCount() == 0 then
				memOzt.PistolKnockback,revert.PistolKnockback = nil,nil
				toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i=1,#memOzt.PistolKnockback do
					memOzt.PistolKnockback[i].value = PISTOL_KNOCKBACK_VALUE
				end
				curVal.PstlSgKnckbck = PISTOL_KNOCKBACK_VALUE
				toast("Pistol/SG Knockback "..curVal.PstlSgKnckbck)
				gg.setValues(memOzt.PistolKnockback)
			end
		end
		PISTOL_KNOCKBACK_VALUE = nil
	end
end
function cheat_wallhack()
	local CH,tmp = gg.choice({
		"GKTV, ON (wonky physics, fast to enable, survives multiple match, and can wallhack other entities not just a wall)",
		"GKTV, OFF",
		"AGH, ON (physics works best. need to reapplied every match, takes slightly longer than GKTV)",
		"AGH, OFF",
		"——",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Wall Hack. Warn:\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for CTS in Metropolis, because there\'s less holes there"),nil
	if CH == 8 then MENU()
-- Set value that is going to be searched using logic after this `if CH elseif end`
	elseif CH == 1 then tmp={1,1e-3,-1,"ON"}
	elseif CH == 2 then tmp={1,-1,1e-3,"OFF"}
	elseif CH == 3 then tmp={2,1140457472,-1,"ON"}
	elseif CH == 4 then tmp={2,-1,1140457472,"OFF"}
	---
	elseif CH == 6 then
		gg.setValues(revert.wallhack_agh)
		gg.setValues(revert.wallhack_gktv)
		revert.wallhack_agh,revert.wallhack_gktv = nil,nil
		toast("Previous value restored, be warned though this will cause instability")
		cheat_wallhack()
	elseif CH == 7 then
		CH,memOzt.wallhack_agh,memOzt.wallhack_gktv = nil,nil,nil
		toast("Memory buffer cleared")
		cheat_wallhack()
	end
	if tmp then
		if tmp[1] == 1 then
			gg.setRanges(gg.REGION_CODE_APP)
			if memOzt.wallhack_gktv then
				toast('Previous result found, using previous result.')
			else
				toast('No buffer found, creating new buffer.')
				gg.searchNumber("3472W;5W;"..tmp[2].."F;-17789W::15") -- wall hack
				gg.refineNumber(tmp[2],gg.TYPE_FLOAT)
				tmp[6] = gg.getResults(1)
				log("Results: "..gg.getResultsCount())
				gg.clearResults()
				gg.searchNumber("2W;16256W;"..tmp[2].."F;24W::9") -- veichle wallhack
				gg.refineNumber(tmp[2],gg.TYPE_FLOAT)
				table.insert(tmp[6],gg.getResults(1)[1])
				log("Results: "..gg.getResultsCount())
				memOzt.wallhack_gktv,revert.wallhack_gktv = tmp[6],tmp[6]
			end
			gg.loadResults(memOzt.wallhack_gktv)
			if #memOzt.wallhack_gktv == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				if #memOzt.wallhack_gktv == 1 then log("Only found 1 result instead of 2 results.\n        Wallhack might partially or not working\n        try to play on build 121.") end
				for i=1,#memOzt.wallhack_gktv do
					memOzt.wallhack_gktv[i].value = tmp[3]
				end
				gg.setValues(memOzt.wallhack_gktv)
				toast("Wall Hack "..tmp[4])
			end
		else
			gg.setRanges(gg.REGION_C_ALLOC)
			if not memOzt.wallhack_agh then
			--Optimized group search of: "576F;"..tmp[2].."D;576F::9"
				gg.searchNumber(576,gg.TYPE_FLOAT)
				t=gg.getResults(1e3) for i=1,#t do t[i].address = (t[i].address + 0x8) end gg.loadResults(t) gg.refineNumber(576)
				t=gg.getResults(1e3) for i=1,#t do t[i].address = (t[i].address - 0x4) t[i].flags = gg.TYPE_DWORD end gg.loadResults(t) gg.refineNumber(tmp[2])
				t=nil
			end
			handleMemOzt("wallhack_agh",tmp[2],nil,gg.TYPE_DWORD,1e3)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i=1,#memOzt.wallhack_agh do
					memOzt.wallhack_agh[i].value = tmp[3]
				end
				gg.setValues(memOzt.wallhack_agh)
				toast("Wall Hack "..tmp[4])
			end
		end
	end
end
function cheat_bigbody()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Restore previous value",
		"Use custom value",
		f"__back__"
	},nil,"Big body\nPS: client-side only. affects everyone you see, not just you. other player cant see the changes")
	if CH then
		local t
		if CH == 5 then MENU()
		elseif CH == 1 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody",4.30000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(curVal.BigBody+0.00000019073,gg.TYPE_FLOAT)
				toast("Big Body ON")
			end
		elseif CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody",curVal.BigBody+0.00000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(4.30000019073,gg.TYPE_FLOAT)
				toast("Big body OFF")
			end
		elseif CH == 3 then
			if revert.bigbody then
				gg.setValues(revert.bigbody)
				toast("Big body previous value restored")
			else
				toast("No values to restore")
			end
			revert.bigbody = nil
		elseif CH == 4 then
			local CH = gg.prompt({'Put your custom value (Game default: 4.3,Cheatus default: 5.9, offset: .00000019073)'},{curVal.BigBody},{'number'})
			if CH and CH[1] ~= "" then curVal.BigBody = CH[1] end
			CH = nil
			cheat_bigbody()
		end
		t = nil
	end
end
function cheat_strongveichle()
	local CH = gg.choice({
		"ON (30000)",
		"OFF (125)",
		"Destroy (-1)",
		"Custom",
		"——",
		"Change current health variable",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Veichle default health modifier")
	if CH then
		if CH == 9 then MENU()
		elseif CH == 1 then CAR_HEALTH_VALUE = 3e4
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
					memOzt.CarHealth[i].flags = gg.TYPE_WORD
					memOzt.CarHealth[i].value = CAR_HEALTH_VALUE
				end
				curVal.CrDfltHlth = CAR_HEALTH_VALUE
				gg.setValues(memOzt.CarHealth)
				toast("Veichles default health "..curVal.CrDfltHlth)
			end
		end
		CAR_HEALTH_VALUE = nil
	end
end
function cheat_noblastdamage()
	local CH = gg.choice({
		"ON (0)",
		"Default (300)",
		"Feather death (3.000.000, dead with almost any explosed explosion)",
		"——",
		"Change current damage value",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"No blast damage")
	if CH then
		if CH == 8 then MENU()
		elseif CH == 1 then DAMAGE_INTENSITY_VALUE = 0
		elseif CH == 2 then DAMAGE_INTENSITY_VALUE = 300
		elseif CH == 3 then DAMAGE_INTENSITY_VALUE = 3e6
		---
		elseif CH == 5 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{curVal.DmgIntnsty},{'number'})
			if CH and CH[1] then curVal.DmgIntnsty = CH[1] end
			cheat_noblastdamage()
		elseif CH == 6 then
			CH,revert.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		elseif CH == 7 then
			CH,memOzt.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		end
		if DAMAGE_INTENSITY_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("NoBlastDamage",curVal.DmgIntnsty..";2e9::5",curVal.DmgIntnsty,gg.TYPE_FLOAT,9)
			if gg.getResultCount() == 0 then
				memOzt.NoBlastDamage,revert.NoBlastDamage = nil,nil
				toast("Can't find the specific set of number. if you changed the blast intensity value and reopened the script, restore the actual current number using 'Change current damage value' menu")
			else
				for i=1,#memOzt.NoBlastDamage do
					memOzt.NoBlastDamage[i].value = DAMAGE_INTENSITY_VALUE
				end
				curVal.DmgIntnsty = DAMAGE_INTENSITY_VALUE
				toast("Blast damage intensity "..curVal.DmgIntnsty)
				gg.setValues(memOzt.NoBlastDamage)
			end
		end
		DAMAGE_INTENSITY_VALUE = nil
	end
end
function cheat_floodspawn()
	CH = gg.choice({
		"Activate",
		"Activate v2 (EXPERIMENTAL, yolo-edit-all values)",
		"Clear memory buffer",
		"Clear buffer and Activate",
		"Back"
	},nil,"Flood Respawn. WARNING:\n- DO NOT USE THIS TO HARM OTHER PLAYER!!!\n- THIS CHEAT IS TECHINCALLY POWERFUL, BECAUSE IT DROPS SERVER TPS AND LAG PLAYERS. ONLY USE IT OFFLINE!!\n- if you use this for racing stuff, consider lowering your freeze range to ~40.000-100.000 if after reaching checkpoint wont move to next checkpoint.")
	if CH then
		if CH == 5 then MENU() end
		if CH == 3 or CH == 4 then
			memOzt.respawnCheat = nil
			if CH == 3 then cheat_floodspawn() end
		end
		if CH == 1 or CH == 2 or CH == 4 then
			gg.setRanges(gg.REGION_OTHER)
			if CH == 1 then
				t = handleMemOzt("respawnCheat",52428800,nil,gg.TYPE_DWORD,10,cfg.memZones.Common_RegionOther)
			else
				gg.clearResults()
				gg.searchNumber(52428800,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
				t = gg.getResults(gg.getResultCount())
			end
			if gg.getResultCount() == 0 then
				toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				if CH ~= 2 then searchWatchdog("Now trigger respawn animation (by respawning yourself through pause menu)","52428801~52429000","respawnCheat") end
				if gg.getResultCount() == 0 then
					toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
				else
					local CH = gg.prompt({
						"Put the respawn duration (in seconds)\n0:No duration\n-1:No respawn hack [-1;20]",
						"RC Car Spam",
						"Win Brawl (client-side only)",
						"Swag Delivery disable timer",
						"Freeze camera entity ID"
					},{
						1,
						false,
						false,
						false,
						false
					},{
						"number",
						"checkbox",
						"checkbox",
						"checkbox",
						"checkbox"
					})
					if CH then
					--2nd table that dont affected by timer and crap
						local ta = {}
					--prepare respawn/rccarspam/winbrawl values
						for i=1,#t do
							t[i].value = 52428801
							t[i].freeze = true
							t[i].name = "Pb2Chts [RespawnHack]"
							if CH[2] then -- rc spam
								ta = table.append(ta,{{
									address = t[i].address - 0xE,
									flags = gg.TYPE_WORD,
									value = -1,
									freeze = true,
									name = "Pb2Chts [RCCarSpam]"
								}})
							end
							if CH[3] then -- win brawl
								ta = table.append(ta,{{
									address = t[i].address - 0x14,
									flags = gg.TYPE_DWORD,
									value = 9e6,
									freeze = true,
									name = "Pb2Chts [WinBrawl]"
								}})
							end
							if CH[4] then -- swag deliver 0 timer
								ta = table.append(ta,{{
									address = t[i].address + 0xE,
									flags = gg.TYPE_WORD,
									value = 0,
									freeze = true,
									name = "Pb2Chts [SwagDeliverTim0r]"
								}})
							end
						--[[if CH[5] then -- lock camera entity id
							--fetch current entity cam id
								gg.loadResults({{
									address = t[i].address + 0xE,
									flags = gg.TYPE_WORD,
								}})
								ta = table.append(ta,{{
									address = t[i].address + 0xE,
									flags = gg.TYPE_WORD,
									value = gg.getResults(1)[1].value,
									freeze = true,
									name = "Pb2Chts [SwagDeliverTim0r]"
								}})
							end]]
						end
					--set respawn hack if not disabled (not -1)
						if CH ~= "-1" then
  					--set respawn hack
  						gg.setValues(t)
  						gg.addListItems(t)
  					end
					--set rc car spam if enabled
						if ta[1] then
							gg.setValues(ta)
							gg.addListItems(ta)
						end
					--since the only thing required in CH is only the 1st option, change the whole table to that instead
						CH = CH[1]
					--if no duration
						if CH == "0" then
							toast("Flood Respawn ON\nRemember to turn off again by using \"Clear list items\" button in settings")
					--if not disabled
						elseif CH ~= "-1" then
							toast("Flood Respawn ON for "..CH.." seconds")
						--Way to sleep for a long time but cancellable by user too, which is great
							for i=1,CH do
								if gg.isVisible() then
									gg.setVisible(false)
									break
								end
								sleep(1e3)
							end
						--restore the value back by removing list items ??? (heres the problem, what if it stays freezed even if removed from list?)
							gg.removeListItems(t)
							toast("Flood Respawn OFF")
						end
					end
				end
			end
		end
	end
	CH = nil
end
function cheat_c4autorigg()
	local totalC4sRigged = 0
	gg.setRanges(gg.REGION_C_BSS + gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	gg.clearResults()
--search c4s control code
	gg.searchNumber(83886336,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
	local t = gg.getResults(1e3)
--Offset -0xD0 (health), load its result
	for i=1,#t do
		t[i].address = (t[i].address - 0xD0)
		t[i].flags = gg.TYPE_WORD
	end
	gg.loadResults(t)
--Refine health 100 (which is C4s health), check if it actually located in [5d]08, and set to 0 if so
	gg.refineNumber(100)
	t = gg.getResults(1e3) for i=1,#t do
		tmp0 = string.format("%x",t[i].address)
		if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then
			t[i].value = 0
			totalC4sRigged = totalC4sRigged + 1
		else
			t[i] = nil
		end
	end
	if totalC4sRigged == 0 then
		gg.toast("Can't find any C4s, is there any C4 bombs planted?")
	else
		gg.setValues(t)
		gg.toast(totalC4sRigged.." C4s rigged!")
	end
end
function cheat_runspeedmod()
	CH = gg.choice({
		"400",
		"120 (Default)",
		"Back"
	},nil,"Running speed modifier (Controllable, CodeApp implementation)")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={15120,15400,"400"}
		elseif CH == 2 then tmp={15400,15120,"120"} end
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("runSpeed",tmp[1].."W;1186693120D;985158124D;1114636288D::12",tmp[1],gg.TYPE_WORD,1)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find specific set of number")
		else
		  gg.editAll(tmp[2],gg.TYPE_WORD)
			gg.toast("Running speed "..tmp[3])
		end
	end
end
function cheat_xpmodifier()
--gg.REGION_C_BSS + // Not ready yet especially because JokerGGS mentioned a problem with CBSS Region.
	gg.setRanges(gg.REGION_ANONYMOUS + gg.REGION_OTHER)
	local CH = gg.prompt({
		'Put your new XP (Play Game limit is 999999, while DWORD limit is 1.999.999.998)',
		'Put your new coin (maximum 32767, temporary, not recommend if you have infinite coin coz it might get reset)',
		'Freeze XP',
		'Freeze Coin',
		'Enable skip slow intro animation',
		'Win CTS match',
	},{999999,-1,true,false,false,false},{'number','number','checkbox','checkbox','checkbox','checkbox'})
	if CH then
		tmp[1] = handleMemOzt("CustomXP",1014817001,nil,gg.TYPE_DWORD,1)
		if gg.getResultCount() == 0 then
			toast('Can\'t find the specific number.')
		else
			t = {}
			tmp[1] = tmp[1][1].address
			if CH[1] and CH[1] ~= "" and CH[1] ~= "-1" then
				t = table.append(t,{{address=(tmp[1]-0x804),flags=gg.TYPE_DWORD,value=CH[1],freeze=CH[3],name="Pb2Chts [PlayerCurrentXP]"}})
			end
			if CH[2] and CH[2] ~= "" and CH[2] ~= "-1" then
				t = table.append(t,{{address=(tmp[1]-0x608),flags=gg.TYPE_WORD,value=CH[2],freeze=CH[4],name="Pb2Chts [PlayerCurrentCoin]"}})
			end
			if CH[5] then
				t = table.append(t,{{address=(tmp[1]-0x403B78),flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [SkipSlowAnimation]"}})
			end
			if CH[6] then
			--for win cts opponent, the offset is 0x403A2C
				t = table.append(t,{{address=(tmp[1]-0x403A30),flags=gg.TYPE_WORD,value=32767,freeze=true,name="Pb2Chts [WinCTS]"}})
			end
			gg.setValues(t)
			gg.addListItems(t)
			toast('Selected operations done')
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
		"——",
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
		player_color_choice = nil
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
	gg.setRanges(gg.REGION_CODE_APP) -- PS: 0.00999999978 > 0.3 for new version
	if CH == 5 then MENU()
	elseif CH == 1 then
		handleMemOzt("walkwonkyness","0.004~1;0.00999999978::5",nil,gg.TYPE_FLOAT,1)
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
			toast("Can't find the specific set of number")
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
	elseif CH == 1 then tmp={49,1,"ON",true} -- << `,true` is trick from lua.org to make lua better prepare a memory slot area whatevr... (will be used for temporary result save below :)
	elseif CH == 2 then tmp={1,49,"OFF",true} end
	if CH and tmp[3] then
		gg.setRanges(gg.REGION_OTHER)
		if not memOzt.RfTgraphics then
			gg.searchNumber(144,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
			tmp[4]=gg.getResults(5e3) for i=1,#tmp[4] do tmp[4][i].address = (tmp[4][i].address + 0x8) tmp[4][i].flags = gg.TYPE_DWORD end gg.loadResults(tmp[4]) gg.refineNumber(50)
			tmp[4]=gg.getResults(5e3) for i=1,#tmp[4] do tmp[4][i].address = (tmp[4][i].address - 0x4) tmp[4][i].flags = gg.TYPE_DWORD end gg.loadResults(tmp[4]) gg.refineNumber(tmp[1])
		end
	--specially crafted for above conditions
		handleMemOzt("RfTgraphics",tmp[1],nil,gg.TYPE_DWORD,1)
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
		"——",
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
				memOzt.explodePower[1].value,curVal.XplodPow = EXPLOSION_POWER,EXPLOSION_POWER
				toast("Explosion power modified to "..curVal.XplodPow)
				gg.setValues(memOzt.explodePower)
			end
		end
		EXPLOSION_POWER = nil
	end
end
function cheat_explodedir()
	local CH = gg.choice({
		"Default (50000)",
		"OFF (0)",
		"Attractive/magnet (-50000)",
		"Custom",
		"——",
		"Change current value",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Explode direction")
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
			curVal.XplodDir = XPLODIR_VAL
			toast("Explosion direction is set to "..(curVal.XplodDir > 0 and "default" or curVal.XplodDir < 0 and "magnet" or curVal.XplodDir == 0 and "none"))
			gg.setValues(memOzt.explodeDir)
		end
	end
	XPLODIR_VAL = nil
end
function cheat_prtclintrvl()
	local CH = gg.choice({
		"No particle (0ms, increases FPS)",
		"Faster (9ms)",
		"Fast (20ms)",
		"Default (120ms)",
		"Slow (2s)",
		"Custom",
		"——",
		"Change current interval variable",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Particle interval modifier\nCurrent: "..curVal.PrtclAnmtnIntrvl)
	if CH == 10 then MENU()
	elseif CH == 1 then PARTICLE_INT = 0
	elseif CH == 2 then PARTICLE_INT = 9
	elseif CH == 3 then PARTICLE_INT = 20
	elseif CH == 4 then PARTICLE_INT = 120
	elseif CH == 5 then PARTICLE_INT = 2e3
	elseif CH == 6 then
		local CH = gg.prompt({'Input your custom interval value (in miliseconds)'})
		if CH and CH[1] then
			PARTICLE_INT = CH[1]
		else
			cheat_prtclintrvl()
		end
	---
	elseif CH == 8 then
		local CH = gg.prompt({'If you think the current interval value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current interval'},{curVal.PrtclAnmtnIntrvl},{'number'})
		if CH and CH[1] then curVal.PrtclAnmtnIntrvl = CH[1] end
		cheat_prtclintrvl()
	elseif CH == 9 then revert.PrtclAnmtnIntrvl = nil cheat_prtclintrvl()
	elseif CH == 10 then memOzt.PrtclAnmtnIntrvl = nil cheat_prtclintrvl()
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
			curVal.PrtclAnmtnIntrvl = PARTICLE_INT
			toast("Particle interval "..curVal.PrtclAnmtnIntrvl.."ms")
			gg.setValues(memOzt.PrtclAnmtnIntrvl)
		end
		PARTICLE_INT = nil
	end
end
function cheat_cardrift()
	local CH = gg.choice({
		"Modify drifting speed",
		"——",
		"Change current drifting speed",
		"Restore previous value",
		"Clear memory buffer",
		f"__back__"
	},nil,"Drifting speed modifier\nCurrent: "..curVal.DrftSpd.."\n")
	if CH == 6 then MENU()
	elseif CH == 1 then
		local CH = gg.prompt({'How fast you want the drifting rotation? Higher value is more powerful\nDefault:1 (1.3) [1;20]'},{curVal.DrftSpd},{'number'})
		if CH and CH[1] then
			DRIFT_SPEED = CH[1]..".3"
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
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("DrftSpd","120F;"..curVal.DrftSpd.."F;-712W::9",curVal.DrftSpd,gg.TYPE_FLOAT,1)
		if gg.getResultCount() == 0 then
			memOzt.DrftSpd,revert.DrftSpd = nil,nil
			toast("Can't find the specific set of number. if you changed the drift speed and reopened the script, restore current number using 'Change current drift speed' menu")
		else
			memOzt.DrftSpd[1].value,curVal.DrftSpd = DRIFT_SPEED,DRIFT_SPEED
			gg.setValues(memOzt.DrftSpd)
			toast("Explosion power modified to "..curVal.DrftSpd)
		end
	end
	DRIFT_SPEED = nil
end
function show_about()
	local CH = gg.choice({
		f"__about__",
		"——",
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
function table.tostring(t,dp)
	local d,r,tab,tv = 0,'{\n',function(i)
		str = ""
		for i=1,i+(dp or 0) do str = str.."\t" end
		return str
	end
	for k,v in pairs(t) do
		r = r..tab(d)
		if type(k) == 'string' then
			r = r..k..' = '
		end
		tv = type(v)
		if tv == 'table' then
			r = r..table.tostring(v,(dp or 0)+1)
		elseif tv == 'number' and #tostring(v) > 7 then
			r = r..'0x'..string.format("%x",v):gsub("%l",string.upper)
		elseif tv == 'boolean' or tv == 'number' then
			r = r..tostring(v)
		else
			r = r..'"'..v..'"'
		end
		r,tv = r..',\n',nil
	end
	return r:sub(1,r:len()-2)..'\n'..tab(d-1)..'}'
end
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
function handleMemOzt(memOztName,val,valRefine,valTypes,dsrdRslts,memZones)
--[[
	This function handles memory buffer related stuff by saving previous
	result and return that instead the next time the same search is requested.
	This optimization can only apply if the values not always changing.
	Best for memory region that is huge and taking long time to search.
]]
--default configs
	memZones = memZones or {0,-1}
	dsrdRslts = dsrdRslts or 1
--if buffer is found
	if memOzt[memOztName] then
	--load previous result
		toast('Previous result found, using previous result')
		gg.loadResults(memOzt[memOztName])
	else
	--or search new ones
		toast('No buffer found, creating new buffer')
		gg.searchNumber(val,valTypes,nil,nil,table.unpack(memZones))
	--optionally refine if valRefine is defined
		if valRefine then
			gg.refineNumber(valRefine,valTypes)
		end
		if gg.getResultCount() > 0 then
			memOzt[memOztName],revert[memOztName] = gg.getResults(dsrdRslts),gg.getResults(dsrdRslts)
		end
	end
	return gg.getResults(dsrdRslts)
end
function loopSearch(dsrdRslts,valueType,msg1,memZones)
	local num1,t = gg.prompt({msg1})
	memZones = memZones or {0,-1}
	if num1 and num1[1] then
	--Search within restricted memory address, which can be faster
		gg.searchNumber(num1[1],valueType,nil,nil,table.unpack(memZones))
		if gg.getResultCount() > 0 then
			while gg.getResultCount() > dsrdRslts do
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
					if t[1].value == t[2].value then return {t[1]} end
			--If nothing found...
				elseif tmp[1] == 0 then
					toast("Oh, this is weird 🤔️... We don't find the value you're searching for 🔍️. If you suspect memory restriction is the cause, edit the .lua.conf file generated in the script's location")
					sleep(500)
					break
				end
			end
			return gg.getResults(dsrdRslts)
		end
	end
end
function findEntityAnchr()
	gg.setRanges(gg.REGION_OTHER + gg.REGION_ANONYMOUS)
	local tmp,tmp0
	if cfg.entityAnchrSearchMethod == "holdWeapon" then
		toast("Hold your pistol")
		sleep(1e3)
		gg.searchNumber(13,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
		t = gg.getResults(200)
		for i=1,#t do
			tmp0 = string.format("%x",t[i].address)
			if not (tmp0:find('518$') or tmp0:find('d18$')) then t[i] = nil end
		end
		while gg.getResultCount() > 1 do
			toast("Hold your knife")
			sleep(2e3)
			gg.refineNumber(0)
			t = gg.getResults(200)
			if gg.getResultCount() == 1 then break
			elseif gg.getResultCount() == 0 then return
			elseif gg.getResultCount() == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
			toast("Hold your pistol")
			sleep(2e3)
			gg.refineNumber(13)
			t = gg.getResults(200)
			if gg.getResultCount() == 1 then break
			elseif gg.getResultCount() == 0 then return
			elseif gg.getResultCount() == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
		end
		tmp,tmp0=nil,nil
		gg.clearResults()
		return t[1].address - 0x18
	elseif cfg.entityAnchrSearchMethod == "abjAutoAnchor" then
		toast("Please wait for ~3 seconds... Don't shoot, Hold pistol.")
	--this ginormous packs of "battery" below is basically... just searching this in accurately optimized way: "120Q;2.80259693e-44F;1~30000D;13D;512~513W::45(?ehh,definitely more than 45 though...)"
	--and with this optimization too, we can get more accurate result faster.
	--TODO: maybe we can somehow allow shooting/hold pistol for split second? by shifting the searching order (but it cant be the one with "A;B" or "A~B", because group/range searching is slower than normal search)
		gg.searchNumber(1.68155816e-43,gg.TYPE_FLOAT,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/5 shooting state
		tmp=gg.getResults(5e3) for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEE) tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber('512~513')      -- 2/5 (ControlCode 512, sometimes 513 mostly happen on veichles)
		tmp=gg.getResults(5e3) for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC2) tmp[i].flags = gg.TYPE_DWORD end gg.loadResults(tmp) gg.refineNumber(13)             -- 3/5 (HoldWeapon 13)
		tmp=gg.getResults(5e3) for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x10)                              end gg.loadResults(tmp) gg.refineNumber('-501~30000')   -- 4/5 (Health -501+30000(because carhealth&nostealcar cheat))
		tmp=gg.getResults(5e3) for i=1,#tmp do tmp0 = string.format("%x",tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 5/5 (Anchor 20)
		tmp,tmp0=nil,nil
		if gg.getResultCount() > 0 then
			if gg.getResultCount() > 1 then
				log("[findEntityAnchor] Duplicate results detected! "..gg.getResultCount())
			end
			return gg.getResults(1)[1].address
		end
	elseif cfg.entityAnchrSearchMethod == "wordWeaponAmmo" then
		t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo',cfg.memZones.Common_RegionOther)
		gg.clearResults()
		gg.searchNumber(20,gg.TYPE_DWORD,nil,nil,t.address - 42,t.address - 6)
		return gg.getResultCount() > 0 and gg.getResults(1)[1].address or nil
	else
		toast("An error occured (InvalidConf): Exit out of script and see print log for more details.")
		print("[Error.InvalidConf]: Configuration value for \"cfg.entityAnchrSearchMethod\" ("..cfg.entityAnchrSearchMethod..") is invalid.\n         Possible values: wordWeaponAmmo, holdWeapon, abjAutoAnchor")
		log("Your Configuration:\n",cfg)
	end
end
function exit()
	saveConfig()
	gg.clearResults()
	print(f"Exit_ThankYouMsg")
	os.exit()
end
function suspend()
	gg.saveVariable({
		cfg=cfg,
		memOzt=memOzt,
		pid=gg.getTargetInfo.pid,
		revert=revert
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
function saveConfig()
	log("[saveConfig] Saving configuration to "..cfg_file)
	local fp = io.open(cfg_file,'w')
	io.output(fp)
	io.write("-- This is the configuration file for Payback2_CHEATus.\n-- You can customize any settings and parameters you want here (w/o messing that 'HUGE' script)\n-- Make sure you have a backup of this config file, because even a tiny bit of error/typo here results in config reader failed and your config file got reset\n-- Refer to my GitHub Wiki for some explanation (TODO)\n-- btw, please ignore the return thingy below :)\n\nreturn "..table.tostring(cfg))
	io.close(fp)
	fp = nil
end
function loadConfig()
	--[[
		Loads configuration file.
	]]
	cfg = {
		entityAnchrSearchMethod="abjAutoAnchor",
		memZones={
			Common_RegionOther={0xB0000000,0xCFFFFFFF},
			Common_RegionOtherB={0xB0000000,0xBFFFFFFF}
		},
		Language="auto",
		PlayerCurrentName=":Player",
		PlayerCustomName=":CoolFoe",
		VERSION="2.2.3",
		clearAllList=false,
		enableLogging=false
	}
	local cfg_load = loadfile(cfg_file)
	if cfg_load then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = table.merge(cfg,cfg_load)
	else
		toast("No configuration files detected, Creating new one...  💾️\nHi There! 👋️ Looks like You're new here.")
		saveConfig()
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
		susp = susp()
		os.remove(susp_file)
		if susp.pid == gg.getTargetInfo.pid then
			toast(f"Suspend_Detected")
			cfg = susp.cfg
			revert = susp.revert
			memOzt = susp.memOzt
		end
	end
	susp = nil
end
function log(...)if cfg.enableLogging then print("[Debug]",...)end end

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
	DrftSpd=1.3,
	BigBody=5.9,
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
Credits_Text		 = "Credit:\n+ Mangyu - Original script author\n+ mdp43140 - Main Contributor\n+ MisterCuteX - Mega Explosion,Respawn Hack\n+ tehtmi - unluac Creator (and decompile helper)\n+ Crystal_Mods100x - ICE Menu\n+ Latic AX & ToxicCoder - for providing removed script through YT & MediaFire\n+ AGH - for Wall Hack,Car Health GG Values (no thanks for ridicilous encrypted script though...)\n+ GKTV - PB2 GG script (wall hack,big body,colored tree,big flamethower item,shadow,esp)\n+ XxGabriel5HRxX - for Car wheel height and acceleration GG Offsets\n+ JokerGGS - for No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4 Drawing GG Values",
Disclaimmer			 = "Disclaimmer (please read)",
Disclaimmer_Text = "DISCLAIMMER:\n	Please DO NOT misuse the script to harm other Payback2 players.\n	I'm NOT RESPONSIBLE for your action with using this script.\n	Remember to keep your patience out of other players.\n	i recommend ONLY using this script in offline mode.\n	I made this because no one would share their cheat script.",
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
Credits_Text		 = "Kredit:\n+ Mangyu - Pembuat skrip original\n+ mdp43140 - Kontributor Utama\n+ MisterCuteX - Mega Explosion, Respawn Hack\n+ tehtmi - Pembuat unluac (dan helper dekompilasi)\n+ Crystal_Mods100x - Menu ICE\n+ Latic AX & ToxicCoder - untuk menyediakan skrip yang telah dihapus melalui YT & MediaFire\n+ AGH - Value WallHack,CarHealth GG (tidak terimakasih untuk enkripsi yang sangggat giilaaa)\n+ GKTV - Skrip GG Payback2 (wall hack,big body,colored tree,big flamethower item,shadow,esp)\n+ XxGabriel5HRxX - Untuk menyediakan offset Tinggi roda mobil, dan akselerasi mobil GG\n+ JokerGGS - Value No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4 Drawing GG",
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
