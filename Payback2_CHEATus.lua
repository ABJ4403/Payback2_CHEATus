function HOME()
	CH = gg.choice({
		"Not work on PB2 2.104.12.4/GG 101.0):",
		"Weapon",
		"Burning body",
		"Big body",
		"Destroy all cars",
		"---",
		"Works on PB2 2.104.12.4/GG 101.0):",
		"Pistol/Shotgun Knockback cheat",
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
	if CH == 8 then
		cheat_pistol_multichoice()
	end
	if CH == 10 then
		show_about()
	end
	if CH == 11 then
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
		"Back",
	}, nil, "Pistol/Shotgun\nWarning: this might not work after you apply one cheat! (eg. no restore)")
	if CH == 5 then
		HOME()
	end
	gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
	if CH == 1 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("-20", gg.TYPE_FLOAT)
		gg.toast("Pistol Grapple ON")
	end
	if CH == 2 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("20", gg.TYPE_FLOAT)
		gg.toast("Pistol Knockback ON")
	end
	if CH == 3 then
		gg.searchNumber("20F;-20F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("0.25", gg.TYPE_FLOAT)
		gg.toast("Pistol Grapple/Knockback OFF")
	end
	if CH == 4 then
		gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
		revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
		gg.editAll("0", gg.TYPE_FLOAT)
		gg.toast("Pistol 0 Knockback")
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
	if CH == nil then
	else
		if CH == 3 then
			HOME()
		end
		gg.setRanges(gg.REGION_C_BSS | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
		if CH == 1 then
			gg.searchNumber("1.09500002861", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
			revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
			local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
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
			local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
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
	if CH == nil then
	else
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

function show_about()
	CH = gg.choice({
		"🇺🇸️ English",
		"🇮🇩️ Indonesia",
		"---",
		"License/Lisensi",
		"Back/Kembali",
	}, nil, "Select your language\nPilih bahasa")
	if CH == nil then
	else
		if CH == 1 then
			gg.alert("Payback2 CHEATus. created by ABJ4403, Original script by Mangyu.\nThis cheat is Open-source on GitHub (unlike any other cheats some cheater bastards not showing at all! they make it beyond proprietary)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\n\nWhy i make this:\nBecause i see Payback 2 players (notably cheaters) are very rude, and did'nt want to share their cheat script at all. This ofcourse violates open-source rules, we need to see the source code so that we can make sure its safe and not malware. Just take a look at Hydra for example (Payback gamer name: HydraAssasins/HYDRAofINDONESIA) YouTube videos. he's hiding every technique of cheating, the hiding is SO EXTREME. even if he gives download link of one cheat (wall-hack)\nits still proprietary, i cant read any single code to make sure its not malware, and also its whopping 200kb! im done. this is why the \"Payback2 CHEATus\" project comes")
		end
		if CH == 2 then
			gg.alert("Payback2 CHEATus. dibuat oleh ABJ4403, skrip original oleh Mangyu.\nCheat ini bersumber-terbuka (Tidak seperti cheat lain yang cheater tidak menampilkan sama sekali! mereka membuatnya diluar proprietari)\nGitHub: https://github.com/ABJ4403/Payback2_CHEATus\nLaporkan isu disini: https://github.com/ABJ4403/Payback2_CHEATus\nLicensi: GPLv3\nDiuji di:\n- Payback2 v2.104.12.4\n- GameGuardian v101.0\nCheat ini termasuk bagian dari FOSS (Perangkat lunak Gratis dan bersumber-terbuka)\n\n\nKenapa saya membuat ini:\nKarena saya melihat pemain Payback 2 (terutama cheater) sangat rude, dan tidak ingin membagikan skrip cheat mereka sama sekali. Tentu ini melanggar aturan open-source, kita perlu melihat kode sumber sehingga kita dapat memastikan bahwa cheat ini aman dan tidak ada malware. Lihat saja video YouTube Hydra untuk contohnya (Nama gamer Payback: HydraAssasins/HYDRAofINDONESIA). Dia menyembunyikan setiap teknik cheat, menyembuyikannya sangat ekstrim. Bahkan jika dia memberikan tautan unduhan dari satu cheat (hack wall)\nitu masih proprietri, saya tidak dapat membaca kode sumber satupun untuk memastikan itu bukan malware, dan juga sebesar 200kb! saya selesai. Inilah sebabnya mengapa proyek \"Payback2 CHEATus\" datang")
		end
		if CH == 4 then
			show_license()
		end
	end
	HOMEDM = 1
end

function show_license()
	gg.alert("Payback 2 CHEATus, Cheat LUA Script for GameGuardian\nCopyright (C) 2021 ABJ4403\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see <https://www.gnu.org/licenses>.")
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
