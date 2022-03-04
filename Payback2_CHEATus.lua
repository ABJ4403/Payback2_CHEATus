gg.getFile=gg.getFile()
local gg,tmp,revert,memBuffer,memOffset,memRange,susp_file,cfg_file,t,CH,ShowMenu,VAL_PstlSgKnckbck,VAL_CrDfltHlth,VAL_DmgIntnsty,VAL_WallResist,VAL_BigBody = gg,{},{},{},{},{},gg.getFile..'.suspend',gg.getFile..'.conf'

function MENU()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Weapon ammo",
		"2. Rel0ad",
		"3. Wall Hack",
		"4. Strong veichle",
		"5. No blast damage",
		"6. Immortality",
		"7. Pistol/SG Knockback",
		"8. C4 Painting",
		"---",
		"Other cheats:",
		"9. Client-side cosmetics",
		"10. Incompatible cheats",
		"---",
		string.format("Settings"),
		string.format("About"),
		string.format("Exit"),
		string.format("Suspend")
	},nil,string.format("Title_Version"))
	if CH == 1 then cheat_weaponammo()
	elseif CH == 2 then cheat_noreload()
	elseif CH == 3 then cheat_wallhack()
	elseif CH == 4 then cheat_strongveichle()
	elseif CH == 5 then cheat_noblastdamage()
	elseif CH == 6 then cheat_immortal()
	elseif CH == 7 then cheat_pistolknockback()
	elseif CH == 8 then cheat_c4paint()
---
--Title:Othercheat..
	elseif CH == 11 then MENU_CSD()
	elseif CH == 12 then MENU_incompat()
---
	elseif CH == 14 then MENU_settings()
	elseif CH == 15 then show_about()
	elseif CH == 16 then exit()
	elseif CH == 17 then suspend() end
	CH = nil
	tmp = {}
	collectgarbage("collect")
	HOMEDM=0
end

function MENU_CSD()
--Let the user choose stuff
	local CH = gg.choice({
		"Client-side cosmetics",
		"These cheats won't affect your actual gameplay, its more of a fancy stuff\nMost of these type of cheats come from GKTV",
		"1. Walk animation Wonkyness (client-side only)",
		"2. Change Name (EXPERIMENTAL)",
		"3. Change Name Color (EXPERIMENTAL)",
		"4. Burning body", -- is this considered cosmetic? kinda not, coz it makes you 'immortal' too, but incompat lol.
		"5. Big body",
		"6. Colored trees",
		"7. Big Flamethrower (Item)",
		"8. Shadows",
		"9. Colored People's (ESP, ExtraSensoryPerception. i think this is X-Ray Hack)",
		"10. Delete All Names",
		"---",
		string.format("Back")
	},nil,string.format("Title_Version"))
--Title:CSD...
--Title:This menu...
	if CH == 3 then cheat_walkwonkyness()
	elseif CH == 4 then cheat_changeplayername()
	elseif CH == 5 then cheat_changeplayernamecolor()
	elseif CH == 6 then cheat_firebody()
	elseif CH == 7 then cheat_bigbody()
	elseif CH == 8 then cheat_coloredtree()
	elseif CH == 9 then cheat_bigflamethroweritem()
	elseif CH == 10 then cheat_shadowfx()
	elseif CH == 11 then cheat_clrdpplesp()
	elseif CH == 12 then cheat_delete_ingameplaytext()
---
	elseif CH == 14 then MENU() end
end

function MENU_incompat()
--Let the user choose stuff
	local CH = gg.choice({
		"Incompatible cheats (below PB2 v2.104.12.4/GG v101.0)",
		"These cheats isn't compatible with the latest version of PB2. searching these will result in values not found, especially those that isnt located in CAlloc,Annonymous,Other,CodeApp\nSome of them are from ICE menu",
		"1. void mode",
		"2. Destroy all veichles",
		"3. Change XP",
		"4. Win Level",
		"5. Give Grenades",
		"6. Give C4s",
		"7. Give Laser",
		"---",
		string.format("Back")
	},nil,string.format("Title_Version"))
--Title:CSD...
--Title:This menu...
	if CH == 3 then cheat_togglevoidmode()
	elseif CH == 4 then cheat_destroycar()
	elseif CH == 5 then cheat_xpmodifier()
	elseif CH == 6 then cheat2_win()
	elseif CH == 7 then cheat2_givegrenade()
	elseif CH == 8 then cheat2_givec4()
	elseif CH == 9 then cheat2_givelaser()
---
	elseif CH == 11 then MENU() end
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
		string.format("Back")
	},nil,string.format("Title_Version"))
	if CH == 12 then MENU()
	elseif CH == 1 then
		local CH = gg.prompt({'Put your new default player name'},{cfg.PlayerCurrentName},{'text'})
		if (CH ~= nil and CH[1] ~= nil) then cfg.PlayerCurrentName = CH[1] end
		CH = nil
		MENU_settings()
	elseif CH == 2 then
		local CH = gg.prompt({'Put your new default custom player name'},{cfg.PlayerCustomName},{'text'})
		if (CH ~= nil and CH[1] ~= nil) then cfg.PlayerCustomName = CH[1] end
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
			"Back",
		},tmp,string.format("Title_Version"))
		if CH ~= nil then
			if CH == 4 then MENU_settings()
			elseif CH == 1 then cfg.Language = "en_US"
			elseif CH == 2 then cfg.Language = "in"
			elseif CH == 3 then cfg.Language = "auto" end
			CH = nil
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
	old version uses Ca,Ch,Jh,A (C++Alloc,C++Heap,JavaHeap,Annonymous)
	And also the previous value that is fail when tested, will fail even if you change memory region and still use same value
	some hint for u:
	don't forget to clear result before searching new ones if it fails
	#var is length
]]

function cheat_weaponammo()
	local CH = gg.choice({
		"1. Semi-automatic (WORD. uses new anchor20, works on latest version)",
		"2. DWORD (works by changing match settings. Requires respawn, works best in offline mode)",
		"3. WORD (works by changing player properties. no respawn required, but can't survive respawn)",
		"4. Automatic (Mangyu method, old version)",
		"5. Automatic (v2, not work because dynamic memory stuff)",
		string.format("Back")
	},nil,"Select method for modifying Weapon Ammo")
--gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS
	gg.setRanges(gg.REGION_OTHER)
	if CH == 6 then MENU()
	elseif CH == 1 then
		t = loopSearch(1,gg.TYPE_WORD,'Put (just) one of your weapon ammo',memRange.WpnAmmWrd)
		if gg.getResultCount() == 0 then
			toast("Can't find the said number, did you put the right number?")
		else
			local weaponAmmo = t[1].address
		--search for anchor
			gg.clearResults()
			gg.searchNumber(20,gg.TYPE_WORD,nil,nil,weaponAmmo - 0x2A,weaponAmmo)
			local anchorAddress = gg.getResults(1)
			anchorAddress = anchorAddress[1].address
		--prepare the cheated weapon table
			t = {
				{
					address=anchorAddress+0x1C,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Shotgun"
				},
				{
					address=anchorAddress+0x1E,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Rocket"
				},
				{
					address=anchorAddress+0x20,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Flamethrower"
				},
				{
					address=anchorAddress+0x22,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Grenade"
				},
				{
					address=anchorAddress+0x24,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Minigun"
				},
				{
					address=anchorAddress+0x26,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Explosives"
				},
				{
					address=anchorAddress+0x28,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Turret"
				},
				{
					address=anchorAddress+0x2A,
					flags=gg.TYPE_WORD,
					value=30000,
					name="Pb2Chts [Weapon]: Laser"
				},
			}
			gg.setValues(t)
			gg.addListItems(t)
			toast("🔨️ Weapon value Modified")
		end
	elseif CH == 2 then
		CH = gg.prompt({'Put all of your weapon ammo, divide each using ";"\neg. 100;200;..whatever\nbut i recommend diving each with ";0W;" instead (for more accuracy)'})
		if (CH ~= nil and CH[1] ~= nil) then
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
	elseif CH == 3 then
		t = loopSearch(16,gg.TYPE_WORD,'Put your weapon ammo',memRange.WpnAmmWrd)
		if gg.getResultCount() == 0 then
			toast("Can't find the said number, did you put the right number?")
		else
			for i=1, #t do
				t[i].value = 9999
			end
			gg.setValues(t)
			toast("🔨️ Weapon value Modified")
		end
	elseif CH == 4 then
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61",gg.TYPE_DWORD)
		local t = gg.getResults(5000,nil,nil,nil,nil,nil,gg.TYPE_DWORD)
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
	elseif CH == 5 then
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
	if CH ~= nil then
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
		string.format("Back")
	},nil,"Pistol/Shotgun knockback modifier\nCurrent: "..VAL_PstlSgKnckbck.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH ~= nil then
		if CH == 10 then MENU()
		elseif CH == 1 then PISTOL_KNOCKBACK_VALUE = -20
		elseif CH == 2 then PISTOL_KNOCKBACK_VALUE = 20
		elseif CH == 3 then PISTOL_KNOCKBACK_VALUE = 0.25
		elseif CH == 4 then PISTOL_KNOCKBACK_VALUE = 1e-5
		elseif CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if (CH == nil or CH[1] == nil) then
				cheat_pistolknockback()
			else
				PISTOL_KNOCKBACK_VALUE,CH = CH[1],nil
			end
		---
		elseif CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = VAL_PstlSgKnckbck},{[1] = 'number'})
			if (CH == nil or CH[1] == nil) then VAL_PstlSgKnckbck = CH[1] end
			CH = nil
			cheat_pistolknockback()
		elseif CH == 8 then
			CH,revert.PistolKnockback = nil,nil
			cheat_pistolknockback()
		elseif CH == 9 then
			CH,memBuffer.PistolKnockback = nil,nil
			cheat_pistolknockback()
		end
		if PISTOL_KNOCKBACK_VALUE ~= nil then
		-- | gg.REGION_ANONYMOUS
			gg.setRanges(gg.REGION_C_ALLOC)
			if memBuffer.PistolKnockback == nil then
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
		string.format("Back")
	},nil,"Wall Hack. Warn:\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for CTS in Metropolis, because there\'s less holes there")
	if CH ~= nil then
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
			if CH ~= nil then
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
		if tmp ~= nil then
			if tmp[1] == 1 then
				gg.setRanges(gg.REGION_CODE_APP)
				if memBuffer.wallhack_gktv == nil then
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
				print(tmp,memBuffer.wallhack_gktv)
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
				if memBuffer.wallhack == nil then
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
				if memBuffer.wallhack_hydra == nil then
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
		string.format("Back")
	},nil,"Big body")
	if CH ~= nil then
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
			if revert.bigbody == nil then
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
			if CH ~= nil then
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
		string.format("Back")
	},nil,"Veichle default health modifier")
	if CH ~= nil then
		if CH == 9 then MENU()
		elseif CH == 1 then CAR_HEALTH_VALUE = 85000
		elseif CH == 2 then CAR_HEALTH_VALUE = 125
		elseif CH == 3 then CAR_HEALTH_VALUE = -1
		elseif CH == 4 then
			local CH = gg.prompt({'Input your custom Veichle default health value'})
			if (CH == nil or CH[1] == nil) then
				cheat_strongveichle()
			else
				CAR_HEALTH_VALUE,CH = CH[1],nil
			end
		---
		elseif CH == 6 then
			local CH = gg.prompt({'If you think the current Veichle default health value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Veichle default health value'},{[1] = VAL_CrDfltHlth},{[1] = 'number'})
			if (CH == nil or CH[1] == nil) then
				VAL_CrDfltHlth = CH[1]
			end
			CH = nil
			cheat_strongveichle()
		elseif CH == 7 then
			CH,revert.CarHealth = nil,nil
			cheat_strongveichle()
		elseif CH == 8 then
			CH,memBuffer.CarHealth = nil,nil
			cheat_strongveichle()
		end
		if CAR_HEALTH_VALUE ~= nil then
			gg.setRanges(gg.REGION_CODE_APP)
			if memBuffer.CarHealth == nil then
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
		string.format("Back")
	},nil,"No damage\nThis will make you unable to get killed using any explosion blasts (that means you still can get killed by sg,mg,laser,turret,any non explosive weapons)\nPS: this will make your character buggy though")
	if CH ~= nil then
		if CH == 8 then MENU()
		elseif CH == 1 then DAMAGE_INTENSITY_VALUE = 0
		elseif CH == 2 then DAMAGE_INTENSITY_VALUE = 300
		elseif CH == 3 then
			local CH = gg.prompt({'Input your custom damage intensity'})
			if (CH == nil or CH[1] == nil) then
				cheat_noblastdamage()
			else
				DAMAGE_INTENSITY_VALUE,CH = CH[1],nil
			end
		---
		elseif CH == 5 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{[1] = VAL_DmgIntnsty},{[1] = 'number'})
			if (CH == nil or CH[1] == nil) then
				VAL_DmgIntnsty = CH[1]
			end
			CH = nil
			cheat_noblastdamage()
		elseif CH == 6 then
			CH,revert.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		elseif CH == 7 then
			CH,memBuffer.NoBlastDamage = nil,nil
			cheat_noblastdamage()
		end
		if DAMAGE_INTENSITY_VALUE ~= nil then
			gg.setRanges(gg.REGION_CODE_APP)
			if memBuffer.NoBlastDamage == nil then
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
		string.format("Back")
	},nil,"Destroy cars")
	if CH ~= nil then
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
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
		string.format("Back")
	},nil,"Void mode, select method")
	if CH ~= nil then
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

function cheat_noreload()
	local CH,t,num1 = gg.choice({
		"1. Default (for pistol,sg,rocket,C4s)",
		"2. Grenade (for grenades)",
		string.format("Back")
	},nil,"Rel0ad\nPS: dont get out of match, drive car, respawn. or the cheat will fail\nDISCLAIMMER: DO NOT USE THIS TO ABUSE OTHER PLAYER !!!!")
	if CH ~= nil then
		if CH == 3 then MENU()
		elseif CH == 1 then
			gg.setRanges(gg.REGION_OTHER)
			t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo',memRange.WpnAmmWrd)
			if gg.getResultCount() == 0 then
				toast('Can\'t find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
			else
				local weaponAmmo = t[1]
				weaponAmmo.value = 30000
				gg.setValues({weaponAmmo})
				gg.clearResults()
				if cfg.cheatSettings.noreload.useSearch20 == true then
				--The new method searches an anchor (which will not change position), and define bunch of values there
					gg.searchNumber(20,gg.TYPE_WORD,nil,nil,weaponAmmo.address - 0x2A,weaponAmmo.address)
					local anchorAddress = gg.getResults(1)
					anchorAddress = anchorAddress[1].address
					t = {
					{
					address=anchorAddress+0x84,
					flags=gg.TYPE_WORD,
					}
					}
				else
				--the old method searches the reload timing manually
					gg.searchNumber(0,gg.TYPE_WORD,nil,nil,weaponAmmo.address + 0x5A,weaponAmmo.address + 0x68)
					toast('Now shoot Pistol/Rocket/Shotgun (to trigger reload event timer. NOT machine gun, because it had different timing)')
					local bunchOfZeroes = gg.getResults(100)
					local foundTheValue = 0
					while foundTheValue == 0 do
						gg.refineNumber("-200~-1")
						if gg.getResultCount() == 1 then
							foundTheValue = 1
						else
							gg.loadResults(bunchOfZeroes)
						end
						sleep(100)
					end
					t = gg.getResults(1)
				end
				t[1].value = 0
				t[1].freeze = true
				t[1].name = "Pb2Chts [Rel0adTimer]"
				gg.setValues(t)
				gg.addListItems(t)
				weaponAmmo.value = 30000
				gg.setValues({weaponAmmo})
				gg.clearResults()
				toast('Found! Rel0ad ON\nWARNING: DO NOT DRIVE CAR, RESPAWN, OR GET OUT OF MATCH, OR WILL RESET !!')
			end
		elseif CH == 2 then
			gg.setRanges(gg.REGION_OTHER)
			t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo (i recommend grenade though)',memRange.WpnAmmWrd)
			if gg.getResultCount() == 0 then
				toast('Can\'t find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
			else
				local weaponAmmo = t[1]
				weaponAmmo.value = 32767
				gg.setValues({weaponAmmo})
				gg.clearResults()
				gg.searchNumber(20,gg.TYPE_WORD,nil,nil,weaponAmmo.address - 0x2A,weaponAmmo.address)
				local anchorAddress = gg.getResults(1)
				anchorAddress = anchorAddress[1].address
				t = {
				{
				address=anchorAddress+0x84,
				flags=gg.TYPE_WORD,
				freeze=true,
				name="Pb2Chts [Rel0adTimer]"
				}
				}
				local grenadeRange = gg.prompt({"Put your grenade range\nHold your grenade if you use this setting\nignore the throw range and disables delay by setting this to 0 [0;100]"},{0},{"number"})
				if (grenadeRange ~= nil and tonumber(grenadeRange[1]) ~= 0) then
					toast("Wait for it, dont forget to hold your grenade")
					sleep(999)
					t[1].value = grenadeRange[1]
					gg.setValues(t)
					gg.addListItems(t)
					grenadeRange = nil
					sleep(999)
				end
				t[1].value = -63
				gg.setValues(t)
				gg.addListItems(t)
				toast('Rel0ad (Grenade) On. WARNING:\n- DO NOT DRIVE CAR, RESPAWN, OR GET OUT OF MATCH, OR WILL RESET !!\n- You need to disable Rel0ad grenade before using Other Reload (for shotgun, pistol).\n- You cant shoot pistol,shotgun,etc when using Rel0ad Grenade.')
				gg.clearResults()
			end
		end
	end
end

function cheat_immortal()
--this cheat is based on rel0ad cheat
	gg.setRanges(gg.REGION_OTHER)
	local t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo (i know its weird, because the respawn stage interval is located near there)\nDISCLAIMMER:\n- DO NOT USE THIS TO ABUSE OTHER PLAYER!!!!\n- DO NOT PvP with non-cheater with this cheat!!',memRange.WpnAmmWrd)
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
	--why not eh?
		local weaponAmmo = t[1]
		weaponAmmo.value = 30000
		gg.setValues({weaponAmmo})
		gg.clearResults()
	--the core, search the health value (Located at xxxxxx08)
		gg.searchNumber(20,gg.TYPE_WORD,nil,nil,weaponAmmo.address - 0x2A,weaponAmmo.address)
		local anchorAddress = gg.getResults(1)
		anchorAddress = anchorAddress[1].address
		t = {
		{
			address=anchorAddress+0x08,
			flags=gg.TYPE_WORD,
			freeze=true,
			value=800,
			name="Pb2Chts [Health]"
		},
		{
			address=anchorAddress+0x158,
			flags=gg.TYPE_FLOAT,
			freeze=true,
			value=9,
			name="Pb2Chts [RespawnInterval] (Immortal)"
		}
		}
		--[[this isnt required: {
			address=anchorAddress+0x98,
			flags=gg.TYPE_WORD,
			freeze=true,
			value=30000,
			name="Pb2Chts: Invisibility (not really)"
		},]]
		gg.setValues(t)
		gg.addListItems(t)
		gg.clearResults()
		toast('Immortality ON\nWARN: Don\'t Drive car, respawn, or get out of match, Or get RESET after couple seconds')
	end
end

function cheat_c4paint()
--this cheat is based on rel0ad cheat
	gg.setRanges(gg.REGION_OTHER)
--Warn user to not having any c4s placed, and detonate them if so (only if search20 is disabled).
	if cfg.cheatSettings.c4paint.useSearch20 ~= true then toast('Dont put any explosives. if any, explode it\nAnd make sure no reload is turned off because you will place and detonate C4') end
--ask user any ammo
	t = loopSearch(1,gg.TYPE_WORD,'Put one of your weapon ammo (i know its weird, because the c4 placement position is located near there)\nto make c4 painting possible, c4 current placed position must freezed to -1',memRange.WpnAmmWrd)
--glorioss thingizz
	if gg.getResultCount() == 0 then
		toast('Can\'t find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
	--just for the ezznezz
		local weaponAmmo = t[1]
	--clear result to make sure 0 errors
		gg.clearResults()
	--optional stuff
		if cfg.cheatSettings.c4paint.useSearch20 == true then
		--search for anchor
			gg.searchNumber(20,gg.TYPE_WORD,nil,nil,weaponAmmo.address - 0x2A,weaponAmmo.address)
			local anchorAddress = gg.getResults(1)
			anchorAddress = anchorAddress[1].address
			t = {
				{
					address=anchorAddress+0x2C,
					flags=gg.TYPE_WORD,
				},
				{
					address=anchorAddress+0x2E,
					flags=gg.TYPE_WORD,
				}
			}
		else
		--Tell user to Detonate any C4s it currently connected to, and wait 5sec...
			toast('Now detonate any C4s you put (make sure Rel0ad is off to do it), 5 seconds before proceed')
			sleep(999)
			toast('Now detonate any C4s you put (make sure Rel0ad is off to do it), 4 seconds before proceed')
			sleep(999)
			toast('Now detonate any C4s you put (make sure Rel0ad is off to do it), 3 seconds before proceed')
			sleep(999)
			toast('Now detonate any C4s you put (make sure Rel0ad is off to do it), 2 seconds before proceed')
			sleep(999)
			toast('Now detonate any C4s you put (make sure Rel0ad is off to do it), 1 seconds before proceed')
			sleep(999)
		--Tell user to trigger C4 Placement...
			toast('Now place the explosives anywhere you want (essentialy you can start painting now, but i recommend the use of Rel0ad, yes you can enable it now after you done this)')
		--...While running some checking to detect some reduced number
			gg.searchNumber(-1,gg.TYPE_WORD,nil,nil,weaponAmmo.address + 0x04,weaponAmmo.address + 0x10)
			--Experiment2Begin
			if gg.getResultCount() == 0 then
				toast("Oh, this is weird 🤔️... We don't find the value we're searching for 🔍️. We will try hard, promise 😃️")
				gg.searchNumber(-1,gg.TYPE_WORD,nil,nil,weaponAmmo.address,weaponAmmo.address + 0xA0)
			end
			--Experiment2End
			local bunchOfZeroes = gg.getResults(2)
			local foundTheValue = 0
			while foundTheValue == 0 do
			--Search for values less than 0
			--Fun Fact: C4s is -1 if not placed, but any number above that means its placed, by freezing it to -1, you essentially creating C4 painting :D
				gg.refineNumber(-1,gg.TYPE_WORD,false,gg.SIGN_NOT_EQUAL)
			--if result is 1, pretend its found, else reset result.
				if gg.getResultCount() == 2 then
					foundTheValue = 1
				else
					gg.loadResults(bunchOfZeroes)
				end
				--sleep for a very short time to prevent lag
					sleep(100)
			end
			t = gg.getResults(2)
		end
		t[1].value = -1
		t[1].freeze = true
		t[1].name="Pb2Chts [C4Position]: X"
		t[2].value = -1
		t[2].freeze = true
		t[2].name="Pb2Chts [C4Position]: Y"
		weaponAmmo.value = 30000
		gg.setValues({weaponAmmo})
		gg.setValues(t)
		gg.addListItems(t)
		toast('Found! C4 Painting ON\nWARNING: DO NOT DRIVE CAR, RESPAWN, OR GET OUT OF MATCH, OR WILL RESET !!\nDetonate it by respawn')
		gg.clearResults()
	end
end

function cheat_xpmodifier()
--CAlloc for the gameplay and actual google play value
--Annonymous from joker video
--OTHER for the Chat and Displayed XP
--Won't affect stored xp (aka. temporary)
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANNONYMOUS | gg.REGION_OTHER)
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
	if CH ~= nil then
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
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
--request user to give player name
	local player_name = gg.prompt({
		'Put your current player name (case-sensitive, ":" is required at the beginning because how GameGuardian search works)',
		'Put new player name (cannot be longer than current name, you can change color/add icon by converting to hex and use hex 1-9 for color)'
	},{
		[1]=VAL_PlayerCurrentName,
		[2]=cfg.PlayerCustomName
	},{
		[1]="text",
		[2]="text"
	})
--search old player name
	if (player_name ~= nil and player_name[1] ~= nil and player_name[1] ~= ":") then
		gg.searchNumber(player_name[1],gg.TYPE_BYTE)
		revert.PlayerName = gg.getResults(5555)
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
		string.format("Back")
	},nil,"Select the color you want (Experimental)"),gg.prompt({'Put your current player name (case-sensitive)'},{VAL_PlayerCurrentName},{'text'})
	if (CH ~= nil or player_name ~= nil and player_name[1] ~= nil and player_name[1] ~= ":") then
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

		if player_color_choice ~= nil then
		--search old player name
			gg.searchNumber(player_name[1],gg.TYPE_BYTE)
		--fetch result,make backup result,make some temporary stuff
			local t,tmp0,removeOffset = gg.getResults(5555),0,0x0
			revert.PlayerName = gg.getResults(5555)
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
		string.format("Back")
	},nil,"Walk Wonkyness (fancy-cheat)")
	if CH ~= nil then
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
		string.format("Back")
	},nil,"Colored trees\nThis will change some shader stuff (actually idk wut this does lol) that affects trees")
	if CH ~= nil then
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
		string.format("Back")
	},nil,"Big flamethrower (Item)\nInfo: this will not make the flame burst bigger")
	if CH ~= nil then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={0.9,5.1403,"ON"}
		elseif CH == 2 then tmp={5.1403,0.9,"OFF"} end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber("0.4;0.2;"..tm0[1]..";24000::13",gg.TYPE_FLOAT)
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
		string.format("Back")
	},nil,"Shadow effects\nInfo: this wont affect your game performance at all (not making it lag/fast)\ndont use this for performance purpose :)")
	if CH ~= nil then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp{1e-4,-1.0012,"Disabled"}
		elseif CH == 2 then tmp{-1.0012,1e-4,"Enabled"} end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp[1]..";-5.96152076e27;-2.55751098e30;-1.11590087e28;-5.59128595e24:17",gg.TYPE_FLOAT)
		gg.refineNumber(tmp[1],gg.TYPE_FLOAT)
		local t = gg.getResults(1)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
			gg.clearResults()
			toast("Shadow "..tmp[3])
		end
	end
end

function cheat_clrdpplesp()
	local CH = gg.choice({
		"ON",
		"OFF",
		string.format("Back")
	},nil,"Colored people ESP (idk wut esp mean here)\nPS: Not work on latest version")
	if CH ~= nil then
		if CH == 3 then MENU()
		elseif CH == 1 then tmp={0.08,436,"ON"}
		elseif CH == 2 then tmp={436,0.08,"OFF"} end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp[1],gg.TYPE_FLOAT)
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp[2],gg.TYPE_FLOAT)
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


function cheat2_givegrenade()
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

function cheat2_givec4()
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

function cheat2_givelaser()
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

function cheat2_win()
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
		string.format("About"),
		"---",
		string.format("Disclaimmer"),
		string.format("License"),
		string.format("Credits"),
		string.format("Back")
	},nil,string.format("About"))
	if CH == 1 then alert(string.format("About_Text")) show_about()
	---
	elseif CH == 3 then alert(string.format("Disclaimmer_Text")) show_about()
	elseif CH == 4 then alert(string.format("License_Text")) show_about()
	elseif CH == 5 then alert(string.format("Credits_Text")) show_about()
	elseif CH == 6 then CH = nil MENU() end
end

function exit()
	print(string.format("Exit_ThankYouMsg"))
	gg.saveVariable(cfg,cfg_file)
	gg.clearResults()
--gg.clearList() -- this will clear your list not recommend though...
	os.exit()
end

function suspend()
	print(string.format("Suspend_Text"))
	gg.saveVariable({
		revert=revert,
		memBuffer=memBuffer,
		cfg=cfg
	},susp_file)
	os.exit()
end

-- Helper functions
function loopSearch(desiredResultCount,valueType,msg1,restrictedMemArea)
	local num1,t = gg.prompt({msg1})
	restrictedMemArea = restrictedMemArea or {}
	if (num1 ~= nil and num1[1] ~= nil) then
	--Search within restricted memory address, which will give more performance
		gg.searchNumber(num1[1],valueType,nil,nil,restrictedMemArea[1],restrictedMemArea[2])
		if gg.getResultCount() ~= 0 then
			while gg.getResultCount() >= desiredResultCount+1 do
				tmp = gg.getResultCount()
				if (cfg.cheatSettings.loopSearch.useFuzzyDecrease == true and tonumber(num1[1]) >= 20) then
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
					if (num1 == nil or num1[1] == nil) then break end
					gg.refineNumber("0~32767")
					gg.refineNumber(num1[1])
				end
			--If found 2 result, check if 2 numbers are same, and return 1st value if so (this means user is on a veichle)
				tmp = gg.getResultCount()
				if tmp == 2 then
					t = gg.getResults(2)
					if t[1].value == t[2].value then
						tmp = {}
						return {t[1]}
					end
			--If nothing found...
				elseif tmp == 0 then
					if restrictedMemArea[1] == nil then
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
			tmp = {}
			return gg.getResults(desiredResultCount)
		end
	end
end
function MergeTables(...)
	--[[
		merge 2 tables, just like Object.assign on JS
		first table will be replaced by new table...
		recommended only on object-like tables
		not recommended on array-like tables
	]]
	local r = {}
		for _,t in ipairs{...} do
			for k,v in pairs(t) do
				r[k] = v
			end
		end
	return r
end
function ConcatTables(t1,t2)
	--[[
		Creates new table then
		add table 1 and table 2
	]]
	for i=1,#t2 do
		t1[#t1+i] = t2[i]
	end
	return t1
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
			}
		},
		enableLogging=false,
		Language="auto",
		PlayerCurrentName=":Player",
		PlayerCustomName=":CoolFoe",
		removeSuspendAfterRestoredSession=true,
		VERSION="2.0.2"
	}
	local cfg_load = loadfile(cfg_file)
	if cfg_load ~= nil then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = MergeTables(cfg,cfg_load)
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
	if susp ~= nil then
		toast(string.format("Suspend_Detected"))
		susp = susp()
		cfg = susp.cfg
		revert = susp.revert
		memBuffer = susp.memBuffer
		if cfg.removeSuspendAfterRestoredSession == true then
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
VAL_WallResist={-500,-1.00001,-1}
VAL_BigBody={3,5.9}
memOffset={
	BigBody={0.09500002861,0.00000019073}
}
memRange={
	WpnAmmWrd={0xB000051C,0xBD0FFD2A}
}

-- Load settings and languages
loadConfig()

-- Initialize language
local lang = {
en_US={
Automatic				 = "Automatic",
About						 = "About",
About_Text			 = "Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number, even cheat menu which didnt show any numbers at all). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes",
Back						 = "Back",
Credits					 = "Credits",
Credits_Text		 = "Credit:\n+ Mangyu - Original script\n+ mdp43140 - Contributor\n+ tehtmi - unluac Creator (and decompile helper).\n+ Crystal_Mods100x - ICE Menu\n+ Latic AX and ToxicCoder - for providing removed script through YT & MediaFire.\n+ Alpha GG Hacker - Wall Hack & Car Health GameGuardian Values\n+ GKTV (Pumpkin Hacker) - Payback2 GG script.\n+ Joker - for providing No Blast Damage and No Reload GameGuardian Values.",
Disclaimmer			 = "Disclaimmer (please read)",
Disclaimmer_Text = "DISCLAIMMER:\n	Please DO NOT misuse the script to abuse other players.\n	I'm NOT RESPONSIBLE for your action with using this script.\n	Remember to keep your patience out of other players.\n	i recommend ONLY using this script in offline mode.\n	I made this because no one would share their cheat script.",
Exit						 = "Exit",
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
About						 = "Tentang",
About_Text			 = "Payback2 CHEATus, dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini?\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak membagikan skrip cheat mereka sama sekali. Tentu ini melanggar filosofi open-source, kita perlu melihat sumber kode untuk memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim (banyak sensor stiker/teks/zoom-in, speedup, apalagi sesuatu yang berkaitan dengan alamat memory, atau ya... nomor apapun, bahkan menu cheat yang tidak menampilkan nomor sama sekali). Bahkan jika ia memberikan tautan unduhan dari satu cheat (hack wall),\nitu masih proprietri, saya tidak dapat membaca sumber kode satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang",
Back						 = "Kembali",
Credits					 = "Kredit",
Credits_Text		 = "Kredit:\n+ Mangyu - Pembuat skrip original.\n+ mdp43140 - Kontributor.\n+ tehtmi - Pembuat unluac (dan helper dekompilasi).\n+ Crystal_Mods100x - Menu ICE\n+ Latic AX dan ToxicCoder - untuk menyediakan skrip yang telah dihapus melalui YT & MediaFire.\n+ Alpha GG Hacker - Values Wall Hack & Car Health GameGuardian \n+ GKTV (Pumpkin Hacker) - Skrip GG Payback2.\n+ Joker - Value No Blast Damage & No Reload GameGuardian.",
Disclaimmer			 = "Disklaimmer (mohon untuk dibaca)",
Disclaimmer_Text = "DISKLAIMMER:\n	TOLONG JANGAN menyalahgunakan skrip ini untuk menjahili pemain lain.\n	Saya TIDAK BERTANGGUNG JAWAB atas kerusakan yang anda sebabkan karena MENGGUNAKAN skrip ini.\n	Ingat untuk menjaga kesabaran anda dari pemain lain.\n	Saya merekomendasikan menggunakan skrip ini HANYA di mode offline.\n	Saya membuat ini karena tidak ada orang lain yang membagikan skrip cheat mereka.",
Exit						 = "Keluar",
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
	if (
		input == "Automatic" or
		input == "About" or
		input == "About_Text" or
		input == "Back" or
		input == "Credits" or
		input == "Credits_Text" or
		input == "Disclaimmer" or
		input == "Disclaimmer_Text" or
		input == "Exit" or
		input == "Exit_ThankYouMsg" or
		input == "License" or
		input == "License_Text" or
		input == "Settings" or
		input == "Suspend" or
		input == "Suspend_Detected" or
		input == "Suspend_Text" or
		input == "Title_Version"
	) then return lang[curr_lang][input] end
	return string.format2(input,...)
end

-- Restore suspend file if any
restoreSuspend()

--detect if gg gui was open/floating gg icon clicked. if so, close that and run OpenMenu (which will open our menu) instead (dont worry, we have suspend feature now).
ShowMenu = MENU
while true do
	if gg.isVisible() then
		gg.setVisible(false)
		HOMEDM = 1
	end
	if HOMEDM == 1 then
		ShowMenu()
	end
end
