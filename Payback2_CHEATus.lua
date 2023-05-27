--— local variables ——————————————--
--- can reduce latency by couple miliseconds
local gg,io,os = gg,io,os -- cache table query to make it faster
gg.getFile,gg.getTargetInfo,gg.getTargetPackage,gg.getLocale = gg.getFile():gsub("%.lua$",""),gg.getTargetInfo(),gg.getTargetPackage(),gg.getLocale() -- prefetch some gg output, also strip .lua on gg.getFile
local susp_file,cfg_file = gg.getFile..'.suspend.json',gg.getFile..'.conf' -- define config and suspend files
local tmp,memOzt,t = {},{},{} -- blank table for who knows...
local curVal,CH,cfg,lastCfg,curr_lang,lang,translationTable -- preallocate stuff for who knows...
--————————————————————————————————--



--— Cheat menus ——————————————————--
--- Bunch of menus and cheat codes
function MENU()
	local CH = gg.choice({
		"1. "..f"Cheat_WallHack",
		"2. Floodspawn + others",
		"3. "..f"Cheat_C4AutoRig",
		"4. "..f"Cheat_GodModes",
		"5. "..f"Cheat_GodModes"..' bulk',
		"6. Pistol/SG Knockback",
		"7. "..f"Cheat_CSD",
		"8. Match modifier",
		"——",
		f"Settings",
		"__about__",
		"__exit__",
		f"Suspend"
	},nil,f"Title_Version")
	if CH == 1 then cheat_wallhack()
	elseif CH == 2 then cheat_floodspawn()
	elseif CH == 3 then cheat_c4autorigg()
	elseif CH == 4 then MENU_godmode()
	elseif CH == 5 then MENU_godmode_bulk()
	elseif CH == 6 then cheat_pistolknockback()
	elseif CH == 7 then MENU_CSD()
	elseif CH == 8 then MENU_matchmode()
---
	elseif CH == 10 then MENU_settings()
	elseif CH == 11 then show_about()
	elseif CH == 12 then exit()
	elseif CH == 13 then suspend() end
	CH,tmp = nil,{}
end
function MENU_CSD()
	local CH = gg.choice({
		f"Cheat_CSD".."\n"..f"Cheat_CSD_Notice",
		"1. Running speed modifier",
		"2. Strong vehicle",
		"3. No blast damage",
		"4. XP,Coin,etc",
		"5. Explosion Power",
		"6. Explosion Direction",
		"7. Particle interval (Slow/Fast explosion)",
		"8. Reflective Texture",
		"9. Colored trees",
		"10. Autoshoot Rocket",
		"11. Car drift",
		"12. Walk animation Wonkyness (visual)",
		"13. Change Name (EXPERIMENTAL)",
		"14. Change Name Color (EXPERIMENTAL)",
		"15. Big body",
		"16. Big Flamethrower (Visual item)",
		"17. Shadows",
		"18. Entity X-Ray (visual)",
		"19. Delete All Names",
		"——",
		"__back__"
	},nil,f"Title_Version")
--Title:CSD...
	if CH == 2 then cheat_runspeedmod()
	elseif CH == 3 then cheat_strongvehicle()
	elseif CH == 4 then cheat_noblastdamage()
	elseif CH == 5 then cheat_mtcScrnfx()
	elseif CH == 6 then cheat_explodepow()
	elseif CH == 7 then cheat_explodedir()
	elseif CH == 8 then cheat_prtclintrvl()
	elseif CH == 9 then cheat_reflectivetexture()
	elseif CH == 10 then cheat_coloredtree()
	elseif CH == 11 then cheat_autoshootrocket()
	elseif CH == 12 then cheat_cardrift()
	elseif CH == 13 then cheat_walkwonkyness()
	elseif CH == 14 then cheat_changeplayername()
	elseif CH == 15 then cheat_changeplayernamecolor()
	elseif CH == 16 then cheat_bigbody()
	elseif CH == 17 then cheat_bigflamethroweritem()
	elseif CH == 18 then cheat_shadowfx()
	elseif CH == 19 then cheat_plyxray()
	elseif CH == 20 then cheat_deleteingameplaytext()
---
	elseif CH == 22 then MENU() end
end
function MENU_settings()
	local CH = gg.choice({
		"Clear result & some list items",
		"——",
		"Change default & custom player name",
		"Change __language__",
		"Change entity anchor searching method",
		"——",
		"__save__ settings",
		"Reset settings",
		"__back__"
	},nil,f"Title_Version")
	if CH == 9 then MENU()
	---
	elseif CH == 1 then gg.clearResults() gg.clearList() toast('Cleared!')
	---
	elseif CH == 3 then
		CH = gg.prompt({'Default player name:','Default custom player name:'},{cfg.PlayerCurrentName,cfg.PlayerCustomName},{'text','text'})
		if CH then
			if CH[1] ~= "" then cfg.PlayerCurrentName = CH[1] end
			if CH[2] ~= "" then cfg.PlayerCustomName = CH[2] end
		end
		MENU_settings()
	elseif CH == 4 then
	--Add your language code below
		CH = gg.choice({
			["en_US"]="🇺🇸️ English",
			["in"]="🇮🇩️ Indonesia",
			["auto"]="Auto-detect (uses GameGuardian API, uses English as fallback)",
		},cfg.Language,f"Title_Version")
		if CH then
			cfg.Language = CH
			update_language()
		end
		MENU_settings()
	elseif CH == 5 then
		CH = gg.choice({
			"1. Hold weapon (Hold pistol/knife. ~6 seconds)",
			"2. Auto anchor (Hold pistol, dont shoot. Faster, rarely fails)",
			"3. Auto anchor 2 (finds any player/ai/vehicle)",
			"__back__",
		},cfg.entityAnchrSearchMethod,f"Title_Version")
		if CH then
			if CH > 0 and CH < 4 then cfg.entityAnchrSearchMethod = CH end
			MENU_settings()
		end
	---
	elseif CH == 7 then
		saveConfig()
		MENU_settings()
	elseif CH == 8 then
		cfg.clearAllList=false
		cfg.enableAutoMemRangeOpti=true
		cfg.enableLogging=false
		cfg.entityAnchrSearchMethod=2
		cfg.Language="auto"
		cfg.PlayerCurrentName=":Player"
		cfg.PlayerCustomName=":CoolFoe"
		toast("Current settings was reset.\n- If you accidentally clicked it, interrupt the script with the floating stop button and rerun the script.\n- If you sure to reset, save the setting")
		MENU_settings()
	end
	CH = nil
end
function MENU_godmode()
--Let the user choose stuff
	local CH = gg.multiChoice({
		"1. Top 10 Essentials (2,3,6,8,12,15,18,19,20,21,23)",
		--[[ Add your own set of favorite frequently used cheats here ]]
		"——",
		"2. Weapon Ammo",
		"3. Rel0ad Pistol,SG,Rocket,C4s",
		"4. Rel0ad Grenade", -- 5
		"5. Prevent car stealing",
		"6. Immortality",
		"7. Immortality (Self-explode)",
		"8. C4 Drawing",
		"9. Speed Sliding", -- 10
		"10 Float",
		"11. Ragdoll",
		"12. Anti-Burn body",
		"13. Burned body",
		"14. Burning body", -- 15
		"15. Dr0wned",
		"16. Clone",
		"17. Vehicle color",
		"18. Vehicle jet", -- 20
		"19. Fast car speed (+ other tweaks?)",
		"20. Translucent vehicle",
		"21. Disable vehicle noise",
		"22. Car wheel height",
		"23. Wanted star", -- 25
		"24. Win rampage (not instant)",
		"25. AI Control",
		"26. Auto unstuck car",
	},{true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true},f"Cheat_GodModes".."\n"..f"Cheat_GodModes_Notice")
	if CH then
		local achAdr,achAdrL = findEntityAnchr()
		if achAdr then
			achAdrL = #achAdr
			for i=1,achAdrL do
				toast('Applying god modes to '..i..'/'..achAdrL..' Entities...')
				cheat_godmode(CH,achAdr[i])
			end
			toast('Selected operations done')
			achAdr = nil
		else
			toast(f"ErrNotFound"..'. Try different entity anchor search method on settings, and disable memory optimization in config file.\nNothing worked? report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		end
	end
end
function MENU_matchmode()
--Let the user choose stuff
	local CH = gg.multiChoice({
		"Weapon Ammo",
		"void mode + no time limit",
		"Win CTS (client-side)",
		"——",
		"__back__"
	},nil,"Match mode modifier\nPS: Make sure you're on the main menu, not on match (this doesnt work while in match)")
	if CH then
		if CH[5] then return MENU()end
		gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_OTHER)
		local ta = handleMemOzt('MatchOffset',1217115234,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther)
		if ta[1] then
			t = {}
			ta = ta[1].address
			ta = {
				ta+0xB4, -- 1P
				ta+0x1C4, -- 2P
				ta
			}
		--Put the changes that applies to 1P & 2P here
			if CH[1] then table.append(t,{
				{a=0x58,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x5C,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x60,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x64,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x68,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x6C,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x70,value=3e4,flags=gg.TYPE_DWORD},
				{a=0x74,value=1e3,flags=gg.TYPE_DWORD},
			})
			end
			if CH[2] then table.append(t,{
				{a=0,value=9,flags=gg.TYPE_DWORD},
				{a=0x1C,value=6,flags=gg.TYPE_DWORD},
			})
			end
			for i=1,#t do
				t[i].address = (ta[1] + t[i].a)
				t[i+#t] = {
					address = (ta[2] + t[i].a),
					value = t[i].value,
					flags = t[i].flags
				}
			end
		--Put the changes that applies to both (1 value only) here
			if CH[3] then table.append(t,{
				{address=ta[3] + 0x10F4,value=0,freeze=true,flags=gg.TYPE_WORD},
				{address=ta[3] + 0x10F6,value=0,freeze=true,flags=gg.TYPE_WORD},
			})
			end
			gg.setValues(t)
			gg.addListItems(t)
			gg.clearResults()
			toast('Selected operations done')
		else
			toast(f"ErrNotFound_Report")
		end
	end
end
function MENU_godmode_bulk()
	local CH = gg.choice({
		"1. Fix broken vehicle",
		"2. Clear all player dupes (this will remove some duplicates, useful if you use ABJ4403 auto anchor method)",
	},nil,"God mode bulk, PS: some can be useful but some can harm other innocent players!")
	if CH then
		if CH == 1 then searchType = 'blownUp'
		elseif CH == 2 then searchType = 'player' end
		local achAdr,achAdrL = findEntityAnchr_custom(searchType)
		if achAdr then
			achAdrL = #achAdr
			toast('Preparing...')
			for i=1,achAdrL do
				if CH == 1 then
					table.append(t,{
						{address=achAdr[i]-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [EntityBurning]: Antiburn"},
						{address=achAdr[i]+0x8,flags=gg.TYPE_WORD,value=800,freeze=true,name="Pb2Chts [Health]"},
						{address=achAdr[i]+0xDB,flags=gg.TYPE_BYTE,value=4,name="Pb2Chts [CtrlCode]"},
					})
				elseif CH == 2 then
					table.append(t,{
						{address=achAdr[i]-0x4,flags=gg.TYPE_DWORD,value=99,name="Pb2Chts [EntityBurning]: Antiburn"},
						{address=achAdr[i]+0x8,flags=gg.TYPE_WORD,value=-501,name="Pb2Chts [Health]"},
						{address=achAdr[i]+0xDB,flags=gg.TYPE_BYTE,value=6,name="Pb2Chts [CtrlCode]"},
						{address=achAdr[i]+0x158,flags=gg.TYPE_WORD,value=1,name="Pb2Chts [RespawnInterval]"},
					})
				end
			end
			toast('Applied to '..achAdrL..' Entities!\nSelected operations done')
			gg.setValues(t)
			gg.addListItems(t)
			achAdr = nil
		else
			toast(f"ErrNotFound"..'. Try different entity anchor search method on settings, and disable memory optimization in config file.\nNothing worked? report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		end
	end
end
--[[
	Notes:
	- on version newer than 121 (specifically version 134), some offsets has been changed (specifically the Xa region), use Payback2_CHEATus.134.lua instead.
	- I recommend staying at build version 121 (32bit), because thats the point before the devs starts to wreak havoc...
	- 64bit isnt really supported especially because theres just too much "not found" and crap...
]]
function cheat_godmode(CH,anchor)
	t = {}
	-- 1. Groups: Essentials (Weapon Ammo,Rel0ad,Immortality,C4 Drawing,Antiburn,Dr0wned,Car jet,Fast car,Transparent car,Disable car noise)
	--- 2 ---
	if CH[3] or CH[1] then -- Weapon Ammo (Freeze/NoFreeze)
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
			tmp.a[i].address = (anchor + tmp.a[i].a)
			tmp.a[i].name = 'Pb2Chts [Weapon]: '..(tmp.a[i].n)
			tmp.a[i].flags = gg.TYPE_WORD
			tmp.a[i].value = 3e4
			tmp.a[i].a = nil
			tmp.a[i].n = nil
		end
		gg.setValues(tmp.a)
		tmp.a = nil
	end
	if CH[4] or CH[5] or CH[1] then -- Rel0ad (Pistol,SG,Rocket,C4/Grenade)
		tmp.a = {{address=anchor+0x84,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Rel0adTimer]"}}
		if CH[5] then
			local grenadeRange = gg.prompt({"Put your grenade range\nHold your grenade if you use this setting\nignore the throw range and disables delay by setting this to 0 [0;100]"},{1},{"number"})
			if grenadeRange and grenadeRange[1] and grenadeRange[1] ~= "0" then
				toast("Wait for it")
				tmp.a[1].value = grenadeRange[1]
				gg.setValues({{address=anchor+0x18,flags=gg.TYPE_WORD,value=3,name="Pb2Chts [HoldWeapon]: Grenade"}})
				gg.setValues(tmp.a)
				gg.addListItems(tmp.a)
				sleep(999)
			end
			tmp.a[1].value = -63
		end
		table.append(t,tmp.a)
	end
	-- [5]
	if CH[6] or CH[7] or CH[8] or CH[1] then -- (NoCarSteal/Immortality(On/Explode)) is this a good idea?
		tmp.isNoSteal = CH[6]
		tmp.isImmortal = CH[7] or CH[1]
		tmp.isDestroy = CH[8]
		table.append(t,{
			{address=anchor+0x8,flags=gg.TYPE_WORD,freeze=true,value=(tmp.isNoSteal and -501 or 800),name="Pb2Chts [Health]"},
			{address=anchor+0x158,flags=(tmp.isDestroy and gg.TYPE_WORD or gg.TYPE_FLOAT),freeze=true,value=((tmp.isImmortal or tmp.isDestroy) and 1 or 0),name="Pb2Chts [RespawnInterval]"},
		})
		tmp.isNoSteal,tmp.isImmortal,tmp.isDestroy = nil,nil,nil
	end
	-- [7]
	-- [8]
	if CH[9] or CH[1] then table.append(t,{ -- C4 Drawing
		{address=anchor+0x2C,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4PosX]"},
		{address=anchor+0x2E,flags=gg.TYPE_WORD,value=-1,freeze=true,name="Pb2Chts [C4PosY]"}
	})
	end
	if CH[10] then table.append(t,{ -- Speedslide
		{address=anchor+0x86,flags=gg.TYPE_WORD,value=300,freeze=true,name="Pb2Chts [SpeedSlide]"}
	})
	end
	if CH[11] then table.append(t,{ -- Float
		{address=anchor-0x408,flags=gg.TYPE_WORD,value=1,freeze=true,name="Pb2Chts [Float]"}
	})
	end
	if CH[12] then table.append(t,{ -- Ragdoll
		{address=anchor-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [Ragdoll]"},
		{address=anchor+0x128,flags=gg.TYPE_DWORD,value=0,freeze=true,freezeType=gg.FREEZE_IN_RANGE,freezeFrom=0,freezeTo=120,name="Pb2Chts [Ragdoll]"}
	})
	end
	if CH[13] or CH[7] or CH[1] then table.append(t,{ -- AntiBurn/NoSteal
		{address=anchor-0x4,flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [EntityBurn]: Antiburn"},
	})
	end
	if CH[14] then table.append(t,{ -- Burned body
		{address=anchor-0x4,flags=gg.TYPE_DWORD,value=1,freeze=true,name="Pb2Chts [EntityBurn]: Burned"},
	})
	end
	if CH[15] then table.append(t,{ -- Fire body
		{address=anchor-0x4,flags=gg.TYPE_DWORD,value=99,freeze=true,name="Pb2Chts [EntityBurn]: Fire"},
	})
	end
	if CH[16] or CH[1] then table.append(t,{ -- Dr0wned
		{address=anchor-0x60E,flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [Dr0wned]"},
	})
	end
	-- [17]
	-- [18]
	if CH[19] or CH[1] then table.append(t,{ -- Veichle jet
		{address=anchor-0x1AC,flags=gg.TYPE_WORD,value=1,freeze=true,name="Pb2Chts [Enable jet]"},
	})
	end
	if CH[20] or CH[1] then table.append(t,{ -- Car speed
		{address=anchor-0x210,flags=gg.TYPE_BYTE,value=3,freeze=true,name="Pb2Chts [CarAccelEngType]"},
		{address=anchor-0x208,flags=gg.TYPE_FLOAT,value=0,freeze=true,name="Pb2Chts [CarSpeed]"},
		{address=anchor-0x202,flags=gg.TYPE_WORD,value=31000,freeze=true,name="Pb2Chts [CarSpeed]"},
	--{address=anchor-0x214,flags=gg.TYPE_WORD,value=4,freeze=true,freezeType=gg.FREEZE_IN_RANGE,freezeFrom=4,freezeTo=6,name="Pb2Chts [WheelCount]"},
	--{address=anchor-0x20C,flags=gg.TYPE_FLOAT,value=1000,freeze=true,name="Pb2Chts [WheelGrip]"}, unused, it can give significant "controllable" fast speed, but comes at tons of minuses
	})
	end
	if CH[21] or CH[1] then table.append(t,{ -- Transparent vehicle
		{address=anchor-0x10,flags=gg.TYPE_WORD,value=1,name="Pb2Chts [TransparentVehicle]"},
	})
	end
	if CH[22] or CH[1] then table.append(t,{ -- Disable vehicle noise
		{address=anchor+0xDD,flags=gg.TYPE_BYTE,value=-1,freeze=true,name="Pb2Chts [Noise]: Disable"},
	})
	end
	-- [23]
	if CH[24] or CH[1] then table.append(t,{ -- Wanted level
		{address=anchor-0x11,flags=gg.TYPE_BYTE,value=127,name="Pb2Chts [Wanted level]"},
	})
	end
	if CH[25] then table.append(t,{ -- Win rampage
		{address=anchor+0x30,flags=gg.TYPE_DWORD,value=9e8,name="Pb2Chts [WinRampage] (remove after won match)"},
	})
	end
	if CH[26] then table.append(t,{ -- AI Control
		{address=anchor+0xDB,flags=gg.TYPE_BYTE,value=1,freeze=true,name="Pb2Chts [CtrlMode]"},
	})
	end
	if CH[27] then table.append(t,{ -- Wheel Suspension/Auto Unstuck
	--{address=anchor-0x72C,flags=gg.TYPE_WORD,value=16255,freeze=true,name="Pb2Chts [WheelSuspensionX]"},
		{address=anchor-0x72A,flags=gg.TYPE_WORD,value=16255,freeze=true,name="Pb2Chts [WheelSuspensionY]"},
	--{address=anchor-0x728,flags=gg.TYPE_WORD,value=16255,freeze=true,name="Pb2Chts [WheelSuspensionZ]"},
	})
	end
	--- stuff that requires user intervention and takes longer?
	if CH[23] then -- Custom wheel height
		local wheelHeight = gg.prompt({"Set your custom wheel height [0;200]"},{190},{"number"})
		if wheelHeight then
			wheelHeight = wheelHeight[1]
			table.append(t,{
				{address=anchor-0x3EB,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelFLZ]"},
				{address=anchor-0x3DF,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelFRZ]"},
				{address=anchor-0x3D3,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelBLZ]"},
				{address=anchor-0x3C7,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelBRZ]"},
				{address=anchor-0x3BB,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelMLZ]"},
				{address=anchor-0x3AF,flags=gg.TYPE_FLOAT,value=wheelHeight,name="Pb2Chts [CarWheelMRZ]"}
			})
		end
	end
	if CH[17] then -- Clone player
		toast("[ClonePlayer] Change the weapon you want before you can\'t change it anymore")
		tmp[1] = {
			{address=anchor+0xDB,flags=gg.TYPE_BYTE,value=7,freeze=true,name="Pb2Chts [ControlMode]"}
		}
		sleep(3e3)
		gg.setValues(tmp[1])
		tmp[1][1].value = 2
		table.append(t,tmp[1])
		sleep(1e3)
	end
	if CH[18] then -- Change vehicle color
		local CH = ({0,1,2,3,4,5,6,7,8,16,48,50,59,65,-1})[gg.choice({
			"1. Black (0)",
			"2. Blue (1)",
			"3. Green (2)",
			"4. Brown (3)",
			"5. Red (4)",
			"6. Gray (5)",
			"7. Yellow (6)",
			"8. White (7)",
			"9. Bold red (8)",
			"10. Exteme black (16)",
			"11. Rare green (48)",
			"12. Dark green (50)",
			"13. Dark red (59)",
			"14. Tomato red (65)",
			"15. Rainbow"
		},nil,"Select the color you want")]
		if CH then
			if CH >= 0 then
				table.append(t,{
					{address=anchor+0x94,flags=gg.TYPE_BYTE,freeze=true,value=CH,name="Pb2Chts [Vehicle color]"},
				})
			elseif CH == -1 then
				toast("Click GG icon to stop. you can't access GG while rainbow animation is playing")
				tmp.rnbwCurClr = 1
				tmp.rainbowCar = {{address=anchor+0x94,flags=gg.TYPE_BYTE,name="Pb2Chts [Vehicle color]"}}
				gg.setValues(t)
				gg.addListItems(t)
				gg.clearResults()
				gg.setVisible(false)
				while not gg.isVisible() do
					if tmp.rnbwCurClr > 8 then tmp.rnbwCurClr = 1 end
					tmp.rainbowCar[1].value = tmp.rnbwCurClr
					gg.setValues(tmp.rainbowCar)
					sleep(77)
					tmp.rnbwCurClr = tmp.rnbwCurClr + 1
				end
				gg.setVisible(false)
			end
		end
	end
	gg.setValues(t)
	gg.addListItems(t)
end
function cheat_pistolknockback()
	local CH = gg.choice({
		"Grapple gun/Pull (-20)",
		"Knockback/Push (20)",
		"Default (0.25)",
		"Off (0.00001)",
		"Custom",
		"——",
		"Change current knockback value",
		"Clear memory buffer",
		"__back__"
	},nil,"Pistol/Shotgun knockback modifier\nCurrent: "..curVal.PstlSgKnckbck.."\nHint: recommended value is -20 to 20 if you use pistol")
	if CH then
		if CH == 9 then return MENU()
		elseif CH == 1 then PISTOL_KNOCKBACK_VALUE = -20
		elseif CH == 2 then PISTOL_KNOCKBACK_VALUE = 20
		elseif CH == 3 then PISTOL_KNOCKBACK_VALUE = .25
		elseif CH == 4 then PISTOL_KNOCKBACK_VALUE = 1e-5
		elseif CH == 5 then
			local CH = gg.prompt({'Knockback value:'})
			if CH and CH[1] then
				PISTOL_KNOCKBACK_VALUE = CH[1]
			else
				return cheat_pistolknockback()
			end
		---
		elseif CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{curVal.PstlSgKnckbck},{'number'})
			if CH and CH[1] then
				curVal.PstlSgKnckbck = CH[1]
				memOzt.PistolKnockback = nil
			end
			return cheat_pistolknockback()
		elseif CH == 8 then
			memOzt.PistolKnockback = nil
			return cheat_pistolknockback()
		end
		if PISTOL_KNOCKBACK_VALUE then
		-- | gg.REGION_ANONYMOUS
			gg.setRanges(gg.REGION_C_ALLOC)
			if not memOzt.PistolKnockback then
			--basically searching ?F;1067869798D::13
				gg.searchNumber(1067869798,gg.TYPE_DWORD)
				tmp[1]=gg.getResults(5e3)
				for i=1,#tmp[1] do
					tmp[1][i].address = (tmp[1][i].address - 0xC)
					tmp[1][i].flags = gg.TYPE_FLOAT
				end
				gg.loadResults(tmp[1])
				gg.refineNumber(curVal.PstlSgKnckbck) -- BTW, MG value is ,5F!
			end
		--specially crafted for above conditions
			handleMemOzt("PistolKnockback",curVal.PstlSgKnckbck,nil,gg.TYPE_FLOAT,2)
			if gg.getResultCount() == 0 then
				memOzt.PistolKnockback = nil
				toast(f"ErrNotFound"..". if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
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
		"GKTV, ON",
		"GKTV, Entity only",
		"GKTV, OFF",
		"AGH, ON",
		"AGH, OFF",
		"——",
		"Help",
		"Clear memory buffer",
		"__back__"
	},nil,f"Cheat_WallHack"..". "..f"Cheat_WallHack_Notice"),nil
	if CH == 9 then MENU()
-- Set value that is going to be searched using logic after this `if CH elseif end`
	elseif CH == 1 then tmp={1,1e-3,-1,"ON"}
	elseif CH == 2 then tmp={1,1e-3,nil,"Entity only"}
	elseif CH == 3 then tmp={1,-1,1e-3,"OFF"}
	elseif CH == 4 then tmp={2,1140457472,-1,"ON"}
	elseif CH == 5 then tmp={2,-1,1140457472,"OFF"}
	---
	elseif CH == 7 then
		alert([[Wall hack allows you to pass through walls.
GKTV (known as Pumpkin Hacker) Wallhack is a recommended, it's Xa-based, fast to turn on/off.
You can optionally choose to only wallhack entities, makes entities can't push you.

AGH (AlphaGGHacker) method has better physics but is Ca-based,
needs to be applied every match and took longer than GKTV.

Xa = GG CodeApp memory region marked with purple color, small and fast.
Ca = GG C Alloc memory region marked with yellow color, quite big, takes couple seconds.]])
	elseif CH == 8 then
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
				gg.clearResults()
				gg.searchNumber("2W;16256W;"..tmp[2].."F;24W::9") -- entity wallhack
				gg.refineNumber(tmp[2],gg.TYPE_FLOAT)
				table.insert(tmp[6],gg.getResults(1)[1])
				memOzt.wallhack_gktv = tmp[6]
			end
			gg.loadResults(memOzt.wallhack_gktv)
			if #memOzt.wallhack_gktv == 0 then
				toast(f"ErrNotFound_Report")
			else
				if CH ~= 2 and #memOzt.wallhack_gktv == 1 then log("Only found 1 instead of 2 results.\n        Wallhack might partially or not working\n        try to play on build 121.") end
				if CH == 2 then -- wallhack gktv entity needs to be handled differently
					if memOzt.wallhack_gktv[1] then memOzt.wallhack_gktv[1].value = 1e-3 end -- wall
					if memOzt.wallhack_gktv[2] then memOzt.wallhack_gktv[2].value = -1   end -- entity
				else -- else, just do as regularly
					for i=1,#memOzt.wallhack_gktv do
						memOzt.wallhack_gktv[i].value = tmp[3]
					end
				end
				gg.setValues(memOzt.wallhack_gktv)
				toast("Wall Hack "..tmp[4])
			end
		else
			gg.setRanges(gg.REGION_C_ALLOC)
			if not memOzt.wallhack_agh then
			--Optimized group search of: 576F;tmp[2]D;576F::9
				gg.searchNumber(576,gg.TYPE_FLOAT)
				t=gg.getResults(1e3) for i=1,#t do t[i].address = (t[i].address + 0x8) end gg.loadResults(t) gg.refineNumber(576)
				t=gg.getResults(1e3) for i=1,#t do t[i].address = (t[i].address - 0x4) t[i].flags = gg.TYPE_DWORD end gg.loadResults(t) gg.refineNumber(tmp[2])
				t=nil
			end
			handleMemOzt("wallhack_agh",tmp[2],nil,gg.TYPE_DWORD,1e3)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound_Report")
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
		"Use custom value",
		"__back__"
	},nil,"Big body\nPS: client-side only")
	if CH then
		local t
		if CH == 4 then MENU()
		elseif CH == 1 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody",4.30000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound_Report")
			else
				gg.editAll(curVal.BigBody+.00000019073,gg.TYPE_FLOAT)
				toast("Big Body ON")
			end
		elseif CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigbody",curVal.BigBody+.00000019073,nil,gg.TYPE_FLOAT,22)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound_Report")
			else
				gg.editAll(4.30000019073,gg.TYPE_FLOAT)
				toast("Big body OFF")
			end
		elseif CH == 3 then
			CH = gg.prompt({'Put your custom value (Game default: 4.3,Cheatus default: 5.9, offset: .00000019073)'},{curVal.BigBody},{'number'})
			if CH and CH[1] ~= "" then curVal.BigBody = CH[1] end
			CH = nil
			cheat_bigbody()
		end
		t = nil
	end
end
function cheat_strongvehicle()
	local CH = gg.choice({
		"Strong (30000)",
		"Default (125)",
		"Fragile (1)",
		"Burnt (-1)",
		"Custom",
		"——",
		"Clear memory buffer",
		"__back__"
	},nil,"Vehicle default health modifier")
	if CH then
		if CH == 8 then MENU()
		elseif CH == 1 then CAR_HEALTH_VALUE = 3e4
		elseif CH == 2 then CAR_HEALTH_VALUE = 125
		elseif CH == 3 then CAR_HEALTH_VALUE = 1
		elseif CH == 4 then CAR_HEALTH_VALUE = -1
		elseif CH == 5 then
			local CH = gg.prompt({'Input your custom Vehicle default health value'})
			if CH and CH[1] then
				CAR_HEALTH_VALUE = CH[1]
			else
				return cheat_strongvehicle()
			end
		---
		elseif CH == 7 then
			CH,memOzt.CarHealth = nil,nil
			return cheat_strongvehicle()
		end
		if CAR_HEALTH_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
		--basically searching ?D;4D;1F::21
			if not memOzt.CarHealth then
				gg.searchNumber(1,gg.TYPE_FLOAT)
				tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x4) tmp[i].flags = gg.TYPE_DWORD end gg.loadResults(tmp) gg.refineNumber(4)
				tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x10) end gg.loadResults(tmp)
				memOzt.CarHealth = gg.getResults(99)
			end
			if not memOzt.CarHealth[1] then
				memOzt.CarHealth = nil
				toast(f"ErrNotFound")
			else
				for i=1,#memOzt.CarHealth do
					memOzt.CarHealth[i].flags = gg.TYPE_WORD
					memOzt.CarHealth[i].value = CAR_HEALTH_VALUE
				end
				curVal.CrDfltHlth = CAR_HEALTH_VALUE
				gg.setValues(memOzt.CarHealth)
				toast("Vehicles default health "..curVal.CrDfltHlth)
			end
		end
		CAR_HEALTH_VALUE = nil
	end
end
function cheat_noblastdamage()
	local CH = gg.choice({
		"None (0)",
		"Default (300)",
		"Far (3.000.000, dead with almost any explosed explosion)",
		"——",
		"Clear memory buffer",
		"__back__"
	},nil,"Blast damage intensity modifier")
	if CH then
		if CH == 6 then MENU()
		elseif CH == 1 then DAMAGE_INTENSITY_VALUE = 0
		elseif CH == 2 then DAMAGE_INTENSITY_VALUE = 300
		elseif CH == 3 then DAMAGE_INTENSITY_VALUE = 3e6
		---
		elseif CH == 5 then
			CH,memOzt.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		end
		if DAMAGE_INTENSITY_VALUE then
			gg.setRanges(gg.REGION_CODE_APP)
		--basically searching ?F;2e9F::5
			if not memOzt.NoBlastDamage then
				gg.searchNumber(2e9,gg.TYPE_FLOAT)
				tmp=gg.getResults(1)
				tmp[1].address = tmp[1].address - 0x4
				gg.loadResults(tmp)
				memOzt.NoBlastDamage = gg.getResults(1)
			end
			if not memOzt.NoBlastDamage[1] then
				memOzt.NoBlastDamage = nil
				toast(f"ErrNotFound")
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
		"Activate (Clear buffer)",
		"Activate v2 (edit-all values)",
		"Clear memory buffer",
		"Back"
	},nil,"Floodspawn")
	if CH then
		if CH == 5 then MENU() end -- go back
		if CH == 2 or CH == 4 then -- clear buffer
			memOzt.floodspawn = nil
			if CH == 4 then cheat_floodspawn() end -- reopen menu
		end
		if CH == 1 or CH == 2 or CH == 3 then -- begin search
			gg.setRanges(cfg.memRange.general)

		--Begin search respawn anchors and store its result in t var
			if CH == 1 or CH == 2 then -- one entity
				toast("Please wait... after the search is done, you should get automatically respawned")
				tmp[1] = handleMemOzt("matchBackendAnchor",359697,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther) -- used for auto-respawn. matchBackendAnchor is temporary name and accelerate search
				tmp[1] = (tmp[1][1]) and tmp[1][1].address or nil -- grab address
				gg.clearResults()
				t = handleMemOzt("floodspawn",52428800,nil,gg.TYPE_DWORD,5e3,cfg.memZones.Common_RegionOther)
			else -- bulk
				gg.clearResults()
				gg.searchNumber(52428800,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
				t = gg.getResults(5e3)
			end

		--if found more than 1 and targets 1 player
			if #t > 1 and (CH == 1 or CH == 2) then
			--Auto-respawn
				if tmp[1] then
					gg.setValues({{
						address=tmp[1] - 0x41,
						value=1,
						flags=gg.TYPE_BYTE,
					--name="[Pb2Chts] Respawn"
					}})
					tmp[2] = "Trying to find your entity ID... If you dont get respawned, respawn from pause menu"
				else
					tmp[2] = "Unable to automatically respawn, you need to respawn from pause menu"
				end

			--and find the respawn anchor
				searchWatchdog(tmp[2],"52428801~52429000","floodspawn")
				msg = nil -- remove tmp var
			end

		--if found
			if gg.getResultCount() > 0 then
				CH = gg.prompt({
					"RC Car Spam","Increase score (client-side, wins Brawl&Kingpin)",
					"Swag Delivery no timer","Lock entity ID (prevents player takeover)",
					"Disable AI & respawn","Win Race/Sprint/Knockout",
					"Respawn duration (in seconds)\n0:No duration\n-1:Floodspawn off\n\nWARNING:\n- DONT USE THIS TO HARM OTHER PLAYERS!\n- THIS CHEAT IS TECHINCALLY POWERFUL, BECAUSE IT INCREASE HOST LATENCY AND LAG PLAYERS. ONLY USE IT OFFLINE!!\n- if you use this for race, consider lowering your freeze range to ~40.000 if after reaching checkpoint wont move to next checkpoint. [-1;20]",
				},{
					true,false,
					false,false,
					false,true,
					-1,
				},{
					"checkbox","checkbox",
					"checkbox","checkbox",
					"checkbox","checkbox",
					"number",
				})
				if CH then
				--2nd table that dont affected by timer and crap
					local ta = {}
				--prepare respawn/rccarspam/winbrawl values
					for i=1,#t do
						t[i].value = 52428801
						t[i].freeze = true
						t[i].name = "Pb2Chts [RespawnTimer]"
						if CH[2] then table.append(ta,{ -- win brawl
							{
								address = t[i].address - 0x14,
								flags = gg.TYPE_DWORD,
								value = 9e6,
								freeze = true,
								name = "Pb2Chts [MatchScore]"
							},
							{
								address = t[i].address - 0x8,
								flags = gg.TYPE_DWORD,
								value = 9e6,
								freeze = true,
								name = "Pb2Chts [MatchKilled]"
							},
							{
								address = t[i].address - 0x4,
								flags = gg.TYPE_DWORD,
								value = 0,
								freeze = true,
								name = "Pb2Chts [MatchDied]"
							},
						})
						end
						if CH[3] then table.append(ta,{ -- swag deliver 0 timer
							{
								address = t[i].address + 0xE,
								flags = gg.TYPE_WORD,
								value = 0,
								freeze = true,
								name = "Pb2Chts [SwagDeliverTim0r]"
							}
						})
						end
						if CH[5] then table.append(ta,{ -- disable AI + respawn
							{
								address = t[i].address - 0x20,
								flags = gg.TYPE_BYTE,
								value = 0,
								name = "Pb2Chts [EnableAICtrl+Respawn]"
							}
						})
						end
						if CH[6] then table.append(ta,{ -- win race (client-side, 11 = DEFINITELY win), if you read this code, let me tell a secret: this shit below WORKS ONLINE !!!! WTF?!?! (2p only if the host uses older version though, i tried some didnt work)
							{
								address = t[i].address - 0x34,
								flags = gg.TYPE_BYTE,
								value = 11, -- u can use 99 cuz knockout lap, but 2P races wont win 1st
								freeze = true,
								name = "Pb2Chts [RaceCurrentLap]"
							}
						})
						end
					end
				--rc spam
					if CH[1] then
						table.append(ta,{{
							address = t[1].address - 0xE,
							flags = gg.TYPE_WORD,
							value = -1,
							freeze = true,
							name = "Pb2Chts [RCCarSpam]"
						}})
					end
				--lock entity id (only if floodspawn not used, using both WILL CRASH the game due to buffer-overflow)
					if CH[4] and CH[7] == "-1" then
					--fetch current entity id
						gg.loadResults({{address=t[1].address - 0x10,flags=gg.TYPE_WORD}})
					--and apply
						table.append(ta,{{
							address = t[1].address - 0x10,
							flags = gg.TYPE_WORD,
							value = gg.getResults(1)[1].value,
							freeze = true,
							name = "Pb2Chts [EntityCamID]"
						}})
						gg.clearResults() -- get rid of temporary trash after used
					end

				--since the only thing required in CH is only the 1st option, change the whole table to that instead
					CH = CH[7]
				--set other stuff if user ticked those options
					if ta[1] then
						gg.setValues(ta)
						gg.addListItems(ta)
					end
				--set respawn hack if not disabled (not -1)
					if CH ~= "-1" then
					--set respawn hack
						gg.setValues(t)
						gg.addListItems(t)
					end
				--if no duration
					if CH == "0" then
						toast("Flood Respawn ON\nRemember to turn off again by using \"Clear list items\" button in settings")
				--if not disabled
					elseif CH ~= "-1" then
						toast("Flood Respawn ON for "..CH.." seconds, click the gg icon to disable")
					--Way to sleep for a long time but cancellable by user too, which is great
						for i=1,CH do
							if gg.isVisible()then
								gg.setVisible(false)break
							end
							sleep(1e3)
						end
					--restore the value back by removing list items ??? (heres the problem, what if it stays freezed even if removed from list?)
						gg.removeListItems(t)
						toast("Flood Respawn OFF")
					end
				end
			else
				toast(f"ErrNotFound_Report")
			end
		end
	end
	CH = nil
end
function cheat_c4autorigg()
	anchors = findEntityAnchr_custom('blowables')
	if anchors then
		t = {}
		for i=1,#anchors do table.append(t,{
			{address=anchors[i]+0x8,flags=gg.TYPE_WORD,value=0},
		--{address=anchors[i]+0x158,flags=gg.TYPE_WORD,value=1}
		})
		end
		gg.setValues(t)
		gg.toast(#anchors.." C4s rigged!")
	else
		gg.toast("Can't find any C4s...")
	end
end
function cheat_runspeedmod()
	CH = gg.choice({
		[15120]="120 (Default)",
		[15400]="400",
		[33001]="——",
		[33002]="Clear memory buffer",
		[33003]="Back"
	},nil,"Running speed modifier")
	if CH == 33003 then MENU()
	elseif CH == 33002 then
		CH,memOzt.runSpeed = nil,nil
		cheat_runspeedmod()
	elseif CH ~= 33001 then
		gg.setRanges(gg.REGION_CODE_APP)
	--basically searching ?W;24000F;985158124D;17008W
		if not memOzt.runSpeed then
			gg.searchNumber(985158124,gg.TYPE_DWORD)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x4) tmp[i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp) gg.refineNumber(24000)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xA) tmp[i].flags = gg.TYPE_WORD end gg.loadResults(tmp) gg.refineNumber(17008)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC) end gg.loadResults(tmp)
			memOzt.runSpeed = gg.getResults(1)
		end
		if memOzt.runSpeed[1] then
			for i=1,#memOzt.runSpeed do
				memOzt.runSpeed[i].flags = gg.TYPE_WORD
				memOzt.runSpeed[i].value = CH
			end
			gg.setValues(memOzt.runSpeed)
			gg.toast("Running speed "..CH)
		else
			gg.toast(f"ErrNotFound")
		end
	end
end
function cheat_mtcScrnfx()
--Not ready to use gg.REGION_C_BSS yet especially because JokerGGS mentioned a problem with it.
	gg.setRanges(cfg.memRange.general)
	local CH = gg.prompt(
	{
		'Modify XP to (max 999999)',
		'Modify coin to (max 30000, temporary, not recommend if you have infinite coin coz it might get reset)',
		'Freeze XP',
		'Freeze Coin',
		'Skip match intro',
		'Override current controlled player [-1;16]',
		'Win team match (CTS, Gang Warfare, Conquest. A/Off/B) [-1;1]',
		'Increase 2P Win count',
		'Disable (some) screen effects (Shake,Red screen,Grain)',
		'Disable timers and increase kills/score',
		'Fix blank screen when slammed into void',
	},
	{999999,-1,true,false,false,-1,0,false,false,false,false},
	{'number','number','checkbox','checkbox','checkbox','number','number','checkbox','checkbox','checkbox','checkbox'}
	)
	if CH then
		handleMemOzt("xpAnchor",1014817001,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther,"Please wait, searching... (1/2)")
		gg.clearResults()
		handleMemOzt("matchBackendAnchor",359697,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther,"Please wait, searching... (2/2)") -- used for auto-respawn. matchBackendAnchor is temporary name and accelerate search
		if memOzt.xpAnchor or memOzt.matchBackendAnchor then
			t = {}
			tmp[1] = memOzt.xpAnchor[1].address
			tmp[2] = memOzt.matchBackendAnchor[1].address
			if CH[1] and CH[1] ~= "" and CH[1] ~= "-2" then
				table.append(t,{{address=(tmp[1]-0x804),flags=gg.TYPE_DWORD,value=CH[1],freeze=CH[3],name="Pb2Chts [CurrentXP]"}})
			end
			if CH[2] and CH[2] ~= "" and CH[2] ~= "-1" then
				if cfg.memRange.general == gg.REGION_C_BSS then toast("[!] There is a known bug where the game will crash for C-BSS Users, if the game does crash, do not issue any bug report, we're working on it!")gg.sleep(3e3) end
				table.append(t,{{address=(tmp[1]-0x608),flags=gg.TYPE_DWORD,value=CH[2],freeze=CH[4],name="Pb2Chts [CurrentCoin]"}})
			end
		--[3] Freeze XP
		--[4] Freeze Coin
			if CH[5] then -- skip intro
				table.append(t,{{address=(tmp[2]-0xC),flags=gg.TYPE_WORD,value=0,freeze=true,name="Pb2Chts [SkipSlowAnimation]"}})
			end
			if CH[6] and CH[6] ~= "-1" then -- override player
				table.append(t,{{address=(tmp[2]+0x18),flags=gg.TYPE_WORD,value=CH[6],name="Pb2Chts [OverridePlayer]"}})
			end
			if CH[7] then -- win team match
				if CH[7] == "-1" then -- 1
					table.append(t,{{address=(tmp[2]+0x140),flags=gg.TYPE_WORD,value=999,freeze=true,name="Pb2Chts [TeamScoreA]"}})
				elseif CH[7] == "1" then -- 2
					table.append(t,{{address=(tmp[2]+0x13C),flags=gg.TYPE_WORD,value=999,freeze=true,name="Pb2Chts [TeamScoreB]"}})
				end
			end
			if CH[8] then -- 2p win count
				table.append(t,{{address=(tmp[2]-0x18),flags=gg.TYPE_WORD,value=99,freeze=true,name="Pb2Chts [2PWinCount]"}})
			end
			if CH[9] then -- disable scrn fx
				table.append(t,{
					{address=(tmp[2]+0x54),flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [Camshake]: Supress"},
					{address=(tmp[2]+0x88),flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [MatchFinishGrainFX]: Disable"},
					{address=(tmp[2]+0xA8),flags=gg.TYPE_DWORD,value=0,freeze=true,name="Pb2Chts [Redfilter]: Disable"}
				})
			end
			if CH[10] then -- disable timer & increase score
				table.append(t,{
					{address=(tmp[2]-0x8),flags=gg.TYPE_DWORD,value=9e7,freeze=true,name="Pb2Chts [MatchDistance]"},
					{address=(tmp[2]+0x38),flags=gg.TYPE_DWORD,value=-1,freeze=true,name="Pb2Chts [MatchTimeout]"},
					{address=(tmp[2]+0x3C),flags=gg.TYPE_FLOAT,value=2.8250177e-43,freeze=true,name="Pb2Chts [MatchTimer]"}
				})
			end
			if CH[11] then -- prevent blank screen
				table.append(t,{{address=(tmp[2]+0xF3),flags=gg.TYPE_BYTE,value=0,freeze=true,name="Pb2Chts [isScrnBlank]: No"}})
			end
			gg.setValues(t)
			gg.addListItems(t)
			toast('Selected operations done')
		else
			toast(f"ErrNotFound")
		end
	end
end
function cheat_changeplayername()
--request user to give player name
	local CH = gg.prompt({
		'Put your current player name (case-sensitive, ":" or ";" is required at the beginning, because how GameGuardian search works)',
		'Put new player name (cant be longer than current name, you can change color/add icon by copy-pasting custom name edited using hex-editor (use hex 1-9 for color))',
		'Method (TODO):\n1:Change all (slow, but changes name in match too)\n2:Fast (but name wont be changed in match)\n3:2P Match (Changes your name on multiplayer match) [1;3]',
	},{
		curVal.PlayerCurrentName,
		cfg.PlayerCustomName,
		1,
	},{
		"text",
		"text",
		"number",
	})
--search old player name
	if CH and CH[1] and CH[1] ~= ":" then
		CH[3] = tonumber(CH[3])
		if CH[3] == 1 then
			gg.setRanges(gg.REGION_C_ALLOC | cfg.memRange.general)
			gg.searchNumber(CH[1],gg.TYPE_BYTE)
		elseif CH[3] == 2 then
			gg.setRanges(cfg.memRange.general)
			gg.searchNumber(CH[1],gg.TYPE_BYTE,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
		end
		if gg.getResultCount() == 0 then
			toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
			gg.getResults(gg.getResultCount()) -- must be called first before calling editAll
			gg.editAll(CH[2],gg.TYPE_BYTE)
			curVal.PlayerCurrentName = CH[2]
			toast(f('"%s" changed to "%s"\nWarn: this is still in testing, it might only applied to your client and not others',CH[1],CH[2]))
		end
	end
end
function cheat_changeplayernamecolor()
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
	local CH,player_name,player_color_choice = gg.choice({
		"Invisible name (all values 1 byte, Experimental)",
		"Red (2)",
		"Blue (3)",
		"White (4)",
		"Yellow (5,9)",
		"Green (6h)",
		"Coin (7h)",
		"Player (8h)",
		"Corrupted (10h)",
		"——",
		"Remove all color/icon",
		"__back__"
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
			if gg.getResultCount() == 0 then
				toast('Can\'t find the player name, this cheat is still in experimentation phase')
			else
			--if the chioce is 0, remove color/icons
				if player_color_choice == 0 then
					for i=1,#t do -- loop over player name result
					--if it within the custom color/icon range
						if t[i].value >= 0 and t[i].value < 11 then
						--remove it, and increment the removeOffset
							t[i] = nil
							removeOffset = removeOffset + 1
						else
						--else, shift address
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
		"__back__"
	},nil,"Walk Wonkyness (fancy-cheat)")
	gg.setRanges(gg.REGION_CODE_APP) -- PS: 0.00999999978 > 0.3 for new version
	if CH == 3 then MENU()
	elseif CH == 1 then
		handleMemOzt("walkwonkyness",".004~1;.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(.004,gg.TYPE_FLOAT)
		toast("Walk Wonkyness Default")
	elseif CH == 2 then
		handleMemOzt("walkwonkyness",".004;.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(1.004,gg.TYPE_FLOAT)
		toast("Walk Wonkyness ON")
	elseif CH == 3 then
		handleMemOzt("walkwonkyness","1.004;.00999999978::5",nil,gg.TYPE_FLOAT,1)
		gg.editAll(0,gg.TYPE_FLOAT)
		toast("Walk Wonkyness OFF")
	end
end
function cheat_coloredtree()
	local CH = gg.choice({
		"ON",
		"OFF",
		"__back__"
	},nil,"Colored trees\nThis will change some shader stuff (actually idk wut this does lol) that affects trees")
	if CH == 3 then MENU()
	elseif CH then
		if CH == 1 then tmp={.04,-999,"ON"}
		elseif CH == 2 then tmp={-999,.04,"OFF"} end
		if tmp then
			gg.setRanges(gg.REGION_CODE_APP)
			local t = handleMemOzt("clrdtree","4.06176449e-39;.06;"..tmp[1]..";-.04;-.02::17",tmp[1],gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound_Report")
			else
				gg.editAll(tmp[2],gg.TYPE_FLOAT)
				toast("Colored trees "..tmp[3])
			end
		end
	end
end
function cheat_bigflamethroweritem()
	local CH = gg.choice({
		"ON",
		"OFF",
		"__back__"
	},nil,"Big flamethrower (Item)\nPS: this will not make the flame burst bigger")
	if CH == 3 then MENU()
	elseif CH then
		if CH == 1 then tmp={.9,5.1403,"ON"}
		elseif CH == 2 then tmp={5.1403,.9,"OFF"} end
		if tmp then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("bigflmthrwritm",".4;.2;"..tmp[1]..";24e3::13",tmp[1],gg.TYPE_FLOAT,9)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound")
			else
				gg.editAll(tmp[2],gg.TYPE_FLOAT)
				toast("Big flamethrower "..tmp[3])
			end
		end
	end
end
function cheat_autoshootrocket()
	local CH,r,t = gg.choice({
		"ON",
		"ON (Only if holding rocket, use MG, better to use with Rel0ad)",
		"Rel0ad v2 Rocket",
		"Rel0ad v2 Rocket,Pistol,SG (causes problem with Grenade,Knife,C4)",
		"OFF",
		"__back__"
	},nil,"Autoshoot rocket. PS: This will affect everyone not just the players")
	if CH == 6 then MENU()
	elseif CH then
	--{all,rocket,state title}
	--about those numbers:
	--all|rocket
	--74?:crash
	--754|752:default
	--750:no reload
	--755:c4 spam
	--758:turret spam
	--760+:crash
		if CH == 1 then tmp={0,0,"ON"}
		elseif CH == 2 then tmp={754,0,"ON"}
		elseif CH == 3 then tmp={754,750,"Rel0ad v2 rocket only"}
		elseif CH == 4 then tmp={750,750,"Rel0ad v2"}
		elseif CH == 5 then tmp={754,752,"OFF"} end
		if tmp then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber(5000,gg.TYPE_FLOAT)
			t = gg.getResults(1)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound")
			else
				t = t[1].address
				r = {
					{address=t+0x80,flags=gg.TYPE_WORD,value=tmp[1]},
					{address=t+0x88,flags=gg.TYPE_WORD,value=tmp[2]}
				}
				gg.setValues(r)
				gg.addListItems(r) -- Debugging
				toast("Autoshoot rocket "..tmp[3])
			end
			r = nil
		end
	end
end
function cheat_shadowfx()
	local CH = gg.choice({
		"OFF",
		"ON",
		"__back__"
	},nil,"Shadow effects\nInfo: this wont affect your game performance at all (not making it lag/fast)\ndont use this for performance purpose :)")
	if CH == 3 then MENU()
	elseif CH then
		if CH == 1 then tmp={1e-4,-1.0012,"Disabled"}
		elseif CH == 2 then tmp={-1.0012,1e-4,"Enabled"} end
		if tmp then
			gg.setRanges(gg.REGION_CODE_APP)
			handleMemOzt("shadow",tmp[1]..";-5.96152076e27;-2.55751098e30;-1.11590087e28;-5.59128595e24:17",tmp[1],gg.TYPE_FLOAT,1)
			if gg.getResultCount() == 0 then
				toast(f"ErrNotFound_Report")
			else
				gg.editAll(tmp[2],gg.TYPE_FLOAT)
				toast("Shadow "..tmp[3])
			end
		end
	end
end
function cheat_plyxray()
	local CH,tmp = gg.choice({
		"ON",
		"OFF",
		"__back__"
	},nil,"Player X-Ray\nPS: Doesn't work on latest version"),nil
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={.08,436,"ON"}
	elseif CH == 2 then tmp={436,.08,"OFF"} end
	if tmp then
		gg.setRanges(gg.REGION_CODE_APP)
		handleMemOzt("clrdpplsp",tmp[1],nil,gg.TYPE_FLOAT,9)
		if gg.getResultCount() == 0 then
			toast(f"ErrNotFound")
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
	toast("Gameplay texts cleared! to restore, restart the game\nPS: This might not work, idk why though..")
end
function cheat_reflectivetexture()
	local CH = gg.choice({
		"ON",
		"OFF",
		"__back__"
	},nil,"Reflective texture\nWARNING: this can cause rendering issue that requires restart to fix it\nDont forget to disable this before you get in/out-of match\ni only recommend using this in offline mode so you can easily disable the reflective texture before getting out of match")
	if CH == 3 then MENU()
	elseif CH == 1 then tmp={49,1,"ON"}
	elseif CH == 2 then tmp={1,49,"OFF"} end
	if CH and tmp[3] then
		gg.setRanges(gg.REGION_OTHER)
		if not memOzt.RfTtex then
		--basically searching 144D;49D;50D::9
			gg.searchNumber(144,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- Note: this was 112B (112W) when in menu, and -112B (144W) in game
			tmp[4]=gg.getResults(5e3) for i=1,#tmp[4] do tmp[4][i].address = (tmp[4][i].address + 0x8) end gg.loadResults(tmp[4]) gg.refineNumber(50)
			tmp[4]=gg.getResults(5e3) for i=1,#tmp[4] do tmp[4][i].address = (tmp[4][i].address - 0x4) end gg.loadResults(tmp[4]) gg.refineNumber(tmp[1])
		end
	--specially coded for condition above
		handleMemOzt("RfTtex",tmp[1],nil,gg.TYPE_DWORD,1)
		if gg.getResultCount() == 0 then
			toast(f"ErrNotFound_Report")
		else
			memOzt.RfTtex[1].value = tmp[2]
			toast("Reflective Texture "..tmp[3])
			gg.setValues(memOzt.RfTtex)
		end
	end
	t = nil
end
function cheat_explodepow()
	local CH = gg.choice({
		"Modify Explosion power",
		"Clear memory buffer",
		"__back__"
	},nil,"Explosion power modifier\nCurrent: "..curVal.XplodPow.."\n")
	if CH then
		if CH == 3 then MENU()
		elseif CH == 1 then
			local CH = gg.prompt({'Put your explosion power. Lower is more powerful\nSet to -1 to disable explosion\n PS:only applies to you'},{curVal.XplodPow},{'number'})
			if CH and CH[1] then
				EXPLOSION_POWER = CH[1]
			else
				cheat_explodepow()
			end
		elseif CH == 2 then
			memOzt.explodePower = nil
			cheat_explodepow()
		end
		if EXPLOSION_POWER then
			gg.setRanges(gg.REGION_CODE_APP)
		--basically searching 990904320D;?F;1051260355D::13
			if not memOzt.explodePower then
				gg.searchNumber(1051260355,gg.TYPE_DWORD)
				tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC) end gg.loadResults(tmp) gg.refineNumber(990904320)
				tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0x4) tmp[i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp)
				memOzt.explodePower = gg.getResults(1)
			end
			if not memOzt.explodePower[1] then
				memOzt.explodePower = nil
				toast(f"ErrNotFound")
			else
				memOzt.explodePower[1].value,curVal.XplodPow = EXPLOSION_POWER,EXPLOSION_POWER
				toast("Explosion power modified to "..EXPLOSION_POWER)
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
		"Clear memory buffer",
		"__back__"
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
		CH,memOzt.explodeDir = nil,nil
		cheat_explodedir()
	end
	if XPLODIR_VAL then
		gg.setRanges(gg.REGION_CODE_APP)
	--basically searching 990904320D;?F;1051260355D::13
		if not memOzt.explodeDir then
			gg.searchNumber(1051260355,gg.TYPE_DWORD)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC) end gg.loadResults(tmp) gg.refineNumber(990904320)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0x8) tmp[i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp)
			memOzt.explodeDir = gg.getResults(1)
		end
		if not memOzt.explodeDir[1] then
			memOzt.explodeDir = nil
			toast(f"ErrNotFound")
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
		"Clear memory buffer",
		"__back__"
	},nil,"Particle interval modifier\nCurrent: "..curVal.PrtclAnmtnIntrvl)
	if CH == 9 then MENU()
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
	elseif CH == 8 then memOzt.PrtclAnmtnIntrvl = nil cheat_prtclintrvl()
	end
	if PARTICLE_INT then
		gg.setRanges(gg.REGION_CODE_APP)
	--basically searching -5377W;?F;4.3F::7
		if not memOzt.PrtclAnmtnIntrvl then
			gg.searchNumber(-5377,gg.TYPE_WORD)
			tmp=gg.getResults(9e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0x6) tmp[i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp) gg.refineNumber(4.3)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x4) end gg.loadResults(tmp)
			memOzt.PrtclAnmtnIntrvl = gg.getResults(1)
		end
		if not memOzt.PrtclAnmtnIntrvl[1] then
			memOzt.PrtclAnmtnIntrvl = nil
			toast(f"ErrNotFound")
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
		"Clear memory buffer",
		"__back__"
	},nil,"Drifting speed modifier\nCurrent: "..curVal.DrftSpd.."\n")
	if CH == 3 then MENU()
	elseif CH == 1 then
		local CH = gg.prompt({'How fast you want the drifting rotation? Higher value is more powerful\nDefault:1 (1.3) [1;20]'},{curVal.DrftSpd},{'number'})
		if CH and CH[1] then
			DRIFT_SPEED = CH[1]..".3"
		else
			cheat_cardrift()
		end
	elseif CH == 2 then
		memOzt.DrftSpd = nil
		cheat_cardrift()
	end
	if DRIFT_SPEED then
		gg.setRanges(gg.REGION_CODE_APP)
	--basically searching 120F;?F;712W::9
		if not memOzt.DrftSpd then
			gg.searchNumber(-712,gg.TYPE_WORD)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x8) tmp[i].flags = gg.TYPE_FLOAT end gg.loadResults(tmp) gg.refineNumber(120)
			tmp=gg.getResults(99)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0x4) end gg.loadResults(tmp)
			memOzt.DrftSpd = gg.getResults(1)
		end
		if not memOzt.DrftSpd[1] then
			memOzt.DrftSpd = nil
			toast(f"ErrNotFound_Report")
		else
			memOzt.DrftSpd[1].value,curVal.DrftSpd = DRIFT_SPEED,DRIFT_SPEED
			gg.setValues(memOzt.DrftSpd)
			toast("Car drifting roration modified to "..curVal.DrftSpd)
		end
	end
	DRIFT_SPEED = nil
end
function show_about()
	local CH = gg.choice({
		"__about__",
		f"Disclaimer",
		f"License",
		f"Credits",
		"__back__"
	},nil,f"Title_Version")
	if CH == 1 then alert(f"About_Text") show_about()
	elseif CH == 2 then alert(f"Disclaimer_Text") show_about()
	elseif CH == 3 then alert(f"License_Text") show_about()
	elseif CH == 4 then alert(f"Credits_Text") show_about()
	elseif CH == 5 then MENU() end
end
--————————————————————————————————--



--— Helper functions —————————————--
--- Its here to make stuff easier & faster
function table.tostring(t,dp)
	local r,tv = '{\n'
	dp = dp or 0
	for k,v in pairs(t) do
		r = r..('\t'):rep(dp+1)
		tv = type(v)
		if type(k) == 'string' then
			r = r..k..' = '
		end
		if tv == 'table' then
			r = r..table.tostring(v,dp+1)
		elseif tv == 'number' and #tostring(v) > 7 then
			r = r..'0x'..("%x"):format(v):gsub("%l",string.upper)
		elseif tv == 'boolean' or tv == 'number' then
			r = r..tostring(v)
		else
			r = r..'"'..v..'"'
		end
		r = r..',\n'
	end
	return r..('\t'):rep(dp)..'}'
end
function table.merge(...)
	local r = {}
	for _,t in ipairs{...} do
		for k,v in pairs(t) do
			r[k] = type(r[k]) == "table" and table.merge(r[k],v) or v
		end
	end
	return r
end
function table.copy(t)
	local t2={}
	for k,v in pairs(t)do
		t2[k] = type(v) == "table" and table.copy(v)or v
	end
	return t2
end
function table.append(t1,t2)
	for i=1,#t2 do
		t1[#t1+1]=t2[i]
	end
end
function searchWatchdog(msg,refineVal,mmBfr)
	local prvVl = gg.getResults(100)
	if #prvVl < 2 then return prvVl
	elseif msg then toast(msg.."\nClick GG Icon to abort the search") end
	repeat
		gg.loadResults(prvVl)
		sleep(100)
		gg.refineNumber(refineVal)
	until gg.isVisible() or gg.getResultCount() > 0
	gg.setVisible(false)
	t = gg.getResults(1)
	memOzt[mmBfr] = t
	return t
end
function handleMemOzt(memOztName,val,valRefine,valTypes,dsrdRslts,memZones,msg)
--[[
	This function handles memory buffer related stuff by saving previous
	result and return that instead the next time the same search is requested.
	This optimization can only apply if the values not always changing.
	Best for memory region that is huge and taking long time to search.
]]
--default configs
	memZones = memZones or {0,-1}
	dsrdRslts = dsrdRslts or 1
	msg = msg and msg.."\n" or ""
--if buffer is found
	if memOzt[memOztName] then
	--load previous result
		toast(msg..'Previous result found, using previous result')
		gg.loadResults(memOzt[memOztName])
	else
	--or search new ones
		toast(msg..'No buffer found, creating new buffer')
		gg.searchNumber(val,valTypes,nil,nil,table.unpack(memZones))
	--optionally refine if valRefine is defined
		if valRefine then
			gg.refineNumber(valRefine,valTypes)
		end
		if gg.getResultCount() > 0 then
			memOzt[memOztName] = gg.getResults(dsrdRslts)
		end
	end
	return gg.getResults(dsrdRslts)
end
function optimizeRange(range)
--[[
	This optimizes used memory range automatically without using the config thing
	This can work on every phone/enviroment/architecture (need testing)
]]
	local t = {
		table.unpack(gg.getRangesList('/data/app/'..gg.getTargetPackage..'-*/base.apk')),
		table.unpack(gg.getRangesList('/data/app/'..gg.getTargetPackage..'-*/split_config.*.apk'))
	}
	local result = {
		range[2],
		range[1]
	}
	range[3] = range[2] - range[1] -- calculate the range difference (save it to index 3, later index 3 is removed and table returned)
	for i=1,#t do -- loop over all gg.getRangesList result tables
	--If:
	--the start is below minimum range
	--or the end if above maximum range
	--or range is more than the stated requirement
	--or not Other/CodeApp region
		if t[i].start < range[1] or
			 t[i]['end'] > range[2] or
			 (t[i]['end'] - t[i].start) > range[3] or
			 not (t[i].state == "O" or t[i].state == "Xa") then
		--Remove it
			t[i] = nil
		else
		--else, calculate the result...
			result[1] = math.min(result[1],t[i].start)
			result[2] = math.max(result[2],t[i]['end'])
		end
	end
	table.remove(range,3)
	return next(t) and result or range -- if there {}?? on the table, return the previously given input, else return the result.
end
function findEntityAnchr()
	gg.setRanges(cfg.memRange.general)
	local tmp,tmp0
	if cfg.entityAnchrSearchMethod == 2 then
		toast(f"eAchA_wait")
	--this huge packs of "battery" below is basically searching "120W;20W;-501~30000W;13W;2B::??" in accurately optimized way
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 random anchor
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) end gg.loadResults(tmp) gg.refineNumber(120)                                       -- 2/6 shooting state (warn: value sometimes altered a bit? i rarely checked it and it sometimes shows 122 instead)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) tmp[i].flags = gg.TYPE_BYTE  end gg.loadResults(tmp) gg.refineNumber(2)            -- 3/6 (ControlCode 2B)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC7) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) gg.refineNumber(55834574848)  -- 4/6 (HoldWeapon 0;0;13;0::W)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC)  tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber('-501~30000') -- 5/6 (Health -501~30000W(because carhealth&nostealcar cheat))
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address)
			if tmp0:find('508$') or
				 tmp0:find('d08$') or
				 tmp0:find('5f4$') or
				 tmp0:find('df4$') then
				tmp[i].address = (tmp[i].address - 0x8)
			else
				tmp[i] = nil
			end
		end
		gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
		tmp0 = #tmp
		if tmp0 > 0 then
			if tmp0 > 1 then
				toast(f("eAchA_dupe",tmp0))
				for i=1,tmp0 do tmp[i].address = (tmp[i].address + 0x14) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) sleep(1500) gg.refineNumber(0) -- refine pistol
				tmp=gg.getResults(1)
				tmp0=tmp[1]and tmp[1].address-0x14 or nil -- back to anchor
			else
				tmp0=tmp[1].address
			end
			tmp=nil
			gg.clearResults()
			return {tmp0}
		end
	elseif cfg.entityAnchrSearchMethod == 1 then
		toast(f"eAchB_hold1")
		sleep(1e3)
		gg.searchNumber(13,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
		t = gg.getResults(200)
		for i=1,#t do
			tmp0 = ("%x"):format(t[i].address)
			if not (tmp0:find('518$') or tmp0:find('d18$') or tmp0:find('604$') or tmp0:find('e04$')) then t[i] = nil end
		end
		tmp0 = #t
		while tmp0 > 1 do
			toast(f"eAchB_hold2")
			sleep(1e3)
			gg.refineNumber(0)
			t = gg.getResults(200)
			tmp0 = #t
			if tmp0 == 1 then break
			elseif tmp0 == 0 then return
			elseif tmp0 == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
			toast(f"eAchB_hold1")
			sleep(1e3)
			gg.refineNumber(13)
			t = gg.getResults(200)
			tmp0 = #t
			if tmp0 == 1 then break
			elseif tmp0 == 0 then return
			elseif tmp0 == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
			tmp0 = #t
		end
		tmp,tmp0=nil,nil
		gg.clearResults()
		return (t and t[1]) and {t[1].address - 0x18} or nil
	elseif cfg.entityAnchrSearchMethod == 3 then
		toast(f"eAchC_wait")
	--this huge packs of "battery" below is basically searching "120W;20W;-501~30000W;13W;2B::??" in accurately optimized way
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 (random anchor)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) tmp[i].flags = gg.TYPE_BYTE end gg.loadResults(tmp) gg.refineNumber('0~256') -- 2/6 (Shooting state)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) end gg.loadResults(tmp) gg.refineNumber(cfg.abjAutoAnchor2_EntityTypeRangeFrom..'~'..cfg.abjAutoAnchor2_EntityTypeRangeTo) -- 3/6 (ControlCode)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC3) tmp[i].flags = gg.TYPE_WORD end gg.loadResults(tmp) gg.refineNumber('0~101')	-- 4/6 (HoldWeapon)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x10) end gg.loadResults(tmp) gg.refineNumber('-501~30000')                        -- 5/6 (Health)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
		if #tmp > 0 then
			gg.clearResults()
			for i=1,#tmp do tmp[i]=tmp[i].address end
			return tmp
		end
	else
		toast(f("ErrToastNotice","invalidConf"))
		print("[Error.InvalidConf]: Configuration value for \"cfg.entityAnchrSearchMethod\" ("..cfg.entityAnchrSearchMethod..") is invalid.\n         Change this on: Settings > Change entity anchor searching method")
		log("Your Configuration:\n",cfg)
	end
end
function findEntityAnchr_custom(searchType)
	--customizable type input from arg and stuff
	gg.setRanges(cfg.memRange.general)
	local tmp,tmp0
	if not searchType then return nil end
	toast(f"eAchC_wait")
	if searchType == 'blowables' then -- C4s and RC Cars
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 (random anchor)
		tmp=gg.getResults(5e3) -- will be reused
		tmp0 = table.copy(tmp) -- make a copy for 2nd searches

	--search c4s control code (put to tmp)
		for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xA4) tmp[i].flags = gg.TYPE_DWORD end gg.loadResults(tmp) gg.refineNumber(83886336) -- 3/6 (ControlCode, uncontrolled)
		tmp=gg.getResults(5e3)
		for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xD0) end gg.loadResults(tmp) gg.refineNumber(100)                        -- 5/6 (Health)
		tmp=gg.getResults(5e3)

	--search rc car control code (put to tmp0)
		gg.clearResults()
		for i=1,#tmp0 do tmp0[i].address = (tmp0[i].address + 0xA4) tmp0[i].flags = gg.TYPE_DWORD end gg.loadResults(tmp0) gg.refineNumber(67109120) -- 3/6 (ControlCode, uncontrolled)
		tmp0=gg.getResults(5e3)
		for i=1,#tmp0 do tmp0[i].address = (tmp0[i].address - 0xD0) end gg.loadResults(tmp0) gg.refineNumber('1~30000')                        -- 5/6 (Health)
		tmp0=gg.getResults(5e3)

	--merge 2 searches and find anchor
		table.append(tmp,tmp0)
		for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
	elseif searchType == 'blownUp' then -- exploded tanks or other (persistent) vehicles
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 (random anchor)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) tmp[i].flags = gg.TYPE_BYTE end gg.loadResults(tmp) gg.refineNumber(120) -- 2/6 (Shooting state, idle)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) end gg.loadResults(tmp) gg.refineNumber('4~7') -- 3/6 (ControlCode, uncontrolled)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC3) tmp[i].flags = gg.TYPE_WORD end gg.loadResults(tmp) gg.refineNumber('0~101')	-- 4/6 (HoldWeapon)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x10) end gg.loadResults(tmp) gg.refineNumber('-500~0')                        -- 5/6 (Health)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
	elseif searchType == 'player' then
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 random anchor
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) end gg.loadResults(tmp) gg.refineNumber(120)                                       -- 2/6 shooting state (warn: value sometimes altered a bit? i rarely checked it and it sometimes shows 122 instead)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) tmp[i].flags = gg.TYPE_BYTE  end gg.loadResults(tmp) gg.refineNumber(2)            -- 3/6 (ControlCode 2B)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC7) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) gg.refineNumber(55834574848)  -- 4/6 (HoldWeapon 0;0;13;0::W)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC)  tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber('-501~30000') -- 5/6 (Health -501~30000W(because carhealth&nostealcar cheat))
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
	end
	if gg.getResultCount() > 0 then
		gg.clearResults()
		for i=1,#tmp do tmp[i]=tmp[i].address end
		return tmp
	end
end
function exit()
	saveConfig()
	gg.clearResults()
	print(f"Exit_ThankYouMsg")
--for k in pairs(_ENV)do log("Lists of exposed global variables:\n",k)end
	os.exit()
end
function suspend()
	gg.saveVariable({
		cfg=cfg,
		memOzt=memOzt,
		pid=gg.getTargetInfo.pid,
	},susp_file)
	print(f"Suspend_Text")
	os.exit()
end
function update_language()
	curr_lang = (cfg.Language == "auto") and (translationTable[gg.getLocale] and gg.getLocale or "en_US") or cfg.Language
	lang = translationTable[curr_lang]
end
function saveConfig()
	cfg.memZones = lastCfg.memZones
	log("[saveConfig] Saving configuration to "..cfg_file)
	io.open(cfg_file,'w'):write([[-- This is the configuration file for Payback2_CHEATus.
-- You can customize any settings and parameters you want here (w/o messing that 'HUGE' script)
-- Make sure you have a backup of this config file, because even a tiny bit of error/typo here results in config reader failed and your config file got reset
-- Refer to my GitHub Wiki for some explanation (TODO)
-- btw, please ignore the return thingy below :)

return ]]..table.tostring(cfg)):close()
end
function loadConfig()
--Loads configuration file.
	cfg = {
		memZones={
			Common_RegionOther={0xB0000000,0xCFFFFFFF},
		},
		memRange={
			general = (gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
		},
		clearAllList=false,
		enableAutoMemRangeOpti=true,
		enableLogging=false,
		entityAnchrSearchMethod=2,
		Language="auto",
		PlayerCurrentName=":Player",
		PlayerCustomName=":CoolFoe",
		VERSION="2.4.6"
	}
	lastCfg = cfg
	local cfg_load = loadfile(cfg_file)
	if cfg_load then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = table.merge(cfg,cfg_load)
		lastCfg = table.copy(cfg) -- deep-clone
	else
		toast("No configuration files detected, Creating new one... 💾️\nHi There! ️Looks like you're new here 👋")
		saveConfig()
	end
	cfg_load = nil
	curVal.PlayerCurrentName = cfg.PlayerCurrentName
end
function restoreSuspend()
--Restore current session from suspend file and remove it afterwards
	local susp = loadfile(susp_file)
	if susp then
		susp = susp()
		os.remove(susp_file)
		if susp.pid == gg.getTargetInfo.pid then
			toast(f"Suspend_Detected")
			cfg = susp.cfg
			memOzt = susp.memOzt
		end
	end
	susp = nil
end
function log(...)if cfg.enableLogging then print("[Debug]",...)end end
print = (function() -- convert table to string
	local printLn,tmpArgBuffer = print
	return function(...)
		tmpArgBuffer = {...}
		for i=1,#tmpArgBuffer do
			if type(tmpArgBuffer[i]) == "table" then
				tmpArgBuffer[i] = table.tostring(tmpArgBuffer[i])
			end
		end
		return printLn(table.unpack(tmpArgBuffer))
	end
end)()
alert=function(str,...)gg.alert(f(str),...)end
toast=function(s,f)gg.toast(s,true)end
sleep=gg.sleep
isVisible=gg.isVisible
gg.sleepUntilGgGuiChanged=function(c,v,m)
	c = c or 500
	if m then toast(m) m = nil end
	if v == nil then v = true end
	gg.setVisible(v)
	while isVisible() == v do sleep(c) end
	gg.setVisible(not v)
end
--————————————————————————————————--



--— Initialization ———————————————--
curVal={
	PstlSgKnckbck=.25,
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

-- Run automatic memory range optimization (needs testing)
if cfg.enableAutoMemRangeOpti then
	cfg.memZones.Common_RegionOther = optimizeRange(cfg.memZones.Common_RegionOther)
end

-- Modify gg.clearList (if enabled in config), to only remove Pb2Chts-related values
if not cfg.clearAllList then
	gg.clearList = function()
		local t = gg.getListItems()
		for i=1,#t do
			if not t[i].name or t[i].name:sub(0,8) ~= "Pb2Chts " then
				t[i] = nil
			end
		end
		gg.removeListItems(t)
		t = nil
	end
end

-- Prepare language
translationTable = {
en_US={
Automatic				 = "Automatic",
About_Text			 = "Payback2 CHEATus, created by ABJ4403.\nCoded for hackable build 121\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\n\nImportant PS: Some or most of the cheats fail to work on 64bit devices, or version above 2.104.12.4 (build 121)\n\nThis cheat is part of FOSS (Free and Open-Source Software)",
Credits					 = "Credits",
Credits_Text		 = "Credit:\n• mdp43140 - Main Contributor\n• Mangyu - Original inspiration\n• MisterCuteX - Mega Explosion,Respawn Hack\n• tehtmi - unluac Creator (and decompile helper)\n• Crystal_Mods100x - ICE Menu\n• Latic AX & ToxicCoder - providing removed script via YT & MediaFire\n• AGH - Wall Hack,Car Health GG Values\n• GKTV - PB2 GG script (wall hack,big body,colored tree,big flamethower item,shadow,esp)\n• XxGabriel5HRxX - Car wheel height and acceleration GG Offsets\n• JokerGGS - No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4,Autoshoot rocket Drawing GG Values\n• antonyROOTlegendMAXx - Transparent vehicle GG Offsets.\n• MinFRE - 6 star police GG Offsets.",
Disclaimer			 = "Disclaimer (please read)",
Disclaimer_Text = "DISCLAIMER:\n	Please DO NOT misuse the script to harm other Payback2 players.\n	I'm NOT RESPONSIBLE for your action with using this script.\n	Remember to keep your patience out of other players.\n	i recommend ONLY using this script in offline mode.\n	I made this because no one would share their cheat script.",
Exit_ThankYouMsg = "	Report a bug: https://github.com/ABJ4403/Payback2_CHEATus/issues\n	Discussion: at https://github.com/ABJ4403/Payback2_CHEATus/discussions\n	FAQ: https://github.com/ABJ4403/Payback2_CHEATus/wiki",
License					 = "License",
License_Text		 = "Payback2 CHEATus, Cheat Lua Script for GameGuardian\n© 2021-2023 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.	If not, see https://gnu.org/licenses",
Settings				 = "Settings",
Suspend					 = "Suspend",
Suspend_Detected = "Session file detected, continuing from suspend...",
Suspend_Text		 = "Script suspended. Continue your current session by rerunning the script.",
Title_Version		 = "Payback2 CHEATus v"..cfg.VERSION..", by ABJ4403.",
ErrToastNotice = "An error occurred (%s): Exit out of script and see print log for more details.",
ErrNotFound		 = "Can't find the specific set of number",
ErrNotFound_Report = "Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues",
Cheat_WallHack   = "Wall Hack",
Cheat_WallHack_Notice = "Warn:\n- Careful w/ holes behind walls\n- using the GKTV wallhack is recommended cause its wonky physics can prevent helicopter from falling",
Cheat_C4AutoRig  = "C4 auto-trigger",
Cheat_GodModes   = "God Modes",
Cheat_GodModes_Notice = "WARN: DON'T USE THIS TO HARM INNOCENT PLAYERS IN ANY WAY!!",
Cheat_CSD        = "Client-side cheats",
Cheat_CSD_Notice = "Some cheats won't affect other player",
eAchA_wait       = "Please wait... don't shoot, hold pistol 🔫",
eAchA_dupe       = "%d Duplicate results! hold knife 🔪",
eAchB_hold1      = "Hold pistol 🔫",
eAchB_hold2      = "Hold knife 🔪",
eAchC_wait       = "Please wait, finding all entities...",
},
['in']={
Automatic				 = "Otomatis",
About_Text			 = "Payback2 CHEATus, dibuat oleh ABJ4403.\nDibuat untuk versi build 121\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\n\nPesan penting: Beberapa atau kebanyakan dari cheat tidak bekerja di perangkat 64bit, atau versi diatas 2.104.12.4 (build 121)\n\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)",
Credits					 = "Kredit",
Credits_Text		 = "Kredit:\n• mdp43140 - Kontributor Utama\n• Mangyu - Inspirasi original\n• MisterCuteX - Mega Explosion,Respawn Hack\n• tehtmi - Pembuat unluac (dan helper dekompilasi)\n• Crystal_Mods100x - Menu ICE\n• Latic AX & ToxicCoder - menyediakan skrip yang dihapus via YT & MediaFire\n• AGH - Value WallHack,CarHealth GG\n• GKTV - Skrip GG Payback2 (wall hack,big body,pohon berwarna,item flamethower besar,bayangan,esp)\n• XxGabriel5HRxX - offset Tinggi roda mobil dan akselerasi mobil GG\n• JokerGGS - Value No Blast Damage,Rel0ad,Rel0ad grenade,RTX,Immortal,Float,Ragdoll,C4 Drawing,Autoshoot roket GG\n• antonyROOTlegendMAXx - Offset kendaraan tembus pandang GG.\n• MinFRE - Offset 6 star police GG.",
Disclaimer			 = "Disklaimer (mohon untuk dibaca)",
Disclaimer_Text = "DISKLAIMER:\n	TOLONG JANGAN menyalahgunakan skrip ini untuk menjahili pemain lain.\n	Saya TIDAK BERTANGGUNG JAWAB atas kerusakan yang anda sebabkan karena MENGGUNAKAN skrip ini.\n	Ingat untuk menjaga kesabaran anda dari pemain lain.\n	Saya merekomendasikan menggunakan skrip ini HANYA di mode offline.\n	Saya membuat ini karena tidak ada orang lain yang membagikan skrip cheat mereka.",
Exit_ThankYouMsg = "	Laporkan bug: https://github.com/ABJ4403/Payback2_CHEATus/issues\n	Diskusi: https://github.com/ABJ4403/Payback2_CHEATus/discussions\n	Pertanyaan yang sering ditanyakan: https://github.com/ABJ4403/Payback2_CHEATus/wiki",
License					 = "Lisensi",
License_Text		 = "Payback2 CHEATus, Cheat Skrip Lua untuk GameGuardian\n© 2021-2023 ABJ4403\n\nProgram ini adalah perangkat lunak gratis: Anda dapat mendistribusikan kembali dan/atau memodifikasi\ndi bawah ketentuan lisensi publik umum GNU seperti yang diterbitkan oleh\nFree Software Foundation, baik lisensi versi 3, atau\n(pada opsi Anda) versi yang lebih baru.\n\nProgram ini didistribusikan dengan harapan bahwa itu akan berguna,\nTETAPI TANPA JAMINAN; bahkan tanpa jaminan tersirat dari\nKELAYAKAN JUAL atau KELAYAKAN UNTUK KEGUNAAN TERTENTU.	Lihat\nGNU Lisensi Publik Umum untuk detail lebih lanjut.\n\nAnda seharusnya menerima salinan Lisensi Publik Umum GNU\nbersama dengan program ini. Jika tidak, lihat https://gnu.org/licenses",
Settings				 = "Pengaturan",
Suspend					 = "Suspensi",
Suspend_Detected = "File sesi terdeteksi, melanjutkan dari suspensi...",
Suspend_Text		 = "Skrip Disuspensi. Lanjutkan sesi saat ini dengan menjalankan ulang skrip ini.",
Title_Version		 = "Payback2 CHEATus v"..cfg.VERSION..", oleh ABJ4403.",
ErrToastNotice = "Galat terjadi (%s): Keluar dari skrip dan lihat log print untuk lebih detail.",
ErrNotFound		 = "Tidak bisa menemukan angka tertentu",
ErrNotFound_Report = "Tidak bisa menemukan angka tertentu, laporkan isu ini di laman GitHub saya: https://github.com/ABJ4403/Payback2_CHEATus/issues",
Cheat_WallHack   = "Tembus Dinding",
Cheat_WallHack_Notice = "Perhatian:\n- Hati-hati dengan lubang dibelakang dinding\n- Saat menggunakan helikopter, direkomendasikan mengunnakan cheat tembus dinding GKTV karena fisik wonkynya bisa mencegah helikopter jatuh ke void",
Cheat_C4AutoRig  = "Auto-rig C4",
Cheat_GodModes   = "Mode tuhan",
Cheat_GodModes_Notice = "PERINGATAN: JANGAN MENGGUNAKAN INI UNTUK MENCURANGI PEMAIN LAIN DENGAN CARA APAPUN!!",
Cheat_CSD        = "Cheat sisi-klien",
Cheat_CSD_Notice = "Beberapa cheat tidak akan memengaruhi pemain lain",
eAchA_wait       = "Mohon tunggu... jangan menembak, pegang pistol 🔫",
eAchA_dupe       = "%d Hasil duplikat! pegang pisau 🔪",
eAchB_hold1      = "Pegang pistol 🔫",
eAchB_hold2      = "Pegang pisau 🔪",
eAchC_wait       = "Mohon tunggu, menemukan semua entitas...",
}
}
function f(i,...)return string.format(lang[i]or i,...)end
update_language()

-- Restore session file if any
restoreSuspend()

--detect if gg gui was open/floating gg icon clicked. if so, close that & show our menu.
while true do
	while not isVisible()do sleep(100)end
	gg.setVisible(false)
	MENU()
	gg.clearResults()
	collectgarbage()
end
--————————————————————————————————--