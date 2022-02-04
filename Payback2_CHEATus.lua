function MENU()
--Let the user choose stuff
	local CH = gg.choice({
		"1. Pistol/SG Knockback",
		"2. Weapon ammo",
		"3. Wall Hack",
		"4. Strong veichle",
		"5. No blast damage",
		"---",
		"Other cheats:",
		"5. Client-side cosmetics",
		"6. Incompatible cheats",
		"---",
		"Settings/Pengaturan",
		"About/Tentang",
		"Exit/Keluar",
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
	if CH == 1 then cheat_pistolknockback() end
	if CH == 2 then cheat_weaponammo() end
	if CH == 3 then cheat_wallhack() end
	if CH == 4 then cheat_strongveichle() end
	if CH == 5 then cheat_noblastdamage() end
---
--Title:Othercheat..
	if CH == 8 then MENU_CSD() end
	if CH == 9 then MENU_incompat() end
---
	if CH == 11 then MENU_settings() end
	if CH == 12 then show_about() end
	if CH == 13 then exit() end
	HOMEDM = -1
end

function MENU_CSD()
--Let the user choose stuff
	local CH = gg.choice({
		"Client-side cosmetics",
		"These cheats won't affect your actual gameplay, its more of a fancy stuff",
		"1. Walk animation Wonkyness (client-side only)",
		"2. Change Name (EXPERIMENTAL)",
		"3. Change Name Color (EXPERIMENTAL)",
		"4. Burning body", -- is this considered cosmetic, kinda not though, because it makes you unkillable too, but incompat lol.
		"5. Big body",
		"6. Colored trees",
		"7. Big Flamethrower (Item)",
		"8. Shadows",
		"9. Colored People's (ESP, ExtraSensoryPerception. i think this is X-Ray Hack. from GKTV)",
		"10. Delete All Names",
		"---",
		"Back/Kembali"
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
--Title:CSD...
--Title:This menu...
	if CH == 3 then cheat_walkwonkyness() end
	if CH == 4 then cheat_changeplayername() end
	if CH == 5 then cheat_changeplayernamecolor() end
	if CH == 6 then cheat_firebody() end
	if CH == 7 then cheat_bigbody() end
	if CH == 8 then cheat_coloredtree() end
	if CH == 9 then cheat_bigflamethroweritem() end
	if CH == 10 then cheat_shadowfx() end
	if CH == 11 then cheat_clrdpplesp() end
	if CH == 12 then cheat_delete_ingameplaytext() end
---
	if CH == 14 then MENU() end
	HOMEDM = -1
end

function MENU_incompat()
--Let the user choose stuff
	local CH = gg.choice({
		"Incompatible cheats (below PB2 v2.104.12.4/GG v101.0)",
		"These cheats isn't compatible with the latest version of PB2. searching these will result in values not found, especially those that isnt located in JavaHeap,CAlloc,Annonymous,Other,CodeApp",
		"1. Toggle void mode (not work for now due to memory address issue)",
		"2. Weapon",
		"3. Destroy all cars",
		"4. Change XP",
		"5. No reload (From Hydra and other yt channel i forgot...)",
		"6. Win Level (From ICE Menu)",
		"7. Give Grenades (From ICE Menu)",
		"8. Give C4s (From ICE Menu)",
		"9. Give Laser (From ICE Menu)",
		"---",
		"Back/Kembali"
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
--Title:CSD...
--Title:This menu...
	if CH == 3 then cheat_togglevoidmode() end
	if CH == 4 then cheat_weapon() end
	if CH == 5 then cheat_destroycar() end
	if CH == 6 then cheat_xpmodifier() end
	if CH == 7 then cheat_togglenoreload_exp() end
	if CH == 8 then cheat2_win() end
	if CH == 9 then cheat2_givegrenade() end
	if CH == 10 then cheat2_givebomb() end
	if CH == 11 then cheat2_givelaser() end
---
	if CH == 13 then MENU() end
	HOMEDM = -1
end

function MENU_settings()
--Let the user choose stuff
	local CH = gg.choice({
		"Back",
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
	if CH == 1 then exit() end
	HOMEDM = -1
end
--[[
	A little note before looking at the cheat mechanics:
	On newer version of the game, now it stores data mostly on OTHER region (with the rest of the data stored in Calloc, Annonymous, and CodeApp), not Ca,Ch,Jh,A
	And also the previous value that is fail when tested, will fail even if you change memory region and still use same value
]]

function cheat_weapon()
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
	gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61", gg.TYPE_DWORD)
	local t = gg.getResults(5000, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
	if gg.getResultCount() == 0 then
		gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		for i, v in ipairs(t) do
			v.value = 71131136
			v.freeze = true
		end
		gg.setValues(t)
		t = nil
		gg.clearResults()
		gg.toast("Weapon ON")
	end
end

function cheat_weaponammo()
	local CH = gg.choice({
		"Automatic",
		"Fallback (Default, modifies the DWORD, works best in offline mode)",
		"Fallback (v2, modified the WORD, no respawn required, but cant survive respawn)",
		"Back"
	}, nil, "Select method for modifying weapon amount - Modify Weapon Amount\nPS: not tested for multiplayer (while the gameplay running), might not work.")
	if CH ~= nil then
		if CH == 3 then MENU() end
		gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
		if CH == 1 then -- automatic method (wont work due to memory location always change)
	 -- Prepare the table
			local e = {}
			e[1] = {}
			e[2] = {}
			e[3] = {}
			e[4] = {}
			e[5] = {}
			e[6] = {}
			e[7] = {}
			e[8] = {}
			e[1].flags = gg.TYPE_DWORD
			e[2].flags = gg.TYPE_DWORD
			e[3].flags = gg.TYPE_DWORD
			e[4].flags = gg.TYPE_DWORD
			e[5].flags = gg.TYPE_DWORD
			e[6].flags = gg.TYPE_DWORD
			e[7].flags = gg.TYPE_DWORD
			e[8].flags = gg.TYPE_DWORD
			e[1].value = 9999
			e[2].value = 9999
			e[3].value = 9999
			e[4].value = 9999
			e[5].value = 9999
			e[6].value = 9999
			e[7].value = 9999
			e[8].value = 999 -- Laser amount will bugged out if the number is 9999
	 -- Shotgun
			e[1].address = 0xC22743C4
	 -- Rocket
			e[2].address = 0xC22743C8
	 -- Flamethrower
			e[3].address = 0xC22743CC
	 -- Grenade
			e[4].address = 0xC22743D0
	 -- Machine Gun
			e[5].address = 0xC22743D4
	 -- Sticky Bomb
			e[6].address = 0xC22743D8
	 -- Auto Turret
			e[7].address = 0xC22743DC
	 -- Laser
			e[8].address = 0xC22743E0
	 -- And set the value
			gg.setValues(e)
		end
		if CH == 2 then -- Fallback method (requires manually putting values, but will work in most cases)
			local WEAPON_AMMO_AMOUNT = gg.prompt({'Put all of your weapon ammo, divide each using ";"\neg. 100;200;150;60;45'})
			if (WEAPON_AMMO_AMOUNT ~= nil and WEAPON_AMMO_AMOUNT[1] ~= nil) then
				gg.searchNumber(WEAPON_AMMO_AMOUNT[1], gg.TYPE_DWORD) -- TODO: Search only in 0xC22743C4-0x6FBEA7A4 range
				gg.getResults(16)
				if gg.getResultCount() == 0 then
					gg.toast("Can't find the said number, did you put the right number?")
				else
					gg.editAll(9999, gg.TYPE_DWORD)
					gg.toast("Now respawn yourself (Pause,end,respawn,yes), to get the desired number")
				end
			end
		end
		if CH == 3 then -- Fallback v2 method (requires manually putting values, but will search WORD instead of DWORD, )
			local WEAPON_AMMO_AMOUNT = gg.prompt({'Put one of your weapon ammo','Freeze'},{},{[2]="checkbox"})
			if (WEAPON_AMMO_AMOUNT ~= nil and WEAPON_AMMO_AMOUNT[1] ~= nil) then
				gg.searchNumber(WEAPON_AMMO_AMOUNT[1], gg.TYPE_DWORD) -- TODO: Search only in 0xC22743C4-0x6FBEA7A4 range
				gg.getResults(16)
				if gg.getResultCount() == 0 then
					gg.toast("Can't find the said number, did you put the right number?")
				else
					gg.editAll(9999, gg.TYPE_DWORD)
					gg.toast("Now respawn yourself (Pause,end,respawn,yes), to get the desired number")
				end
			end
		end
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end

function cheat_firebody()
	local tmp0,CH = {}, gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Burning body")
	if CH ~= nil then
		if CH == 3 then MENU() end
		if CH == 1 then tmp0[1] = "9999" tmp0[2] = "ON" end
		if CH == 2 then tmp0[1] = "0" tmp0[2] = "OFF" end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber("1.68155816e-43F;0D~9999D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45", gg.TYPE_DWORD)
		local t = gg.getResults(555, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			for i, v in ipairs(t) do
				v.value = tmp0[1]
				v.freeze = true
			end
			gg.setValues(t)
			gg.clearResults()
			gg.toast("Burning body "..tmp0[2])
		end
		tmp0 = nil
	end
	HOMEDM = -1
end

function cheat_pistolknockback()
	local CH = gg.choice({
		"Grapple gun/Pull (-20)",
		"Knockback/Push (20)",
		"Default (0.25)",
		"N0ne (WARN: This causes game to lag when pistol bullet get shot)",
		"Custom",
		"---",
		"Change current Knockback variable",
		"Restore previous value",
		"Clear memory buffer",
		"Back"
	}, nil, "Pistol/Shotgun knockback modifier\nCurrent: "..VAL_PstlSgKnockback.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH ~= nil then
		if CH == 10 then MENU() end
		if CH == 1 then PISTOL_KNOCKBACK_VALUE = "-20" end
		if CH == 2 then PISTOL_KNOCKBACK_VALUE = "20" end
		if CH == 3 then PISTOL_KNOCKBACK_VALUE = "0.25" end
		if CH == 4 then PISTOL_KNOCKBACK_VALUE = "0" end
		if CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if (CH == nil and CH[1] == nil) then
				cheat_pistolknockback()
			else
				PISTOL_KNOCKBACK_VALUE,CH = CH[1],nil
			end
		end
		---
		if CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = VAL_PstlSgKnockback},{[1] = 'number'})
			if (CH == nil and CH[1] == nil) then
				VAL_PstlSgKnockback = CH[1]
			end
			CH = nil
			cheat_pistolknockback()
		end
		if CH == 8 then
			CH,revert['PistolKnockback'] = nil,nil
			cheat_pistolknockback()
		end
		if CH == 9 then
			CH,MemoryBuffer['PistolKnockback'] = nil,nil
			cheat_pistolknockback()
		end		
		if PISTOL_KNOCKBACK_VALUE ~= nil then
			gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
			if MemoryBuffer['PistolKnockback'] == nil then
				gg.toast('No buffer found, creating new buffer')
		 -- Find specific value
				gg.searchNumber(VAL_PstlSgKnockback.."F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
		 -- Get float-type-only result, and make a backup.
				MemoryBuffer['PistolKnockback'],revert['PistolKnockback'] = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_FLOAT),gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_FLOAT)
			else
				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(MemoryBuffer['PistolKnockback'])
			end
	 -- Check if found any result
			if gg.getResultCount() == 0 then
				MemoryBuffer['PistolKnockback'],revert['PistolKnockback'] = nil,nil
				gg.toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i, v in ipairs(MemoryBuffer['PistolKnockback']) do
					v.value = PISTOL_KNOCKBACK_VALUE
				end
				VAL_PstlSgKnockback = PISTOL_KNOCKBACK_VALUE
				PISTOL_KNOCKBACK_VALUE = nil
				gg.toast("Pistol/SG Knockback "..VAL_PstlSgKnockback)
				gg.setValues(MemoryBuffer['PistolKnockback'])
			end
			gg.clearResults()
		end
		CH = nil
	end
	HOMEDM = -1
end

function cheat_wallhack()
	local tmp0,CH = {},gg.choice({
		"ON (Default, physics works best. need to reapplied every match, takes some time)",
		"ON (Alternative, wonky physics. but fast to enable, survives multiple match, and can wallhack a veichle & peoples too not just a wall)",
		"ON (Hydra method, not work for latest version, unknown (dis)abilities)",
		"OFF (Default, Not recommended if buffer is empty)",
		"OFF (Alternative)",
		"OFF (Hydra method)",
		"---",
		"Restore previous value",
		"Use custom value",
		"Clear memory buffer",
		"Back"
	}, nil, "Wall Hack. Warn:\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for Capture The Swags, especially in Metropolis, because theres less holes there")
	if CH ~= nil then
		if CH == 9 then MENU() end
 -- Set ranges
 		if CH == 1 then tmp0[1]="default"		  tmp0[2]="1140457472D;500F::" tmp0[3]=VAL_WallResist[1] tmp0[4]="ON" end
 		if CH == 2 then tmp0[1]="alternative" tmp0[2]="0.001"							tmp0[3]=VAL_WallResist[2] tmp0[4]="ON" end
 		if CH == 3 then tmp0[1]="hydra"       tmp0[2]="1078618499;1094412911;1;1034868570;1050796852::493" tmp0[3]=VAL_WallResist[3] tmp0[4]="ON" end
 		if CH == 4 then tmp0[1]="default"		  tmp0[2]=VAL_WallResist[1]		tmp0[3]="1140457472"			tmp0[4]="OFF" end
 		if CH == 5 then tmp0[1]="alternative" tmp0[2]=VAL_WallResist[2]		tmp0[3]="0.001"					 tmp0[4]="OFF" end
 		if CH == 6 then tmp0[1]="hydra"       tmp0[2]="1078618499;1094412911;"..VAL_WallResist[3]..";1034868570;1050796852::493" tmp0[3]="1" tmp0[4]="OFF" end
		---
		if CH == 6 then
			gg.setValues(revert['wallhack'])
			gg.setValues(revert['wallhack_alternative'])
			gg.setValues(revert['wallhack_hydra'])
			revert['wallhack'],revert['wallhack_alternative'],revert['wallhack_hydra'] = nil,nil,nil
			gg.toast("Previous value restored, be warned though this will cause instability")
		end
		if CH == 7 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default:1140457472,Cheatus default:-500)',
				'Put your custom value for Alternative method (Game default:0.001,Cheatus default:-1.00001)',
				'Put your custom value for Hydra method (Game default:1,known cheatus default:-1)'
			},{
				[1] = VAL_WallResist[1],
				[2] = VAL_WallResist[2],
				[3] = VAL_WallResist[3]
			},{
				[1] = 'number',
				[2] = 'number',
				[3] = 'number'
			})
			if CH ~= nil then
				if CH[1] ~= "" then VAL_WallResist[1] = CH[1] end
				if CH[2] ~= "" then VAL_WallResist[2] = CH[2] end
				if CH[3] ~= "" then VAL_WallResist[3] = CH[3] end
			end
			CH = nil
			cheat_wallhack()
		end
		if CH == 8 then
			CH,MemoryBuffer['wallhack'],MemoryBuffer['wallhack_alternative'] = nil,nil,nil
			gg.toast("Memory buffer cleared")
		end
		
		if tmp0[1] == "default" then -- This default method is slow, and only survives single match, but physics works best here, especially when you hit a wall corner, or using tank to phase walls.
			gg.setRanges(gg.REGION_C_ALLOC)
--			if MemoryBuffer['wallhack'] == nil then
--				gg.toast('No previous memory buffer found, creating new buffer.')
				gg.searchNumber(tmp0[2])
				MemoryBuffer['wallhack'],revert['wallhack'] = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD),gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
--			else
--				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
--				gg.loadResults(MemoryBuffer['wallhack'])
--				gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
--			end
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(MemoryBuffer['wallhack']) do
					v.value = tmp0[3]
				end
				gg.setValues(MemoryBuffer['wallhack'])
				gg.clearResults()
				gg.toast("Wall Hack "..tmp0[4])
			end
		end
		if tmp0[1] == "alternative" then -- This altervative method can survive multiple matches, and the value can be found very fast (because it only scans CodeApp), but the physics is wonky
			gg.setRanges(gg.REGION_CODE_APP)
--			if MemoryBuffer['wallhack_alternative'] == nil then
--				gg.toast('No previous memory buffer found, creating new buffer.')
				gg.searchNumber(tmp0[2], gg.TYPE_FLOAT)
				MemoryBuffer['wallhack_alternative'],revert['wallhack_alternative'] = gg.getResults(50),gg.getResults(50)
--			else
--				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
--				gg.loadResults(MemoryBuffer['wallhack_alternative'])
--				gg.getResults(50)
--			end
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(MemoryBuffer['wallhack_alternative']) do
					v.value = tmp0[3]
				end
				gg.setValues(MemoryBuffer['wallhack_alternative'])
				gg.clearResults()
				gg.toast("Wall Hack "..tmp0[4])
			end
		end
		if tmp0[1] == "hydra" then -- Hydra method had no (dis)advantages... coz it isnt affecting latest version...
			gg.setRanges(gg.REGION_OTHER)
			if MemoryBuffer['wallhack_hydra'] == nil then
				gg.toast('No previous memory buffer found, creating new buffer.')
				gg.searchNumber(tmp0[2], gg.TYPE_DWORD)
				gg.refineNumber(1)
				MemoryBuffer['wallhack_hydra'],revert['wallhack_hydra'] = gg.getResults(40),gg.getResults(40)
			else
				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(MemoryBuffer['wallhack_hydra'])
				gg.getResults(40)
			end
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(MemoryBuffer['wallhack_hydra']) do
					v.value = tmp0[3]
				end
				gg.setValues(MemoryBuffer['wallhack_hydra'])
				gg.clearResults()
				gg.toast("Wall Hack "..tmp0[4])
			end
		end
	end
	tmp0 = nil
	HOMEDM = -1
end

function cheat_bigbody()
	local CH = gg.choice({
		"ON (Default, based on Mangyu original script)",
		"ON (Alternative, client-side only. affects everyone you see, not just you)",
		"OFF (Default)",
		"OFF (Alternative)",
		"Restore previous value",
		"Use custom value",
		"Back"
	}, nil, "Big body")
	if CH ~= nil then
		if CH == 3 then
			MENU()
		end
		local t
		if CH == 1 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber("1"+SPECIALOFFSET_bigbody[1], gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert['bigbody'] = gg.getResults(555)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = VAL_BigBody[1]+SPECIALOFFSET_bigbody[1]
					v.freeze = true
				end
				gg.toast("Big Body ON")
			end
			gg.setValues(t)
		end
		if CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber("4.3"+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert['bigbody'] = gg.getResults(22)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(VAL_BigBody[2]+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
				gg.toast("Big Body ON")
			end
		end
		if CH == 3 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber(VAL_BigBody[1]+SPECIALOFFSET_bigbody[1], gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert['bigbody'] = gg.getResults(555)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = "1"+SPECIALOFFSET_bigbody[1]
					v.freeze = true
				end
				gg.toast("Big body OFF")
			end
			gg.setValues(t)
		end
		if CH == 4 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber(VAL_BigBody[2]+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert['bigbody'] = gg.getResults(22)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("4.3"+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
				gg.toast("Big body OFF")
			end
		end
		if CH == 5 then
			if revert['bigbody'] == nil then
				gg.toast("No values to restore, this might be a bug. if you think so, report bug on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.setValues(revert['bigbody'])
				revert['bigbody'] = nil
				gg.clearResults()
				gg.toast("Wall hack previous value restored, be warned though this will cause instability")
			end
		end
		if CH == 6 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default: 1,Cheatus default: 3, offset: '..SPECIALOFFSET_bigbody[1]..')',
				'Put your custom value for Alternative method (Game default: 4.3,Cheatus default: 5.9, offset: '..SPECIALOFFSET_bigbody[2]..')'
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
		CH = nil
	end
	HOMEDM = -1
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
		"Back"
	}, nil, "Veichle default health modifier")
	if CH ~= nil then
		if CH == 10 then MENU() end
		if CH == 1 then CAR_HEALTH_VALUE = "85000" end
		if CH == 2 then CAR_HEALTH_VALUE = "125" end
		if CH == 3 then CAR_HEALTH_VALUE = "-1" end
		if CH == 5 then
			local CH = gg.prompt({'Input your custom Veichle default health value'})
			if (CH == nil and CH[1] == nil) then
				cheat_strongveichle()
			else
				CAR_HEALTH_VALUE,CH = CH[1],nil
			end
		end
		---
		if CH == 7 then
			local CH = gg.prompt({'If you think the current Veichle default health value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Veichle default health value'},{[1] = VAL_CrDfltHlth},{[1] = 'number'})
			if (CH == nil and CH[1] == nil) then
				VAL_CrDfltHlth = CH[1]
			end
			CH = nil
			cheat_strongveichle()
		end
		if CH == 8 then
			CH,revert['CarHealth'] = nil,nil
			cheat_strongveichle()
		end
		if CH == 9 then
			CH,MemoryBuffer['CarHealth'] = nil,nil
			cheat_strongveichle()
		end		
 -- Main carhealth code
		if CAR_HEALTH_VALUE ~= nil then
	 -- Set ranges
			gg.setRanges(gg.REGION_CODE_APP)
	 -- Memory buffer
			if MemoryBuffer['CarHealth'] == nil then
				gg.toast('No buffer found, creating new buffer')
		 -- Find specific value
				gg.searchNumber(VAL_CrDfltHlth, gg.TYPE_DWORD)
		 -- Get float-type-only result, and make a backup.
				MemoryBuffer['CarHealth'],revert['CarHealth'] = gg.getResults(50),gg.getResults(50)
			else
				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(MemoryBuffer['CarHealth'])
			end
	 -- Check if found any result
			if gg.getResultCount() == 0 then
		 -- Set memory buffer and backup
				MemoryBuffer['CarHealth'],revert['CarHealth'] = nil,nil
				gg.toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current health variable' menu")
			else
				for i, v in ipairs(MemoryBuffer['CarHealth']) do
					v.value = CAR_HEALTH_VALUE
				end
		 -- Set current value to, well... current value ofcourse...
				VAL_CrDfltHlth,CAR_HEALTH_VALUE = CAR_HEALTH_VALUE,nil
				gg.toast("Veichles default health "..VAL_CrDfltHlth)
				gg.setValues(MemoryBuffer['CarHealth'])
			end
			gg.clearResults()
		end
		CH = nil
	end
	HOMEDM = -1
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
		"Back"
	}, nil, "No damage\nThis will make you unable to get killed using any explosion blasts (that means you still can get killed by sg,mg,laser,turret,any non explosive weapons)\nPS: this will make your character buggy though")
	if CH ~= nil then
		if CH == 10 then MENU() end
		if CH == 1 then DAMAGE_INTENSITY_VALUE = "0" end
		if CH == 2 then DAMAGE_INTENSITY_VALUE = "300" end
		if CH == 5 then
			local CH = gg.prompt({'Input your custom damage intensity'})
			if (CH == nil and CH[1] == nil) then
				cheat_noblastdamage()
			else
				DAMAGE_INTENSITY_VALUE,CH = CH[1],nil
			end
		end
		---
		if CH == 7 then
			local CH = gg.prompt({'If you think the current Damage intensity is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current Damage intensity'},{[1] = VAL_DmgIntnsty},{[1] = 'number'})
			if (CH == nil and CH[1] == nil) then
				VAL_DmgIntnsty = CH[1]
			end
			CH = nil
			cheat_noblastdamage()
		end
		if CH == 8 then
			CH,revert['NoBlastDamage'] = nil,nil
			cheat_noblastdamage()
		end
		if CH == 9 then
			CH,MemoryBuffer['NoBlastDamage'] = nil,nil
			cheat_noblastdamage()
		end		
 -- Main NoBlastDamage code
		if DAMAGE_INTENSITY_VALUE ~= nil then
	 -- Set ranges
			gg.setRanges(gg.REGION_CODE_APP)
	 -- Memory buffer
			if MemoryBuffer['NoBlastDamage'] == nil then
				gg.toast('No buffer found, creating new buffer')
		 -- Find specific value
				gg.searchNumber(VAL_DmgIntnsty, gg.TYPE_FLOAT)
		 -- Get float-type-only result, and make a backup.
				MemoryBuffer['NoBlastDamage'],revert['NoBlastDamage'] = gg.getResults(10),gg.getResults(10)
			else
				gg.toast('Previous result found, using previous result.\nif it fails, clear the buffer using "clear buffer" option')
				gg.loadResults(MemoryBuffer['NoBlastDamage'])
			end
	 -- Check if found any result
			if gg.getResultCount() == 0 then
		 -- Set memory buffer and backup
				MemoryBuffer['NoBlastDamage'],revert['NoBlastDamage'] = nil,nil
				gg.toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current damage value' menu")
			else
				for i, v in ipairs(MemoryBuffer['NoBlastDamage']) do
					v.value = DAMAGE_INTENSITY_VALUE
				end
		 -- Set current value to, well... current value ofcourse...
				VAL_DmgIntnsty,DAMAGE_INTENSITY_VALUE = DAMAGE_INTENSITY_VALUE,nil
				gg.toast("Blast damage intensity "..VAL_DmgIntnsty)
				gg.setValues(MemoryBuffer['NoBlastDamage'])
			end
			gg.clearResults()
		end
		CH = nil
	end
	HOMEDM = -1
end

function cheat_destroycar()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Destroy cars")
	if CH ~= nil then
		if CH == 3 then
			MENU()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		if CH == 1 then
			gg.searchNumber("0.89868283272;0.91149836779;0.92426908016;0.93699574471;0.9496794343;0.9623208046;0.97492086887;0.98748034239;1.0;1.01248061657;1.02492284775;1.03732740879;1.04969501495;1.06202638149;1.07432198524;1.08658242226;1.09880852699;1.11100065708;1.12315940857;1.1352853775;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
			gg.refineNumber("1.0")
			gg.getResults(50)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("-500", gg.TYPE_FLOAT)
				gg.toast("Destroy all cars ON")
			end
		end
		if CH == 2 then
			gg.searchNumber("0.89868283272;-500.0;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
			gg.refineNumber("-500")
			gg.getResults(50)
			if gg.getResultCount() == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("1.0", gg.TYPE_FLOAT)
				gg.toast("Destroy all cars OFF")
			end
		end
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end

function cheat_togglevoidmode()
	gg.toast('This option will set mode, time limit, vehicle, and ai difficulty to 99, which voids them')
--Prepare the table
	local t = {}
	t[1] = {}
	t[2] = {}
	t[3] = {}
	t[4] = {}
	t[5] = {}
	t[1].flags = gg.TYPE_DWORD
	t[2].flags = gg.TYPE_DWORD
	t[3].flags = gg.TYPE_DWORD
	t[4].flags = gg.TYPE_DWORD
	t[5].flags = gg.TYPE_DWORD
	t[1].value = 99
	t[2].value = 99
	t[3].value = 99
	t[4].value = 99
	t[5].value = 99
--Mode - Singleplayer
	t[1].address = 0xC20FC36C
--Mode - Multiplayer
	t[2].address = 0xC1EBB47C
--AI Difficulty
	t[3].address = 0xC20FC3A0
--Cops intensity
	t[4].address = 0xC20FC38C
--Time limit
	t[5].address = 0xC132A8B8
	gg.setValues(t)
	gg.toast('void mode has been set. to restore back, simply change to any mode you desire')
	HOMEDM = -1
end

function cheat_togglenoreload_exp()
-- This mostly fake, Why?
-- because on old version, this points to Cb (C++ .BSS). which all of us know, (on latest version of PB2/GG) this memory address points to nothing (the game didnt use this. not even near that address).
-- Prepare the table
-- its. a. prank, yep... coz i tried with old version and STILL wont work, nothing even found
--local t = {}
--t[1] = {}
--t[1].address = 0xBA26C5D4
--t[1].flags = gg.TYPE_DWORD
--t[1].value = 555
--t[1].freeze = true
--gg.setValues(t)
--gg.toast('this will change BA26C5D4:Word 0 to 500:Freeze\nNo reload ON')
	gg.setRanges(gg.REGION_OTHER)
	local stp = gg.prompt({
		'Put your weapon ammo\n(works best for rocket, because this affects rocket only)\nResets after respawn',
		'Put your new weapon ammo'
	})
	gg.searchNumber(stp[1],gg.TYPE_WORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local t = gg.refineNumber(stp[2], gg.TYPE_WORD)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
		for i, v in ipairs(t) do
			v[i].value = 1
			v[i].freeze = true
		end
		gg.setValues(t)
		gg.clearResults()
		gg.toast('No reload ON')
	end
	HOMEDM = -1
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
	},{
		[1]="number",
		[2]="number",
		[3]="checkbox"
	})
	if CH ~= nil then
 -- Search current player xp
		gg.searchNumber(player_xp[1], gg.TYPE_DWORD)
		t,revert['PlayerXP'] = gg.getResults(10),gg.getResults(10)
 -- Check if found or not
		if gg.getResultCount() == 0 then
			gg.toast('Can\'t find the player xp, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
		else
	 -- and put the new XP
			for i, v in ipairs(t) do
				v[i].value = player_xp[2]
				v[i].freeze = player_xp[3]
			end
			gg.setValues(t)
			gg.clearResults()
			gg.toast('"'..player_xp[1]..'" changed to "'..player_xp[2]..'"\nWarn: this is still in experimentation phase, the xp wont applied permanently, it will get reset to original. to chnage it permanently, you have to modify the .sav data, which is impossible because its encrypted')
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
		[2]=cfg['PlayerCustomName']
	},{
		[1]="number",
		[2]="number"
	})
--search old player name
	gg.searchNumber(player_name[1], gg.TYPE_BYTE)
	revert['PlayerName'] = gg.getResults(5555)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
		gg.editAll(player_name[2], gg.TYPE_BYTE)
		VAL_PlayerCurrentName = player_name[2]
		gg.clearResults()
		gg.toast('"'..player_name[1]..'" changed to "'..player_name[2]..'"\nWarn: this is still in experimentation phase, the name might only apply on your client and not others')
	end
end

function cheat_changeplayernamecolor()
	gg.setRanges(gg.REGION_OTHER)
--request user to give player name
	local CH,player_name,player_color_choice = gg.choice({
		"Color:",
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
		"None (default)",
		"---",
		"Back"
	},nil,"Select the color you want (Experimental)"),gg.prompt({'Put your current player name (case-sensitive)'},{VAL_PlayerCurrentName},{'number'})
	if (CH ~= nil or player_name ~= nil) then
	--Color
		if CH == 2 then player_color_choice = 2 end
		if CH == 3 then player_color_choice = 3 end
		if CH == 4 then player_color_choice = 4 end
		if CH == 5 then player_color_choice = 5 end
		if CH == 6 then player_color_choice = 6 end
	---
	--Icon
		if CH == 9 then player_color_choice = 7 end
		if CH == 10 then player_color_choice = 8 end
		if CH == 11 then player_color_choice = 10 end
	---
		if CH == 13 then player_color_choice = 0 end
	---
		if CH == 15 then MENU() end

		if player_color_choice ~= nil then

		--search old player name
			gg.searchNumber(player_name[1], gg.TYPE_BYTE)
			local t,tmp0 = gg.getResults(5555)
			revert['PlayerName'] = gg.getResults(5555)
		--generic found stuff
			if gg.getResultCount() == 0 then
				gg.toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
			else
				if player_color_choice ~= 0 then
				--this is where the problem arises, will this vvv work? probably not, mostly.
				--1. shift all addreses
					for i, v in ipairs(t) do
						tmp0 = v[i].address
						v[i].address = tmp0 + 0x1
						v[i].freeze = false
						v[1].flags = gg.TYPE_BYTE
					end
				--2. add value whatever
					table.insert(t,1,{})
				--t[1].address = t[2].address - 0x1
					t[1].freeze = false
					t[1].flags = gg.TYPE_BYTE
					t[1].value = player_color_choice
				else
					for i, v in ipairs(t) do
					--if within the custom color/icon range
						if (t[i].value > 0 and t[i].value < 20) then
						--nil it
							t[i] = nil
						else
						--and -1 for the rest
							tmp0 = v[i].address
							v[i].address = tmp0 - 0x1
							v[i].freeze = false
							v[i].flags = gg.TYPE_BYTE
						end
					end
				end
				gg.setValues(t)
				gg.toast('Color set to '..player_color_choice..'. PS: still in experimental phase, might not work')
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
		"Back"
	}, nil, "Walk Wonkyness (fancy-cheat)")
	if CH ~= nil then
		if CH == 5 then MENU() end
		gg.setRanges(gg.REGION_CODE_APP)
		if CH == 1 then
			gg.searchNumber("0~1", gg.TYPE_FLOAT)
			revert['walkwonkyness'] = gg.getResults(10)
			gg.editAll("0.004", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness Default")
		end
		if CH == 2 then
			gg.searchNumber("0.004", gg.TYPE_FLOAT)
			revert['walkwonkyness'] = gg.getResults(10)
			gg.editAll("1", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness ON")
		end
		if CH == 3 then
			gg.searchNumber("1", gg.TYPE_FLOAT)
			revert['walkwonkyness'] = gg.getResults(10)
			gg.editAll("0.004", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness OFF")
		end
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end

function cheat_coloredtree()
	local tmp0,CH = {}, gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Colored trees\nThis will change some shader stuff (actually idk wut this does lol) that affects trees")
	if CH ~= nil then
		if CH == 3 then MENU() end
		if CH == 1 then tmp0[1] = "0.04" tmp0[2] = "-999" tmp0[3] = "ON" end
		if CH == 2 then tmp0[1] = "-999" tmp0[2] = "0.04" tmp0[3] = "OFF" end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp0[1], gg.TYPE_FLOAT)
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp0[2], gg.TYPE_FLOAT)
			gg.clearResults()
			gg.toast("Colored trees "..tmp0[3])
		end
		tmp0 = nil
	end
	HOMEDM = -1
end

function cheat_bigflamethroweritem()
	local tmp0,CH = {}, gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Big flamethrower (Item)\nInfo: this will not make the flame burst bigger")
	if CH ~= nil then
		if CH == 3 then MENU() end
		if CH == 1 then tmp0[1] = "0.9" tmp0[2] = "999" tmp0[3] = "ON" end
		if CH == 2 then tmp0[1] = "999" tmp0[2] = "0.9" tmp0[3] = "OFF" end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp0[1], gg.TYPE_FLOAT)
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp0[2], gg.TYPE_FLOAT)
			gg.clearResults()
			gg.toast("Big flamethrower "..tmp0[3])
		end
		tmp0 = nil
	end
	HOMEDM = -1
end

function cheat_shadowfx()
	local tmp0,CH = {}, gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Shadow effects\nInfo: this wont affect your game performance at all (not making it lag/fast)\ndont use this for performance purpose :)")
	if CH ~= nil then
		if CH == 3 then MENU() end
		if CH == 1 then tmp0[1] = "0.0001" tmp0[2] = "-1.0012" tmp0[3] = "Disabled" end
		if CH == 2 then tmp0[1] = "-1.0012" tmp0[2] = "0.0001" tmp0[3] = "Enabled" end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp0[1], gg.TYPE_FLOAT)
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp0[2], gg.TYPE_FLOAT)
			gg.clearResults()
			gg.toast("Shadow "..tmp0[3])
		end
		tmp0 = nil
	end
	HOMEDM = -1
end

function cheat_clrdpplesp()
	local tmp0,CH = {}, gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Colored people ESP (idk wut esp mean here)")
	if CH ~= nil then
		if CH == 3 then MENU() end
		if CH == 1 then tmp0[1] = "0.08" tmp0[2] = "436" tmp0[3] = "ON" end
		if CH == 2 then tmp0[1] = "436" tmp0[2] = "0.08" tmp0[3] = "OFF" end
	--gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS
		gg.setRanges(gg.REGION_CODE_APP)
		gg.searchNumber(tmp0[1], gg.TYPE_FLOAT)
		local t = gg.getResults(100)
		if gg.getResultCount() == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my GitHub page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			gg.editAll(tmp0[2], gg.TYPE_FLOAT)
			gg.clearResults()
			gg.toast("Colored people ESP "..tmp0[3])
		end
		tmp0 = nil
	end
	HOMEDM = -1
end

function cheat_deleteingameplaytext()
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
	gg.searchNumber(":Toasted", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":Wasted", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":Nuked", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":Drowned", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":OBLITERATED", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":Your team won", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":You scored", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":You finished", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":You team scored", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":DEFEND", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":STEAL", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":BASE", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":SPLATTERED", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":DELIVER", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":DOMINATE", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":CAPTURE", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.searchNumber(":KILL", gg.TYPE_BYTE) gg.getResults(100) gg.editAll(":", gg.TYPE_BYTE)
	gg.clearResults()
	gg.toast("In-gameplay-text cleared, to restore, you have to restart the game")
	HOMEDM = -1
end


function cheat2_givegrenade()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put grenade current ammo','Put new grenade ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the specific set of number, i recommend using "Weapon ammo" menu, since it will work for latest version')
	else
		local t = {}
		t[1] = {}
		t[1].address = v[1].address + 0x4
		t[1].flags = gg.TYPE_FLOAT
		t[1].value = 1
		gg.setValues(t)
		gg.clearResults()
		gg.toast('Grenade ammo ON')
	end
	HOMEDM = -1
end

function cheat2_givebomb()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put Sticky bomb current ammo','Put new Sticky bomb ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the specific set of number, i recommend using "Weapon ammo" menu, since it will work for latest version')
	else
		local t = {}
		t[1] = {}
		t[1].address = v[1].address + 0x8
		t[1].flags = gg.TYPE_FLOAT
		t[1].value = 1
		gg.setValues(t)
		gg.clearResults()
		gg.toast('C4 ammo ON')
	end
	HOMEDM = -1
end

function cheat2_givelaser()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put laser current ammo','Put laser new ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the specific set of number, i recommend using "Weapon ammo" menu, since it will work for latest version')
	else
		local t = {}
		t[1] = {}
		t[1].address = v[1].address + 0xC
		t[1].flags = gg.TYPE_FLOAT
		t[1].value = 1
		gg.setValues(t)
		gg.clearResults()
		gg.toast('Laser ammo ON')
	end
	tmp = nil
	HOMEDM = -1
end

function cheat2_win()
	gg.setRanges(gg.REGION_ANONYMOUS)
	local stp = gg.prompt({'Enter ammo (the original ICE Menu dev told that all ammo can work, this might wrong)','Enter new ammo value'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	if gg.getResultCount() == 0 then
		gg.toast('Can\'t find the specific set of number')
	else
		local t = {}
		t[1] = {}
		t[1].address = v[1].address + 0x14
		t[1].flags = gg.TYPE_FLOAT
		t[1].value = 1
		gg.setValues(t)
		gg.clearResults()
		gg.toast('Level Win ON')
	end
	HOMEDM = -1
end

function show_about()
	local CH = gg.choice({
		"🇺🇸️ English",
		"🇮🇩️ Indonesia",
		"---",
		"Disclaimmer (Please read)",
		"License/Lisensi",
		"Credits/Kredit",
		"Back/Kembali",
	}, nil, "Select your language\nPilih bahasa")
	if CH ~= nil then
		if CH == 1 then gg.alert("Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number, even cheat menu which didnt show any numbers at all). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes") show_about() end
		if CH == 2 then gg.alert("Payback2 CHEATus, dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini?\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak membagikan skrip cheat mereka sama sekali. Tentu ini melanggar filosofi open-source, kita perlu melihat sumber kode untuk memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim (banyak sensor stiker/teks/zoom-in, speedup, apalagi sesuatu yang berkaitan dengan alamat memory, atau ya... nomor apapun, bahkan menu cheat yang tidak menampilkan nomor sama sekali). Bahkan jika ia memberikan tautan unduhan dari satu cheat (hack wall),\nitu masih proprietri, saya tidak dapat membaca sumber kode satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang") show_about() end
		---
		if CH == 4 then gg.alert("DISCLAIMMER/DISKLAIMMER:\nPlease DO NOT misuse the script to abuse other players.\nRemember to keep your patience out of other players.\ni recommend ONLY using this script in offline mode.\nI made this because no one would share their cheat script.\n\nJANGAN menyalahgunakan skrip ini untuk menjahili pemain lain.\nIngat untuk menjaga kesabaran anda dari pemain lain.\nSaya merekomendasikan menggunakan skrip ini HANYA di mode offline.\nSaya membuat ini karena tidak ada orang lain yang membagikan skrip cheat mereka.") show_about() end
		if CH == 5 then gg.alert("Payback2 CHEATus, Cheat LUA Script for GameGuardian\nCopyright (C) 2021-2022 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.	If not, see https://gnu.org/licenses") show_about() end
		if CH == 6 then gg.alert("Credit/Kredit:\n+ Mangyu - Original script\n+ mdp43140 - Contributor\n+ tehtmi - unluac Creator (and decompile helper).\n+ Crystal_Mods100x - ICE Menu\n+ Latic AX and ToxicCoder - for providing removed script through YT & MediaFire.\n+ Alpha GG Hacker - Wall Hack & Car Health GameGuardian Values\n+ GKTV (Pumpkin Hacker) - Payback2 GG script.\n+ Hydra - no thanks for \"no reload cheat\" tutor that doesn't even work.\n+ Joker - No Blast Damage GameGuardian Values.") show_about() end
		if CH == 7 then CH = nil MENU() end
		CH = nil
	end
end

function exit()
	print("If you experienced a bug, report it on my GitHub page:https://github.com/ABJ4403/Payback2_CHEATus/issues\nIf you have something to ask, you can start a discussion at https://github.com/ABJ4403/Payback2_CHEATus/discussions\nIf you want to know more about this cheat, or other FAQ stuff, go to https://github.com/ABJ4403/Payback2_CHEATus/wiki")
	gg.saveVariable(cfg,cfg_file)
	gg.clearResults()
--gg.clearList() -- this will clear your list not recommend though...
	os.exit()
end

-- Initialization
--Configurable values
--for the cfg i recommend running the script, get out, and edit the .conf file (generated in the script location)
cfg = {}
cfg['PlayerCurrentName']=":Player" -- you can change this to your name
cfg['PlayerCustomName']=":CoolFoe" -- you can change this at your likings
VAL_PstlSgKnockback="0.25" -- Don't change this, this is the pistol/sg bullet knockback default value when the game starts, changing this will cause the script to fail, until you restore them manually
VAL_CrDfltHlth="125" -- this is veichles default health
VAL_DmgIntnsty="300" -- this is your default damage intensity
VAL_WallResist={"-500","-1.00001","-1"} -- same as two above but have multiple methods, thats why its put to tables (i better call it array, btw)
VAL_BigBody={"3","5.9"}
--Number Offsets, don't change or the memory search thingy will miss
SPECIALOFFSET_bigbody={"0.09500002861","0.00000019073"}
--Load settings
cfg_file = gg.getFile()..'.conf'
local cfg_load = loadfile(cfg_file)
if cfg_load ~= nil then
	cfg = cfg_load()
end
VAL_PlayerCurrentName = cfg['PlayerCurrentName']
--bunch of global variables
revert = {}
MemoryBuffer = {}
--not used yet TODO: Add translation
DEFAULT_LANGUAGE="en"
VERSION="1.8.0"
--memory cleanup
collectgarbage("collect")
--loop to open the menu if gg menu is visible (aka. pressing floating gg icon)
while true do
--open home if gg icon is clicked (aka. if its visible, hide the gg menu and show our menu)
	if gg.isVisible() then
		gg.setVisible(false)
		HOMEDM = 1
	end
	if HOMEDM == 1 then
		MENU()
	end
end
