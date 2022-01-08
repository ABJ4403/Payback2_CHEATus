function HOME()
	CH = gg.choice({
		"Not work on PB2 2.104.12.4/GG 101.0):",
		"Weapon",
		"Burning body",
		"Big body",
		"Destroy all cars",
		"Give Grenades (From ICE Menu, wont work)",
		"Give C4s (From ICE Menu, wont work)",
		"Give Laser (From ICE Menu, wont work)",
		"Win Level (From ICE Menu, wont work)",
		"---",
		"Works on PB2 2.104.12.4/GG 101.0):",
		"Pistol/Shotgun Knockback cheat",
		"---",
		"New:",
		"Weapon ammo",
		"Toggle void mode",
		"---",
		"About/Tentang",
		"Exit/Keluar"
	}, nil, "Payback2 CHEATus, by ABJ4403. Check about section for more info")
	if CH == 2 then
		cheat_weapon_on()
	end
	if CH == 3 then
		cheat_firebody_on()
	end
	if CH == 4 then
		cheat_bigbody_togglechoice()
	end
	if CH == 5 then
		cheat_destroycar_togglechoice()
	end
	if CH == 6 then
		cheat_givegrenade()
	end
	if CH == 7 then
		cheat_givebomb()
	end
	if CH == 8 then
		cheat_givelaser()
	end
	if CH == 9 then
		cheat_win()
	end
	if CH == 8 then
		cheat_pistol_multichoice()
	end
	if CH == 15 then
		cheat_weaponammo()
	end
	if CH == 16 then
		cheat_togglevoidmode()
	end
	if CH == 18 then
		show_about()
	end
	if CH == 19 then
		exit()
	end
	HOMEDM = -1
end

function cheat_weapon_on()
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
	local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
	for i, v in ipairs(t) do
		if v.flags == gg.TYPE_DWORD then
			v.value = "71131136"
			v.freeze = true
		end
	end
	gg.addListItems(t)
	t = nil
	gg.clearResults()
	gg.toast("Weapon ON")
end

function cheat_weaponammo()
	CH = gg.choice({
		"Default (automatic)",
		"Fallback",
		"Back"
	}, nil, "Select method for modifying weapon amount - Modify Weapon Amount")
	if CH == 6 then
		HOME()
	end
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
	WEAPON_AMMO_NUM = gg.prompt({'Put your desired value'},{[1] = '9999'},{[1] = 'number'})
	if WEAPON_AMMO_NUM == nil then else
		if CH == 1 then
			local e = {}
	 -- Shotgun
			e[1] = {}
			e[1].address = 0xC22743C4
			e[1].flags = gg.TYPE_DWORD
			e[1].value = WEAPON_AMMO_NUM[1]
	 -- Rocket
			e[2] = {}
			e[2].address = 0xC22743C8
			e[2].flags = gg.TYPE_DWORD
			e[2].value = WEAPON_AMMO_NUM[1]
	 -- Flamethrower
			e[3] = {}
			e[3].address = 0xC22743CC
			e[3].flags = gg.TYPE_DWORD
			e[3].value = WEAPON_AMMO_NUM[1]
	 -- Grenade
			e[4] = {}
			e[4].address = 0xC22743D0
			e[4].flags = gg.TYPE_DWORD
			e[4].value = WEAPON_AMMO_NUM[1]
	 -- Machine Gun
			e[5] = {}
			e[5].address = 0xC22743D4
			e[5].flags = gg.TYPE_DWORD
			e[5].value = WEAPON_AMMO_NUM[1]
	 -- Sticky Bomb (also called Explosives/C4, but i like sticky bomb better, because it sticks... get it XD)
			e[6] = {}
			e[6].address = 0xC22743D8
			e[6].flags = gg.TYPE_DWORD
			e[6].value = WEAPON_AMMO_NUM[1]
	 -- Auto-turrets
			e[7] = {}
			e[7].address = 0xC22743DC
			e[7].flags = gg.TYPE_DWORD
			e[7].value = WEAPON_AMMO_NUM[1]
	 -- Laser
			e[8] = {}
			e[8].address = 0xC22743E0
			e[8].flags = gg.TYPE_DWORD
			e[8].value = WEAPON_AMMO_NUM[1]
			gg.setValues(e)
		end
		if CH == 2 then
			WEAPON_AMMO_AMOUNT = gg.prompt({'Put all of your weapon ammo, divide each using ";"\neg. 100;200;150;60;45'})
			if WEAPON_AMMO_AMOUNT == nil then else
				gg.searchNumber(WEAPON_AMMO_AMOUNT[1], gg.TYPE_DWORD, false, gg.SIGN_EQUAL,0xC22743C4,0x6FBEA7A4)
				revert = gg.getResults(16, nil, nil, nil, nil, nil, nil, nil, nil)
				gg.editAll(WEAPON_AMMO_NUM[1], gg.TYPE_DWORD)
			end
		end
		gg.toast("Now respawn yourself (Pause,end,respawn,yes), to get the desired number")
	--gg.clearResults()
	end
	HOMEDM = -1
end

function cheat_firebody_on()
	gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	gg.searchNumber("1.68155816e-43F;0D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
	local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
	for i, v in ipairs(t) do
		if v.flags == gg.TYPE_DWORD then
			v.value = "9999"
			v.freeze = true
		end
	end
	gg.addListItems(t)
	t = nil
	gg.clearResults()
	gg.toast("Burning body ON")
end

function cheat_pistol_multichoice()
	CH = gg.choice({
		"Grapple gun/Pull (-20)",
		"Knockback/Push (20)",
		"Default (0.25)",
		"None (0)",
		"Custom",
		"Back"
	}, nil, "Pistol/Shotgun\nWarning: this might not work after you apply one cheat! (eg. no restore)")
	if CH == 6 then
		HOME()
	end
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	if CH == 1 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("-20", gg.TYPE_FLOAT)
		gg.toast("Pistol Grapple 20")
	end
	if CH == 2 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("20", gg.TYPE_FLOAT)
		gg.toast("Pistol Knockback 20")
	end
	if CH == 3 then
		gg.searchNumber("20F;-20F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("0.25", gg.TYPE_FLOAT)
		gg.toast("Pistol Knockback 0.25")
	end
	if CH == 4 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("0", gg.TYPE_FLOAT)
		gg.toast("Pistol Knockback 0")
	end
	if CH == 5 then
		CH = gg.prompt({'Input your custom knockback value'},{[1] = '0'},{[1] = 'number'})
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll(CH[1], gg.TYPE_FLOAT)
		gg.toast("Pistol Grapple 20")
	end
	gg.clearResults()
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
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
		local t
		if CH == 1 then
			gg.searchNumber("1.09500002861", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
			revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
			t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
			for i, v in ipairs(t) do
				if v.flags == gg.TYPE_FLOAT then
					v.value = "3.333111555"
					v.freeze = true
				end
			end
			gg.toast("Big Body ON")
		end
		if CH == 2 then
			gg.searchNumber("3.333111555", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
			revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
			t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
			for i, v in ipairs(t) do
				if v.flags == gg.TYPE_FLOAT then
					v.value = "1.09500002861"
					v.freeze = true
				end
			end
			gg.toast("Big body OFF")
		end
		gg.addListItems(t)
		t = nil
		gg.clearResults()
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
		gg.setRanges(gg.REGION_C_BSS)
		if CH == 1 then
			gg.searchNumber("0.89868283272F;0.91149836779F;0.92426908016F;0.93699574471F;0.9496794343F;0.9623208046F;0.97492086887F;0.98748034239F;1.0F;1.01248061657F;1.02492284775F;1.03732740879F;1.04969501495F;1.06202638149F;1.07432198524F;1.08658242226F;1.09880852699F;1.11100065708F;1.12315940857F;1.1352853775F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
			gg.refineNumber("1.0")
			revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
			gg.editAll("-500", gg.TYPE_FLOAT)
			gg.toast("Destroy all cars ON")
		end
		if CH == 2 then
			gg.searchNumber("0.89868283272F;-500.0F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
			gg.refineNumber("-500")
			revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
			gg.editAll("1.0", gg.TYPE_FLOAT)
			gg.toast("Destroy all cars OFF")
		end
		gg.clearResults()
	end
	HOMEDM = -1
end

function cheat_togglevoidmode()
	gg.toast('This option will set some things to 999, which voids the mode, time limit, vehicle, and ai difficulty')
	local t = {}
--Mode
	t[1] = {}
	t[1].address = 0xC20FC36C
	t[1].flags = gg.TYPE_DWORD
	t[1].value = 9999
--AI Difficulty
	t[2] = {}
	t[2].address = 0xC20FC3A0
	t[2].flags = gg.TYPE_DWORD
	t[2].value = 9999
--Cops intensity
	t[3] = {}
	t[3].address = 0xC20FC38C
	t[3].flags = gg.TYPE_DWORD
	t[3].value = 9999
--Time limit
	t[4] = {}
	t[4].address = 0xC132A8B8
	t[4].flags = gg.TYPE_DWORD
	t[4].value = 9999
	gg.setValues(t)
	gg.toast('void mode has been set. to restore back, simply change to any mode you desire')
end

function cheat_givegrenade()
	local gg = gg
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("20", gg.TYPE_DWORD)
	gg.alert('Change Ammo to: 16, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("16", gg.TYPE_DWORD)
	x = gg.getResults(1)
	local y = {}
	y[1] = {}
	y[1].address = x[1].address + 0x4
	y[1].flags = gg.TYPE_FLOAT
	y[1].value = 1
	gg.setValues(y)
	gg.clearResults()
	gg.toast('Grenades: ON')
	HOMEDM = -1
end

function cheat_givebomb()
	local gg = gg
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("16", gg.TYPE_DWORD)
	gg.alert('Change value to: 10, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("10", gg.TYPE_DWORD)
	e = gg.getResults(1)
	local v = {}
	v[1] = {}
	v[1].address = e[1].address + 0x8
	v[1].flags = gg.TYPE_FLOAT
	v[1].value = 1
	gg.setValues(v)
	gg.clearResults()
	gg.toast('C4: ON')
	HOMEDM = -1
end

function cheat_givelaser()
	local gg = gg 
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber("10", gg.TYPE_DWORD)
	gg.alert('Change value to: 6, 10 seconds')
	gg.sleep(10000)
	gg.refineNumber("6", gg.TYPE_DWORD)
	owo = gg.getResults(1)
	local uwu = {}
	uwu[1] = {}
	uwu[1].address = owo[1].address + 0xC
	uwu[1].flags = gg.TYPE_FLOAT
	uwu[1].value = 1
	gg.setValues(uwu)
	gg.clearResults()
	gg.toast('Laser: ON')
	HOMEDM = -1
end

function cheat_win()
	local gg = gg
	gg.setRanges(gg.REGION_ANONYMOUS)
	stpOne = gg.prompt({'ENTER AMMO'},{[1] = '0'},{[1] = 'number'})
	gg.searchNumber(stpOne[1], gg.TYPE_DWORD)
	gg.alert('10 seconds to change value')
	gg.sleep(10000)
	stpTwo = gg.prompt({'ENTER NEW VALUE'},{[1] = '0'},{[1] = 'number'})
	sop = gg.refineNumber(stpTwo[1], gg.TYPE_DWORD)
	local e = {}
	e[1] = {}
	e[1].address = sop[1].address + 0x14
	e[1].flags = gg.TYPE_FLOAT
	e[1].value = 1
	gg.setValues(e)
	gg.clearResults()
	gg.toast('Level Won:ON')
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
		if CH == 1 then
			gg.alert("Payback2 CHEATus. created by ABJ4403.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this:\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source rules, we need to see the source code so that we can make sure its safe and not malware. Just take a look at Hydra for example (Payback gamer name: HydraAssasins/HYDRAofINDONESIA) YouTube videos. he's hiding every technique of cheating, the hiding is SO EXTREME. even if he gives download link of one cheat (wall-hack)\nits still proprietary, i cant read any single code to make sure its not malware, and also its whopping 200kb! im done. this is why the \"Payback2 CHEATus\" project comes")
		end
		if CH == 2 then
			gg.alert("Payback2 CHEATus. dibuat oleh ABJ4403.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietari)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus\nLicensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini:\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak ingin membagikan skrip cheat mereka sama sekali. Tentu ini melanggar aturan open-source, kita perlu melihat kode sumber sehingga kita dapat memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim. Bahkan jika dia memberikan tautan unduhan dari satu cheat (hack wall)\nitu masih proprietri, saya tidak dapat membaca kode sumber satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang")
		end
		if CH == 5 then
			show_credits()
		end
		if CH == 6 then
			show_license()
		end
	end
	HOMEDM = 1
end

function show_license()
	gg.alert("Payback 2 CHEATus, Cheat LUA Script for GameGuardian\nCopyright (C) 2021 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see <https://www.gnu.org/licenses>.")
end

function show_credits()
	gg.alert("Credit/Kredit:\nMangyu - Original script (mostly)\nToxicMods - ICE Menu (some of his cheat functions added)")
end

function exit()
	gg.clearList()
	os.exit()
end

while true do
	if gg.isVisible(true) then
		HOMEDM = 1
		gg.setVisible(false)
	end
	if HOMEDM == 1 then
		HOME()
	end
end
