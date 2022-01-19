function MENU()
	local CH = gg.choice({
		"1. Pistol/SG Knockback",
		"2. Weapon ammo",
		"3. Wall Hack",
		"4. Toggle void mode (not work for now due to memory address issue)",
		"---",
		"Other cheats:",
		"5. Client-side cosmetics",
		"6. Incompatible cheats",
		"---",
		"About/Tentang",
		"Exit/Keluar",
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
	if CH == 1 then cheat_pistolknockback() end
	if CH == 2 then cheat_weaponammo() end
	if CH == 3 then cheat_togglewallhack() end
	if CH == 4 then cheat_togglevoidmode() end
---
--Title:Othercheat..
	if CH == 7 then MENU_CSD() end
	if CH == 8 then MENU_incompat() end
---
	if CH == 10 then show_about() end
	if CH == 11 then exit() end
	HOMEDM = -1
end

function MENU_CSD()
	local CH = gg.choice({
		"Client-side cosmetics",
		"These cheats won't affect your actual gameplay, its more of a fancy stuff",
		"1. Walk animation Wonkyness (client-side only)",
		"2. Change Name (EXPERIMENTAL)",
		"3. Change Name Color (EXPERIMENTAL)",
		"4. Burning body", -- is this considered cosmetic, kinda not though, because it makes you unkillable too, but incompat lol
		"5. Big body",
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
---
	if CH == 9 then MENU() end
	HOMEDM = -1
end

function MENU_incompat()
	local CH = gg.choice({
		"Incompatible cheats (below PB2 v2.104.12.4/GG v101.0)",
		"These cheats isn't compatible with the latest version of PB2. searching these will result in values not found, especially those that aren't located in: (JavaHeap, CAlloc, Annonymous, Other, CodeApp)",
		"1. Weapon",
		"2. Destroy all cars",
		"3. Give Grenades (From ICE Menu)",
		"4. Give C4s (From ICE Menu)",
		"5. Give Laser (From ICE Menu)",
		"6. Win Level (From ICE Menu)",
		"7. No reload (From Hydra and other yt channel i forgot...)",
		"---",
		"Back/Kembali"
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
--Title:CSD...
--Title:This menu...
	if CH == 3 then cheat_weapon() end
	if CH == 4 then cheat_destroycar() end
	if CH == 5 then cheat_givegrenade() end
	if CH == 6 then cheat_givebomb() end
	if CH == 7 then cheat_givelaser() end
	if CH == 8 then cheat_win() end
	if CH == 9 then cheat_togglenoreload_exp() end
---
	if CH == 11 then MENU() end
	HOMEDM = -1
end
--[[
  A little note before looking at the cheat mechanics:
  On newer version of the game, now it stores data mostly on OTHER region (with the rest of the data stored in JavaHeap?, Calloc, Annonymous, and CodeApp), not Ca,Ch,Jh,A
  And also the previous value that is fail when tested, will fail even if you change memory region and still use same value
]]

function cheat_weapon()
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
	gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61", gg.TYPE_DWORD)
	local t,found = gg.getResults(5000, nil, nil, nil, nil, nil, gg.TYPE_DWORD),gg.getResultCount()
	if found == 0 then
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		for i, v in ipairs(t) do
			v.value = 71131136
			v.freeze = true
		end
		gg.addListItems(t)
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
	if CH == nil then else
		if CH == 3 then
			MENU()
		end
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
			if WEAPON_AMMO_AMOUNT == nil then else
				gg.searchNumber(WEAPON_AMMO_AMOUNT[1], gg.TYPE_DWORD) -- TODO: Search only in 0xC22743C4-0x6FBEA7A4 range
				gg.getResults(16)
				local found = gg.getResultCount()
				if found == 0 then
					gg.toast("Can't find the said number, did you put the right number?")
				else
					gg.editAll(9999, gg.TYPE_DWORD)
					gg.toast("Now respawn yourself (Pause,end,respawn,yes), to get the desired number")
				end
			end
		end
		if CH == 3 then -- Fallback v2 method (requires manually putting values, but will search WORD instead of DWORD, )
			local WEAPON_AMMO_AMOUNT = gg.prompt({'Put one of your weapon ammo','Freeze'},{},{[2]="checkbox"})
			if WEAPON_AMMO_AMOUNT == nil then else
				gg.searchNumber(WEAPON_AMMO_AMOUNT[1], gg.TYPE_DWORD) -- TODO: Search only in 0xC22743C4-0x6FBEA7A4 range
				gg.getResults(16)
				local found = gg.getResultCount()
				if found == 0 then
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
	local CH,bruh,hurb = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Burning body")
	if CH == nil then else
		if CH == 3 then MENU() end
		if CH == 1 then bruh = "9999" hurb = "ON" end
		if CH == 2 then bruh = "0" hurb = "OFF" end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber("1.68155816e-43F;0D~9999D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45", gg.TYPE_DWORD)
		local t,found = gg.getResults(555, nil, nil, nil, nil, nil, gg.TYPE_DWORD),gg.getResultCount()
		if found == 0 then
			gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
		else
			for i, v in ipairs(t) do
				v.value = bruh
				v.freeze = true
			end
			gg.addListItems(t)
			gg.setValues(t)
			gg.clearResults()
			gg.toast("Burning body "..hurb)
		end
		bruh = nil
		hurb = nil
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
		"Back"
	}, nil, "Pistol/Shotgun knockback modifier\nCurrent: "..VAL_PstlSgKnockback.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH == nil then else
		if CH == 8 then
			MENU()
		end
		if CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = VAL_PstlSgKnockback},{[1] = 'number'})
			if CH[1] == nil then else
				VAL_PstlSgKnockback = CH[1]
			end
			CH = nil
			cheat_pistolknockback()
		end
		if CH == 1 then PISTOL_KNOCKBACK_VALUE = "-20" end
		if CH == 2 then PISTOL_KNOCKBACK_VALUE = "20" end
		if CH == 3 then PISTOL_KNOCKBACK_VALUE = "0.25" end
		if CH == 4 then PISTOL_KNOCKBACK_VALUE = "0" end
		if CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if CH[1] == nil then
				cheat_pistolknockback()
			else
				PISTOL_KNOCKBACK_VALUE = CH[1]
			end
		end
		if PISTOL_KNOCKBACK_VALUE == nil then else
	 -- Set range
			gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	 -- Find specific value
			gg.searchNumber(VAL_PstlSgKnockback.."F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
	 -- Get float type only result and Check if found any result
			local t,found = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_FLOAT),gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i, v in ipairs(t) do
					v.value = PISTOL_KNOCKBACK_VALUE
				end
				VAL_PstlSgKnockback = PISTOL_KNOCKBACK_VALUE
				PISTOL_KNOCKBACK_VALUE = nil
				gg.toast("Pistol/SG Knockback "..VAL_PstlSgKnockback)
				gg.setValues(t)
			end
			gg.clearResults()
			CH = nil
		end
	end
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
	if CH == nil then else
		if CH == 3 then
			MENU()
		end
		local t,found
		if CH == 1 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber("1"+SPECIALOFFSET_bigbody[1], gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert_bigbody = gg.getResults(555)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = VAL_BigBody[1]+SPECIALOFFSET_bigbody[1]
					v.freeze = true
				end
				gg.toast("Big Body ON")
			end
			gg.addListItems(t)
			gg.setValues(t)
		end
		if CH == 2 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber("4.3"+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert = gg.getResults(22)
			revert_bigbody = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(VAL_BigBody[2]+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
				gg.toast("Big Body ON")
			end
		end
		if CH == 3 then
			gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
			gg.searchNumber(VAL_BigBody[1]+SPECIALOFFSET_bigbody[1], gg.TYPE_FLOAT)
			t = gg.getResults(555)
			revert_bigbody = gg.getResults(555)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = "1"+SPECIALOFFSET_bigbody[1]
					v.freeze = true
				end
				gg.toast("Big body OFF")
			end
			gg.addListItems(t)
			gg.setValues(t)
		end
		if CH == 4 then
			gg.setRanges(gg.REGION_CODE_APP)
			gg.searchNumber(VAL_BigBody[2]+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
			t = gg.getResults(22)
			revert_bigbody = gg.getResults(22)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("4.3"+SPECIALOFFSET_bigbody[2], gg.TYPE_FLOAT)
				gg.toast("Big body OFF")
			end
		end
		if CH == 5 then
			if revert_bigbody == nil then
				gg.toast("No values to restore, this might be a bug. if you think so, report bug on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.setValues(revert_bigbody)
				revert_bigbody = nil
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
			if CH == nil then else
				if CH[1] == "" then else VAL_BigBody[1] = CH[1] end
				if CH[2] == "" then else VAL_BigBody[2] = CH[2] end
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

function cheat_destroycar()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Destroy cars")
	if CH == nil then else
		if CH == 3 then
			MENU()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		local found
		if CH == 1 then
			gg.searchNumber("0.89868283272;0.91149836779;0.92426908016;0.93699574471;0.9496794343;0.9623208046;0.97492086887;0.98748034239;1.0;1.01248061657;1.02492284775;1.03732740879;1.04969501495;1.06202638149;1.07432198524;1.08658242226;1.09880852699;1.11100065708;1.12315940857;1.1352853775;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
			gg.refineNumber("1.0")
			gg.getResults(50)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("-500", gg.TYPE_FLOAT)
				gg.toast("Destroy all cars ON")
			end
		end
		if CH == 2 then
			gg.searchNumber("0.89868283272;-500.0;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
			gg.refineNumber("-500")
			gg.getResults(50)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
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

function cheat_togglewallhack()
	local CH = gg.choice({
		"ON (Default, physics works best. need to reapplied every match, takes some time)",
		"ON (Alternative, wonky physics. but fast to enable, and survives multiple match)",
		"OFF (Alternative)",
		"Restore previous value",
		"Use custom value",
		"Back"
	}, nil, "Wall Hack. Warn:\n- Only use one method at a time\n- some walls have holes behind them\n- Dont use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you do racing\n- Best use cases are for Capture The Swags, especially in Metropolis, because theres less holes there")
	if CH == nil then else
		if CH == 6 then MENU() end
 -- Set ranges
		if CH == 1 then
	 -- This default method is slow, and only survives single match, but physics works best here.
			gg.setRanges(gg.REGION_C_ALLOC)
	 -- Search for specific number
			gg.searchNumber("1140457472D;500F::")
	 -- Restore previous value (mostly this is useful when youre done a match, but it wont be here due to its modifying certain changed areas, which can cause crash, bruh c++ nature)
	 -- Get a result and set a backup just in case...
	 -- Make sure the result isnt nil
			revert_wallhack = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
			local t,found = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD),gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = VAL_WallResist[1] -- Recommended value:-500 - -5000, putting it to 0 will make you drowned lmao
				--v.freeze = true -- actually for the most part its not required, but sometimes the value will increase/decrease a bit closer to value that prevents wall hack, or causes even more bug lol, but if it freezed, c++ runtime cant clear the memory
				end
			--gg.addListItems(t) -- idk wut this does, can we remove this? will this affect stuff?
				gg.setValues(t)
				gg.clearResults()
				gg.toast("Wall hack ON")
			end
		end
		if CH == 2 then
	 -- This altervative method can survive multiple matches, and the value can be found very fast (because it only scans CodeApp), but the physics is wonky
			gg.setRanges(gg.REGION_CODE_APP)
	 -- Search for specific number
			gg.searchNumber("0.001", gg.TYPE_FLOAT)
	 -- Get a result and set a backup just in case...
			revert_wallhack = gg.getResults(20)
	 -- Make sure its there
			local found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll(VAL_WallResist[2], gg.TYPE_FLOAT)
				gg.clearResults()
				gg.toast("Wall Hack ON")
			end
		end
		if CH == 3 then
			gg.setRanges(gg.REGION_CODE_APP)
	 -- Search for specific number
			gg.searchNumber(VAL_WallResist[2], gg.TYPE_FLOAT)
	 -- Get a result and set a backup just in case...
			revert_wallhack = gg.getResults(20)
	 -- Make sure its there
			local found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("0.001", gg.TYPE_FLOAT)
				gg.clearResults()
				gg.toast("Wall Hack ON")
			end
		end
		if CH == 4 then
			if revert_wallhack == nil then
				gg.toast("No values to restore, this might be a bug. if you think so, report bug on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
		 -- bug:idk, it wot restore lol
				gg.setValues(revert_wallhack)
				revert_wallhack = nil
				gg.clearResults()
				gg.toast("Wall hack previous value restored, be warned though this will cause instability")
			end
		end
		if CH == 5 then
			local CH = gg.prompt({
				'Put your custom value for Default method (Game default:1140457472,Cheatus default:-500)',
				'Put your custom value for Alternative method (Game default:0.001,Cheatus default:-1.00001)'
			},{
				[1] = VAL_WallResist[1],
				[2] = VAL_WallResist[2]
			},{
				[1] = 'number',
				[2] = 'number'
			})
			if CH == nil then else
				if CH[1] == "" then else VAL_WallResist[1] = CH[1] end
				if CH[2] == "" then else VAL_WallResist[2] = CH[2] end
			end
			CH = nil
			cheat_togglewallhack()
		end
	end
	HOMEDM = -1
end

function cheat_togglenoreload_exp()
	local CH = gg.choice({
		"Automatic (Hydra method, Won't work or for old versions)",
		"Fallback (Default, can cause instability)",
		"Back"
	}, nil, "Select method for applying no reload values - No Reload")
	if CH == nil then else
		if CH == 3 then
			MENU()
		end
		if CH == 1 then
	 -- This mostly fake, Why?
	 -- because (on latest version of PB2/GG) this memory address points to nothing (the game didnt use this. not even near that address).
	 -- Prepare the table
			local t = {}
			t[1] = {}
			t[1].address = 0xBA26C5D4
			t[1].flags = gg.TYPE_DWORD
			t[1].value = 555
			t[1].freeze = true
			gg.setValues(t)
			gg.toast('this will change BA26C5D4:Word 0 to 500:Freeze\nNo reload ON')
		end
		if CH == 2 then
			gg.setRanges(gg.REGION_OTHER)
			local stp = gg.prompt({
				'Put your weapon ammo\n(works best for rocket, because this affects rocket only)\nResets after respawn',
				'Put your new weapon ammo'
			})
			gg.searchNumber(stp[1],gg.TYPE_WORD)
			gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
			gg.sleep(10000)
			gg.toast('Timeout, searching for '..stp[2])
			local t,found = gg.refineNumber(stp[2], gg.TYPE_WORD),gg.getResultCount()
			if found == 0 then
				gg.toast('Can\'t find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
			else
				for i, v in ipairs(t) do
					v[i].value = 1
					v[i].freeze = true
				end
				gg.setValues(t)
				gg.clearResults()
				gg.toast('No reload ON')
			end
		end
	end
	HOMEDM = -1
end

function cheat_changeplayername()
--known to be located in other regions (idk...)
	gg.setRanges(gg.REGION_OTHER)
--request user to give player name
	local player_name = gg.prompt({
	  'Put your current player name (case-sensitive)',
	  'Put new player name (cannot be longer than current name, you can change the color by converting to hex and use hex 1-9 for color)'
	},{
	  [1]=":Player",
	  [2]=":CoolFoe"
	},{
	  [1]="number",
	  [2]="number"
	})
--search old player name
	gg.searchNumber(':'..player_name[1], gg.TYPE_BYTE)
--generic found stuff
	if found == 0 then
		gg.toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
	--this is where the problem arises, does this vvv work?
		gg.editAll(':'..player_name[2], gg.TYPE_BYTE)
		gg.toast('"'..player_name[1]..'" changed to "'..player_name[2]..'"\nWarn: this is still in experimentation phase, the name might only apply on your client and not others')
	end
end

function cheat_changeplayernamecolor()
--known to be located in other regions (idk...)
	gg.setRanges(gg.REGION_OTHER)
--request user to give player name
	local player_name,player_color_choice = gg.prompt({'Put your current player name (case-sensitive)'}),gg.choice({
		"None (default)",
		"Black",
		"White",
		"Red",
		"Green",
		"Blue"
	},nil,"Select the color you want")
--search old player name
	gg.searchNumber(':'..player_name[1], gg.TYPE_BYTE)
	v = gg.getResults(100)
	found = gg.getResultCount()
--generic found stuff
	if found == 0 then
		gg.toast('Can\'t find the player name, this cheat is still in experimentation phase. report issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues')
	else
	--this is where the problem arises, will this vvv work? probably not.
		local t = {}
		t[1] = {}
		t[1].address = v[1].address - 0x1
		t[1].flags = gg.TYPE_BYTE
		t[1].value = player_color_choice[1].."h"
		gg.setValues(t)
		gg.toast('Color set to '..player_color_choice[1])
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
	if CH == nil then else
		if CH == 5 then MENU() end
		gg.setRanges(gg.REGION_CODE_APP)
		if CH == 1 then
			gg.searchNumber("0~1", gg.TYPE_FLOAT)
			revert = gg.getResults(10)
			gg.editAll("0.004", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness Default")
		end
		if CH == 2 then
			gg.searchNumber("0.004", gg.TYPE_FLOAT)
			revert = gg.getResults(10)
			gg.editAll("1", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness ON")
		end
		if CH == 3 then
			gg.searchNumber("1", gg.TYPE_FLOAT)
			revert = gg.getResults(10)
			gg.editAll("0.004", gg.TYPE_FLOAT)
			gg.toast("Walk Wonkyness OFF")
		end
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end


function cheat_givegrenade()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put grenade current ammo','Put new grenade ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v,found = gg.refineNumber(stp[2], gg.TYPE_DWORD),gg.getResultCount()
	if found == 0 then
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

function cheat_givebomb()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put Sticky bomb current ammo','Put new Sticky bomb ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v,found = gg.refineNumber(stp[2], gg.TYPE_DWORD),gg.getResultCount()
	if found == 0 then
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

function cheat_givelaser()
	gg.setRanges(gg.REGION_C_BSS)
	local stp = gg.prompt({'Put laser current ammo','Put laser new ammo'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v,found = gg.refineNumber(stp[2], gg.TYPE_DWORD),gg.getResultCount()
	if found == 0 then
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

function cheat_win()
	gg.setRanges(gg.REGION_ANONYMOUS)
	local stp = gg.prompt({'Enter ammo (the original ICE Menu dev told that all ammo can work, this might wrong)','Enter new ammo value'})
	gg.toast('Don\'t change the ammo just yet')
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	gg.toast('Timeout, searching for '..stp[2])
	local v,found = gg.refineNumber(stp[2], gg.TYPE_DWORD),gg.getResultCount()
	if found == 0 then
		gg.toast('Can\'t find the specific set of number, i recommend using "Weapon ammo" menu, since it will work for latest version')
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
		"License/Lisensi",
		"Credits/Kredit",
		"Back/Kembali",
	}, nil, "Select your language\nPilih bahasa")
	if CH == nil then else
		if CH == 1 then gg.alert("Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number, even cheat menu which didnt show any numbers at all). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes") show_about() end
		if CH == 2 then gg.alert("Payback2 CHEATus, dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini?\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak membagikan skrip cheat mereka sama sekali. Tentu ini melanggar filosofi open-source, kita perlu melihat sumber kode untuk memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim (banyak sensor stiker/teks/zoom-in, speedup, apalagi sesuatu yang berkaitan dengan alamat memory, atau ya... nomor apapun, bahkan menu cheat yang tidak menampilkan nomor sama sekali). Bahkan jika ia memberikan tautan unduhan dari satu cheat (hack wall),\nitu masih proprietri, saya tidak dapat membaca sumber kode satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang") show_about() end
		---
		if CH == 4 then gg.alert("Payback2 CHEATus, Cheat LUA Script for GameGuardian\nCopyright (C) 2021-2022 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see https://gnu.org/licenses") show_about() end
		if CH == 5 then gg.alert("Credit/Kredit:\n+ Mangyu - Original script\n+ mdp43140 - Contributor\n+ ToxicMods - ICE Menu\n+ Latic AX and ToxicCoder - for providing removed script through YT & MediaFire.\n+ Alpha GG Hacker YT - Wall Hack GameGuardian Values") show_about() end
		if CH == 6 then CH = nil MENU() end
		CH = nil
	end
end

function exit()
	gg.clearList()
	os.exit()
end

-- Initialization
--for pistol grapple
--Configurable values
VAL_PstlSgKnockback="0.25" -- Don't change this, this is the pistol/sg bullet knockback default value when the game starts, changing this will cause the script to fail, until you restore them manually
VAL_WallResist={}
VAL_WallResist[1]="-500"
VAL_WallResist[2]="-1.00001"
VAL_BigBody={}
VAL_BigBody[1]="3"
VAL_BigBody[2]="5.9"
--Number Offsets, don't change or the memory search thingy will miss
SPECIALOFFSET_bigbody={}
SPECIALOFFSET_bigbody[1]="0.09500002861"
SPECIALOFFSET_bigbody[2]="0.00000019073"
--not used yet TODO: Add translation
DEFAULT_LANGUAGE="en"
VERSION="1.5.3"
--loop
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

