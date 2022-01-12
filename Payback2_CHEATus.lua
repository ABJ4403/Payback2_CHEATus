function HOME()
	CH = gg.choice({
		"Not work on PB2 2.104.12.4/GG 101.0:",
		"1. Weapon",
		"2. Burning body",
		"3. Big body",
		"4. Destroy all cars",
		"5. Give Grenades (From ICE Menu, wont work)",
		"6. Give C4s (From ICE Menu, wont work)",
		"7. Give Laser (From ICE Menu, wont work)",
		"8. Win Level (From ICE Menu, wont work)",
		"---",
		"Works on PB2 2.104.12.4/GG 101.0:",
		"9. Pistol/Shotgun Knockback cheat",
		"10. Weapon ammo",
		"11. Toggle void mode (not work for now due to memory address issue)",
		"---",
		"About/Tentang",
		"Exit/Keluar"
	}, nil, "Payback2 CHEATus v"..VERSION..", by ABJ4403.")
--Title:Not work on PB2...
	if CH == 2 then cheat_weapon_on() end
	if CH == 3 then cheat_firebody_on() end
	if CH == 4 then cheat_bigbody_togglechoice() end
	if CH == 5 then cheat_destroycar_togglechoice() end
	if CH == 6 then cheat_givegrenade() end
	if CH == 7 then cheat_givebomb() end
	if CH == 8 then cheat_givelaser() end
	if CH == 9 then cheat_win() end
---
--Title:Works on PB2...
	if CH == 12 then cheat_pistolknockback_multichoice() end
	if CH == 13 then cheat_weaponammo() end
	if CH == 14 then cheat_togglevoidmode() end
---
	if CH == 16 then show_about() end
	if CH == 17 then exit() end
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
	CH = gg.choice({
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
		if CH == 2 then -- Fallback method (requires manually putting values, but can work)
			WEAPON_AMMO_AMOUNT = gg.prompt({'Put all of your weapon ammo, divide each using ";"\neg. 100;200;150;60;45'})
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
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
	gg.searchNumber("1.68155816e-43F;0D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45", gg.TYPE_DWORD)
	local t = gg.getResults(5000, nil, nil, nil, nil, nil, gg.TYPE_DWORD)
	local found = gg.getResultCount()
	if found == 0 then 
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		for i, v in ipairs(t) do
			if v.flags == gg.TYPE_DWORD then
				v.value = 9999
				v.freeze = true
			end
		end
		gg.addListItems(t)
		gg.setValues(t)
		gg.clearResults()
		gg.toast("Burning body ON")
	end
	HOMEDM = -1
end

function cheat_pistolknockback_multichoice()
	CH = gg.choice({
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
			CH = gg.prompt({'If you think the current knockback value is wrong, or get reset due to quiting from script, you can change it here\n\nPut the current pistol/shotgun knockback value'},{[1] = GRAPPLE_CURR_VAL},{[1] = 'number'})
			if CH[1] == nil then else
				GRAPPLE_CURR_VAL = CH[1]
				CH = nil
			end
			cheat_pistolknockback_multichoice()
		end
		if CH == 1 then PISTOL_KNOCKBACK_VALUE = "-20" end
		if CH == 2 then PISTOL_KNOCKBACK_VALUE = "20" end
		if CH == 3 then PISTOL_KNOCKBACK_VALUE = "0.25" end
		if CH == 4 then PISTOL_KNOCKBACK_VALUE = "0" end
		if CH == 5 then
			CH = gg.prompt({'Input your custom knockback value'})
			PISTOL_KNOCKBACK_VALUE = CH[1]
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
	CH = gg.choice({
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
		if CH == 1 then
			gg.searchNumber("1.09500002861", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
			t = gg.getResults(5000)
			local found = gg.getResultCount()
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
			t = gg.getResults(5000)
			local found = gg.getResultCount()
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
	CH = gg.choice({
		"ON",
		"OFF",
		"Back"
	}, nil, "Destroy cars")
	if CH == nil then else
		if CH == 3 then
			HOME()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC)
		if CH == 1 then
			gg.searchNumber("0.89868283272F;0.91149836779F;0.92426908016F;0.93699574471F;0.9496794343F;0.9623208046F;0.97492086887F;0.98748034239F;1.0F;1.01248061657F;1.02492284775F;1.03732740879F;1.04969501495F;1.06202638149F;1.07432198524F;1.08658242226F;1.09880852699F;1.11100065708F;1.12315940857F;1.1352853775F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
			gg.refineNumber("1.0")
			gg.getResults(50)
			local found = gg.getResultCount()
			if found == 0 then 
				gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
			else
				gg.editAll("-500", gg.TYPE_FLOAT)
				gg.toast("Destroy all cars ON")
			end
		end
		if CH == 2 then
			gg.searchNumber("0.89868283272F;-500.0F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL)
			gg.refineNumber("-500")
			gg.getResults(50)
			local found = gg.getResultCount()
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

function cheat_givegrenade()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("20", gg.TYPE_DWORD)
	gg.alert('Change Ammo to: 16, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("16", gg.TYPE_DWORD)
	x = gg.getResults(1)
	local found = gg.getResultCount()
	if found == 0 then 
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		local t = {}
		t[1] = {}
		t[1].address = x[1].address + 0x4
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
	e = gg.getResults(1)
	local found = gg.getResultCount()
	if found == 0 then 
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		local t = {}
		t[1] = {}
		t[1].address = e[1].address + 0x8
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
	gg.alert('Change value to: 6, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("6", gg.TYPE_DWORD)
	local tmp = gg.getResults(1)
	local found = gg.getResultCount()
	if found == 0 then 
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		local t = {}
		t[1] = {}
		t[1].address = tmp[1].address + 0xC
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
	stp = gg.prompt({'Enter ammo','Enter new value'})
	gg.searchNumber(stp[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change ammo value from '..stp[1]..' to '..stp[2])
	gg.sleep(10000)
	sop = gg.refineNumber(stp[2], gg.TYPE_DWORD)
	local found = gg.getResultCount()
	if found == 0 then 
		gg.toast("Can't find the specific set of number, report this issue on my github page: https://github.com/ABJ4403/Payback2_CHEATus/issues")
	else
		local t = {}
		t[1] = {}
		t[1].address = sop[1].address + 0x14
		t[1].flags = gg.TYPE_FLOAT
		t[1].value = 1
		gg.setValues(t)
		gg.clearResults()
		gg.toast('Level Win ON')
	end
	HOMEDM = -1
end

function show_about()
	CH = gg.choice({
		"🇺🇸️ English",
		"🇮🇩️ Indonesia",
		"---",
		"License/Lisensi",
		"Credits/Kredit",
		"Back/Kembali",
	}, nil, "Select your language\nPilih bahasa")
	if CH == nil then else
		if CH == 1 then gg.alert("Payback2 CHEATus, created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this?\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source philosophy, we need to see the source code to make sure its safe and not malware. Just take a look at Hydra YouTube videos for example (Payback gamer name: HYDRAofINDONESIA). he's hiding every technique of cheating, the hiding is SO EXTREME (alot of sticker/text/zoom-censor, speedup, especially something related with memory address/value, or well... any number). even if he gives download link of one cheat (wall-hack),\nits still proprietary, i cant read any single code to make sure its not malware (and also if i look correctly in the code, theres word \"[LOCKED]\" and on the video description which he provides, theres garbled text that says \"7o31kql9p\", which means double-encryption! what the fucking hell dude?! get some mental health!), and also its whopping 200kb! I'm done. This is why the \"Payback2 CHEATus\" project comes") show_about() end
		if CH == 2 then gg.alert("Payback2 CHEATus, dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietri)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLisensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini?\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak membagikan skrip cheat mereka sama sekali. Tentu ini melanggar filosofi open-source (karena saya adalah open-source oriented), kita perlu melihat sumber kode untuk memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim. Bahkan jika ia memberikan tautan unduhan dari satu cheat (hack wall),\nitu masih proprietri, saya tidak dapat membaca sumber kode satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang") show_about() end
		---
		if CH == 4 then gg.alert("Payback2 CHEATus, Cheat LUA Script for GameGuardian\nCopyright (C) 2021-2022 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see https://gnu.org/licenses") show_about() end
		if CH == 5 then gg.alert("Credit/Kredit:\n+ Mangyu - Original script\n+ ToxicMods - ICE Menu\n+ Latic AX and ToxicCoder - for providing removed script through YT & MediaFire.\n+ mdp43140 - Contributor") show_about() end
		if CH == 6 then
			CH = nil
			HOME()
		end
		CH = nil
	end
end

function exit()
	gg.clearList()
	os.exit()
end

-- Initialization
--for pistol grapple
GRAPPLE_CURR_VAL="0.25"
VERSION="1.3.1"
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
