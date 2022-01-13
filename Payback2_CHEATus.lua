function HOME()
	local CH = gg.choice({
		"Works on PB2 2.104.12.4/GG 101.0:",
		"1. Pistol/Shotgun Knockback cheat",
		"2. Weapon ammo",
		"3. Toggle void mode (not work for now due to memory address issue)",
		"4. Wall Hack",
		"---",
		"Not work on PB2 2.104.12.4/GG 101.0:",
		"5. Weapon",
		"6. Burning body",
		"7. Big body",
		"8. Destroy all cars",
		"9. Give Grenades (From ICE Menu, wont work)",
		"10. Give C4s (From ICE Menu, wont work)",
		"11. Give Laser (From ICE Menu, wont work)",
		"12. Win Level (From ICE Menu, wont work)",
		"13. No reload (Source from Hydra, may not work)",
		"---",
		"About/Tentang",
		"Exit/Keluar"
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
--Title:Works on PB2...
	if CH == 2 then cheat_pistolknockback_multichoice() end
	if CH == 3 then cheat_weaponammo() end
	if CH == 4 then cheat_togglevoidmode() end
	if CH == 5 then cheat_togglewallhack() end
---
--Title:Not work on PB2...
	if CH == 8 then cheat_weapon_on() end
	if CH == 9 then cheat_firebody_on() end
	if CH == 10 then cheat_bigbody_togglechoice() end
	if CH == 11 then cheat_destroycar_togglechoice() end
	if CH == 12 then cheat_givegrenade() end
	if CH == 13 then cheat_givebomb() end
	if CH == 14 then cheat_givelaser() end
	if CH == 15 then cheat_win() end
	if CH == 16 then cheat_togglenoreload_exp() end
---
	if CH == 18 then show_about() end
	if CH == 19 then exit() end
	HOMEDM = -1
end

function cheat_weapon_on()
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
	gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61", gg.TYPE_DWORD)
	local t = gg.getResults(5000, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
	local found = gg.getResultCount()
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
		"Fallback (Default)",
		"Back"
	}, nil, "Select method for modifying weapon amount - Modify Weapon Amount\nPS: not tested for multiplayer (while the gameplay running), might not work.")
	if CH == nil then else
		if CH == 3 then
			HOME()
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
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end

function cheat_firebody_on()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Burning body")
	local bruh
	local hurb
	if CH == nil then else
		if CH == 3 then HOME() end
		if CH == 1 then bruh = "9999" hurb = "ON" end
		if CH == 2 then bruh = "0" hurb = "OFF" end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		gg.searchNumber("1.68155816e-43F;0D~9999D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45", gg.TYPE_DWORD)
		local t = gg.getResults(555, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
		local found = gg.getResultCount()
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

function cheat_pistolknockback_multichoice()
	local CH = gg.choice({
		"Grapple gun/Pull (-20)",
		"Knockback/Push (20)",
		"Default (0.25)",
		"N0ne (WARN: This causes game to lag when pistol bullet get shot)",
		"Custom",
		"---",
		"Change current Knockback variable",
		"Back"
	}, nil, "Pistol/Shotgun knockback modifier\nCurrent: "..GRAPPLE_CURR_VAL.."\nHint: recommended value is -20 to 20 if you use pistol")
 -- Hint: if you want to search these value below in gui, change . to , :)
	if CH == nil then else
		if CH == 8 then
			HOME()
		end
		if CH == 7 then
			local CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = GRAPPLE_CURR_VAL},{[1] = 'number'})
			if CH[1] == nil then else
				GRAPPLE_CURR_VAL = CH[1]
			end
			CH = nil
			cheat_pistolknockback_multichoice()
		end
		if CH == 1 then PISTOL_KNOCKBACK_VALUE = "-20" end
		if CH == 2 then PISTOL_KNOCKBACK_VALUE = "20" end
		if CH == 3 then PISTOL_KNOCKBACK_VALUE = "0.25" end
		if CH == 4 then PISTOL_KNOCKBACK_VALUE = "0" end
		if CH == 5 then
			local CH = gg.prompt({'Input your custom knockback value'})
			if CH[1] == nil then
				cheat_pistolknockback_multichoice()
			else
				PISTOL_KNOCKBACK_VALUE = CH[1]
			end
		end
		if PISTOL_KNOCKBACK_VALUE == nil then else
	 -- Set range
			gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	 -- Find specific value
			gg.searchNumber(GRAPPLE_CURR_VAL.."F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
	 -- Get float type only result
			t = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_FLOAT)
	 -- Check if found any result
			local found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number. if you changed the knockback value and reopened the script, restore the actual current number using 'Change current knockback value' menu")
			else
				for i, v in ipairs(t) do
					v.value = PISTOL_KNOCKBACK_VALUE
				end
				GRAPPLE_CURR_VAL = PISTOL_KNOCKBACK_VALUE
				PISTOL_KNOCKBACK_VALUE = nil
				gg.toast("Pistol Knockback "..GRAPPLE_CURR_VAL)
				gg.setValues(t)
			end
			gg.clearResults()
			CH = nil
		end
	end
	HOMEDM = -1
end

function cheat_bigbody_togglechoice()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Big body")
	if CH == nil then else
		if CH == 3 then
			HOME()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		local t
		local found
		if CH == 1 then
			gg.searchNumber("1.09500002861", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
			t = gg.getResults(555)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					if v.flags == gg.TYPE_FLOAT then
						v.value = "3.333111555"
						v.freeze = true
					end
				end
				gg.toast("Big Body ON")
			end
		end
		if CH == 2 then
			gg.searchNumber("3.333111555", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
			t = gg.getResults(555)
			found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					if v.flags == gg.TYPE_FLOAT then
						v.value = "1.09500002861"
						v.freeze = true
					end
				end
				gg.toast("Big body OFF")
			end
		end
		gg.addListItems(t)
		gg.setValues(t)
		t = nil
		gg.clearResults()
		CH = nil
	end
	HOMEDM = -1
end

function cheat_destroycar_togglechoice()
	local CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Destroy cars")
	if CH == nil then else
		if CH == 3 then
			HOME()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		local found
		if CH == 1 then
			gg.searchNumber("0.89868283272;1.0;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
		--gg.searchNumber("0.89868283272;0.91149836779;0.92426908016;0.93699574471;0.9496794343;0.9623208046;0.97492086887;0.98748034239;1.0;1.01248061657;1.02492284775;1.03732740879;1.04969501495;1.06202638149;1.07432198524;1.08658242226;1.09880852699;1.11100065708;1.12315940857;1.1352853775;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109", gg.TYPE_FLOAT)
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
--Num1 1140457472D;500F
--Type Float,Dword
--GetResult Dword
--Val -5000
--Freeze true
--Range Ch,Ca
--Credit "Alpha GG Hacker YT"
	local CH = gg.choice({
		"ON",
		"Restore previous value",
		"Back"
	}, nil, "Wall Hack\nOnly survives single match, needs to reapplied every rematch\nWarn:\n- Careful, some walls have holes on them, now instead of going on walls, youre going to holes and get drowned lol\n-Don't use Wall Hack if you use Helicopter (if you respawn, the helicopter will sunk down due to less power to pull helicopter up),\n- Don't use Wall Hack if you use Pistol/SG Custom Knockback Cheat\n- Don't use Wall Hack if you doing racing\n- Best use cases are for CTFs (Capture The Flag/Swag)")
	if CH == nil then else
		if CH == 3 then HOME() end
 -- Set ranges
		gg.setRanges(gg.REGION_C_ALLOC)
		if CH == 1 then
	 -- Search for specific number
			gg.searchNumber("1140457472D;500F")
	 -- Restore previous value (mostly this is useful when youre done a match)
			if revert_wallhack == nil then else gg.setValues(revert_wallhack) end
	 -- Get a result and set a backup just in case...
			revert_wallhack = gg.getResults(50)
			local t = gg.getResults(50, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
	 -- Make sure its there
			local found = gg.getResultCount()
			if found == 0 then
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				for i, v in ipairs(t) do
					v.value = "-500" -- Recommended value:-500 - -5000, putting it to 0 will make you drowned lmao
					v.freeze = true -- actually for the most part its not required, but sometimes the value will increase/decrease a bit closer to value that prevents wall hack, or causes even more bug lol
				end
				gg.addListItems(t) -- idk wut this does, can we remove this? will this affect stuff?
				gg.setValues(t)
				gg.clearResults()
				gg.toast("Wall hack ON")
			end
		end
		if CH == 2 then
			if revert_wallhack == nil then
				gg.toast("No values to restore, this might be a bug. if you think so, report bug on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
			 -- Known bug: idk, but it wont restore lol
				gg.setValues(revert_wallhack)
				revert_wallhack = nil
				gg.clearResults()
				gg.toast("Wall hack previous value restored")
			end
		end
	end
	HOMEDM = -1
end

function cheat_togglenoreload_exp()
--This mostly is fake, why?
--because (atleast on latest version of pb2 and gg) this memory address points to nothing, and its read-only.
	gg.toast('this will change BA26C5D4:Word 0 to 500:Freeze\nWarning: this might not work because its for older version or its sourcing from Hydra channel')
--Prepare the table
	local t = {}
	t[1] = {}
	t[1].address = 0xBA26C5D4
	t[1].flags = gg.TYPE_DWORD
	t[1].value = 555
	t[1].freeze = true
	gg.setValues(t)
	HOMEDM = -1
end

function cheat_givegrenade()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("20", gg.TYPE_DWORD)
	gg.alert('Change Ammo to: 16, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("16", gg.TYPE_DWORD)
	local v = gg.getResults(1)
	local found = gg.getResultCount()
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
		gg.toast('Grenade ON')
	end
	HOMEDM = -1
end

function cheat_givebomb()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("16", gg.TYPE_DWORD)
	gg.alert('Change value to: 10, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("10", gg.TYPE_DWORD)
	local v = gg.getResults(1)
	local found = gg.getResultCount()
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
		gg.toast('C4 ON')
	end
	HOMEDM = -1
end

function cheat_givelaser()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("10", gg.TYPE_DWORD)
	gg.alert('Change to 6 in 10secs')
	gg.sleep(10000)
	gg.refineNumber("6", gg.TYPE_DWORD)
	local v = gg.getResults(1)
	local found = gg.getResultCount()
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
		gg.toast('Laser ON')
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
	local v = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	local found = gg.getResultCount()
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
		if CH == 6 then CH = nil HOME() end
		CH = nil
	end
end

function exit()
	gg.clearList()
	os.exit()
end

-- Initialization
--for pistol grapple
GRAPPLE_CURR_VAL="0.25" -- Don't change this, this is the pistol/sg bullet knockback default value when the game starts, changing this will cause the script to fail, until you restore them manually
VERSION="1.4.2"
--loop
while true do
--open home if gg icon is clicked (aka. if its visible, hide the gg menu and show our menu)
	if gg.isVisible() then
		gg.setVisible(false)
		HOMEDM = 1
	end
	if HOMEDM == 1 then
		HOME()
	end
end
