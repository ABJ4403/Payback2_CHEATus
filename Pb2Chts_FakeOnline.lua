local memOzt,cfg,CH,fakePlayerData = {}
gg.getFile,gg.getTargetInfo,gg.getTargetPackage = gg.getFile():gsub("%.lua$",""),gg.getTargetInfo(),gg.getTargetPackage() -- prefetch some gg output, also strip .lua on gg.getFile
local susp_file = gg.getFile..'.suspend.json'
-- Menus --
--[[

TODO: there is a weird bugs that need to be solved:
+ Doesn't work on latest build 138
+ Sometimes restarting match automatically will just bring the
	good old brawl TBF match, not what the code intended to.
+ Activating it especially for the first time will be clunky: (Scrapped for now, use manual fuckeroo)
	+ first activate, make sure on menu (and make sure youre in custom match menu so you can be ready to press play).
	+ after 2 searches, quickly click play.
	+ match might be good old shit again.
	+ let the bot name searching doing its thing...
	+ quit match (now it should bring the real match, but bot names reset again).
	+ rerun the script (now we already cached the previous 2 searches,
		the code doesnt need to search that again, doesnt matter if its even changed).
	+ and now it should work.
+ Auto restart loads current ongoing match, not user options!!
+ For now it has to be manual (except latest version has auto-quit values, which can be used).

]]
function MENU()
	local CH = gg.choice({
		"1. Generate online-like match experience! (make sure you're already in the match, or this wont work)",
		"2. Roll back",
		"Settings",
		"__about__",
		"__exit__",
		"Suspend"
	},nil,"Pb2Chts Fake Online v"..cfg.VERSION.." (debug build), by ABJ4403")
	if CH == 1 then cheat_setupFakeOnline()
	elseif CH == 2 then
	elseif CH == 3 then MENU_settings()
	elseif CH == 4 then gg.alert("Payback2 CHEATus, Cheat Lua Script for GameGuardian\n© 2021-2023 created by ABJ4403.\nAbout fake online script:\nThis script simulates online, with real player names, and player limit, This script was made because the developer of this game (Apex Designs) is forcing players to update to latest version to play online, this script aims to be as close to multiplayer-like experience without actually even connecting to the internet.\n\nThis cheat is Open-source on GitHub: https://github.com/ABJ4403/Payback2_CHEATus\nReport issues here: https://github.com/ABJ4403/Payback2_CHEATus/issues\nLicense: GPLv3\nTested on:\n- Payback2 v2.104.12.4\n- Payback v2.106.0 (NOT WORKING, some values and offset needs to be readjusted)\n- GameGuardian v101.0\nThis cheat is part of FOSS (Free and Open-Source Software)\n\nLicense:\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.	If not, see https://gnu.org/licenses") MENU()
	elseif CH == 5 then exit()
	elseif CH == 6 then suspend() end
	tmp={}
end
function MENU_settings()
	local CH = gg.choice({
		"Clear result & some list items",
		"Change entity anchor searching method",
		"__back__"
	},nil,"Payback2_CHEATus Fake Online v"..cfg.VERSION.." (debug build), by ABJ4403")
	if CH == 3 then MENU()
	elseif CH == 1 then gg.clearResults() gg.clearList() MENU_settings()
	---
	elseif CH == 2 then
		CH = gg.choice({
			"1. Hold weapon (Hold pistol/knife. ~6 seconds)",
			"2. Auto anchor (Hold pistol, dont shoot. Faster, rarely fails)",
			"3. Auto anchor 2 (finds any player/ai/vehicle)",
			"__back__",
		},cfg.entityAnchrSearchMethod,"Pb2Chts Fake Online v"..cfg.VERSION.." (debug build), by ABJ4403")
		if CH then
			if CH > 0 and CH < 4 then cfg.entityAnchrSearchMethod = CH end
			MENU_settings()
		end
	end
end

-- Bunch of cheats go here --
function cheat_setupFakeOnline()
--[[
TODO:
+ Replace AI Names with fake name (provided by cfg.fakePlayerData).
+ Set up fake XP as well.
+ Somehow resume ??? :)
]]
	modifyMatch()
	changeAllAiName()
	toast("Finished, now you can resume the game to enjoy online-like experience!")
end

function changeAllAiName()
	gg.setRanges(cfg.memRange.general)
	local randomFakePlayerDataIndexes = genUniqueRandomNumber(#cfg.botsData,1,#cfg.fakePlayerData)
	for i=1,#cfg.botsData do
		findAndChangeName(cfg.botsData[i].name,cfg.fakePlayerData[randomFakePlayerDataIndexes[i]].name)
	end
end
function modifyMatch()
	gg.clearResults()
	handleMemOzt("matchBackendAnchor",367336,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther,"Please wait... this might take a while... (1/2)\nMake sure you're on: Main Menu > Play > Custom, be ready to press play")
	gg.clearResults()
	handleMemOzt("xpAnchor",1014817001,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther,"Please wait... this might take a while... (1.5/2)") -- only findable on main menu
	if not memOzt.xpAnchor then
	--This value changes based on the map and if the player is on main menu or not
	--handleMemOzt("xpAnchor",1217639095,nil,gg.TYPE_DWORD,1,cfg.memZones.Common_RegionOther,"Please wait... this might take a while... (1.8/2)")
	--if not memOzt.xpAnchor and memOzt.matchBackendAnchor then
	--this hack is definititely wont work on different platform & version (especially judging by very far offset)
		memOzt.xpAnchor = {{address=table.copy(memOzt.matchBackendAnchor).address + 0x1C5F514}}
	--end
	end
	gg.clearResults()
--TODO
	local xpAchr = memOzt.xpAnchor[1].address
	local mtcAchr = memOzt.matchBackendAnchor[1].address
	local t = {
		{address=xpAchr+0xB0,value=cfg.randomMatch.maps[math.random(1,#cfg.randomMatch.maps)],freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [Map]"},
		{address=xpAchr+0xB4,value=cfg.randomMatch.modes[math.random(1,#cfg.randomMatch.modes)],freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [Mode]"},
		{address=xpAchr+0xB8,value=10,freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [AICount]"},
		{address=xpAchr+0xBC,value=math.random(2,5),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [RaceLaps]"},
		{address=xpAchr+0xC0,value=math.random(0,1),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [Traffic]"},
		{address=xpAchr+0xC8,value=5,freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [TeamSize]"},
		{address=xpAchr+0xD0,value=math.random(0,5),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [TimeLimit]"},
		{address=xpAchr+0xD4,value=0,freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [CopsLevel]"},
		{address=xpAchr+0xD8,value=cfg.randomMatch.vehicle[math.random(1,#cfg.randomMatch.vehicle)],freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [Vehicle]"},
		{address=xpAchr+0xF4,value=math.random(0,5),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [CTS.ZoneA]"},
		{address=xpAchr+0xF8,value=math.random(0,5),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [CTS.ZoneB]"},
	--{address=xpAchr+0xF,value=,freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts []"},
		{address=xpAchr+0xFC,value=math.random(0,1),freeze=true,flags=gg.TYPE_BYTE,name="Pb2Chts [RaceReverse]"},
	}
--gg.setValues(t)
--gg.addListItems(t)

--Now user should be on pause menu, ask them to quit manually (as for now, i dont find the quit value)
	toast("Chosen match: "..t[1].value..", mode: "..t[2].value.."\nNow click Play!\nTime limit: 3 seconds")
	gg.sleep(3e3)
	--TODO
	--gg.setValues({
		--{address=mtcAchr-0x34,value=1,flags=gg.TYPE_BYTE,name="Pb2Chts [Pause]"}
	--})
end
function findAndChangeName(from,to)
	local memOztIndex = "playerName_"..from
	log(f("Changing Name: %s > %s...",from,to))
	handleMemOzt(memOztIndex,":"..from,nil,gg.TYPE_BYTE,1,cfg.memZones.Common_RegionOther,f("Changing Name: %s > %s...",from,to)) -- search
	gg.clearResults()
	if memOzt[memOztIndex] then
	 -- we only need 1st result as an anchor to work with the thingy, we just need to do fuzzy search
	 -- with the said address + 24 char, and load that
		local anchor = memOzt[memOztIndex][1].address
		gg.startFuzzy(gg.TYPE_BYTE,anchor,anchor + 0x24)
		gg.getResults(24)
		gg.editAll(":"..to,gg.TYPE_BYTE)
		gg.clearResults()
	end
end

-- Configuration (Hard-coded) --
cfg = {
	entityAnchrSearchMethod=2,
	enableAutoMemRangeOpti=true,
	memZones={
		Common_RegionOther={0xB0000000,0xCFFFFFFF}
	},
	memRange={
		general = gg.REGION_OTHER
	},
	VERSION="0.2",
	fakePlayerData = {
--updated: 09/06/23
--pro/active/legend/reputable players
	--{name="AyamGGoreng",xp=49230}, -- me now (btw that XP was legit, but outdated info, just like the rest of these below)
		{name="A1ej4ndro48",xp=40569},
		{name="AfricanboyKenya",xp=39074},
		{name="Africanboytanzania",xp=55656},
		{name="AjjuSaysFukU",xp=208630},
		{name="AnnihilatorIsHere",xp=46751},
		{name="AwesomeMedicYT",xp=999999},
		{name="BHOOOOOOOOOOTT",xp=35295},
		{name="BlackCobraYT",xp=126250},
		{name="CoolFoe64188",xp=26039},
		{name="cowjazz",xp=478705},
		{name="doanh20cm",xp=25540},
		{name="DominicTorretoPro",xp=32997},
		{name="FootBallerNITT",xp=96161},
		{name="G1adi4tor48",xp=289702},
		{name="GameKingYT",xp=22828},
		{name="GBxBiyaKhan",xp=19183},
		{name="GrimLabradoodle50495",xp=13898},
		{name="hacker666argentina",xp=74543},
		{name="HalfwayEnforcement34",xp=25221},
		{name="Harshitpooled",xp=37482},
		{name="jerrygultomm97",xp=26094},
		{name="Jun1i4",xp=30000}, -- ??
		{name="karthik7cricket",xp=21421},
		{name="karthikrao4572",xp=24645},
		{name="Kenyanicon047",xp=26078},
		{name="KeralaTigerYT",xp=16458},
		{name="KHIL(A^o)Di17",xp=22501},
		{name="KILLINGRACER19",xp=22501},
		{name="Lifepooled",xp=23382},
		{name="Lucifer100995",xp=45983},
		{name="lunasthephiny23",xp=726735},
		{name="MarcosAcre789YT",xp=289702},
		{name="MAYANKKKKKKKKKKK",xp=83048},
		{name="MichaelCasasYT",xp=21588},
		{name="M.Nikkor",xp=116498},
		{name="Oo2o",xp=31382},
		{name="OnlyPB2p",xp=28499},
		{name="panitiakiamat678",xp=75801},
		{name="PassableScramble12",xp=15929},
		{name="paybackman",xp=17021},
		{name="Player_4770344783",xp=7274},
		{name="premkmr39",xp=33555},
		{name="PrithviSharma14",xp=15912},
		{name="PriyanshuDhiman",xp=67780},
		{name="PugGTI",xp=15512},
		{name="PurposiveSupporter27",xp=29824},
		{name="PurposiveSupporter27",xp=41280},
		{name="Rebel19981004",xp=15082},
		{name="RoCkpawa19",xp=76244},
		{name="ROLEX7",xp=26226},
		{name="SharpestPackage32",xp=32696},
		{name="SynHaxStep",xp=126074},
		{name="TangibleFill5",xp=53548},
		{name="TejbirSingh2006",xp=23188},
		{name="TeologicalFear20",xp=24000},
		{name="Term1na8or",xp=18095},
		{name="TheTenRings",xp=42275},
		{name="THEXDESMOND",xp=14673},
		{name="TrippingCapybara6065",xp=65666},
		{name="Villain1818",xp=40816},
		{name="WhiteLegends1333",xp=28142},
		{name="xDontTeachMex",xp=21297},

--generic/inactive players
		{name="0nePieCe009",xp=10138},
		{name="13Punjab13",xp=17892},
		{name="9MASHESHNAVGIRE9",xp=6088},
		{name="AgentVirYT",xp=8683},
		{name="Alien risk",xp=1480},
		{name="AverageLiking19",xp=18545},
		{name="ayush27060",xp=2714},
		{name="best1king1best",xp=828},
		{name="brokebrian",xp=6192},
		{name="CasualClock15",xp=10039},
		{name="CompulsorySelf32",xp=8782},
		{name="ControllableDeck16",xp=10965},
		{name="dickgraysonrobin1996",xp=11326},
		{name="DurableAppelation42",xp=13245},
		{name="ElusiveExpectation37",xp=12867},
		{name="Excalibrator",xp=16159},
		{name="FabledDecendent28",xp=4433},
		{name="FantasticalShake11",xp=661},
		{name="GearShifters127",xp=2000},
		{name="fifteenthdelay62",xp=5837},
		{name="Hazal1profighterYT",xp=3191},
		{name="HieseongChoi",xp=4934},
		{name="IcedShrine35",xp=10877},
		{name="imnabeelansari",xp=20292},
		{name="IndonesianBruh9",xp=985},
		{name="InnerDiginity",xp=7937},
		{name="IzyanFarhanKhan2",xp=21810},
		{name="KeenerFabrication10",xp=2260},
		{name="Largejellyfish1597",xp=46732},
		{name="LaverYT9283",xp=18959},
		{name="LOUDSPARKRDS",xp=5936},
		{name="Manrajveer",xp=1713},
		{name="ModernFairy48",xp=1636},
		{name="Mrkokachi",xp=1719},
		{name="Nasirgamer99",xp=2437},
		{name="NoobRedTeam",xp=4049},
		{name="ObsessiveLung20",xp=19429},
		{name="PlaidHighlander24044",xp=9499},
		{name="pranayshetty0205",xp=7334},
		{name="PresentViolet246",xp=16000},
		{name="PSArmy",xp=2487},
		{name="Rajprithvi367",xp=20648},
		{name="RegalLeopard87",xp=7713},
		{name="rehaanovi?",xp=11566},
		{name="ReverentialCup31",xp=1803},
		{name="ScarySpot26",xp=5722},
		{name="Shivamjustyouaregood",xp=8899},
		{name="Silly Wyvern 844",xp=11805},
		{name="summitmalya5",xp=1124},
		{name="Surjeet2207",xp=9121},
		{name="ThirteenthGarrison33",xp=7310},
		{name="TidalSauce30",xp=10000},
		{name="Toufiq?",xp=1646},
		{name="UnrulyComputer45",xp=7889},
		{name="VanquishingDrawing37",xp=5040},
		{name="VinDieselmax",xp=1186},
		{name="VividWidth49",xp=948},
		{name="XxDRAGONERPOWERxX",xp=8573},
		{name="Yooooooooooooo002",xp=16548},

--known cheaters hehe
	--{name="AyamGGoreng",xp=999999}, -- okay that was old times to be honest, im no longer cheating (kind of, what i mean by that is im no longer stealing wons/XP, and killing innocent players), its just boring and no longer possible in new version
	--{name="Ayamggoreng",xp=8714}, -- someone tries to copy me, but also unfortunately steal play game game too that way :/
		{name="???",xp=177990},
		{name="Damian406YT",xp=999999},
		{name="DominicPietersz",xp=999999},
	--{name="GameReaper46963",xp=999999}, -- this was nonexistent, i made up that name to test things out
		{name="GamerWTF",xp=999999},
		{name="[({HYDRA})]",xp=999999},
		{name="Joker GG Scripter",xp=999999}, -- he's no longer hacking pb2 anymore
		{name="King?Fahim",xp=999999},
		{name="KsFahim888",xp=999999},
		{name="marcciblackk",xp=999999},
		{name="MrSailorWTF",xp=999999},
		{name="RBLegendBlackCobraYT",xp=999999},
		{name="Red?legend",xp=999999},
		{name="XxGodNightshadeYTxXD",xp=978857},
		{name="YourFvckinLOSER",xp=3916},
		{name="YourFvckinGirLOSER",xp=999999},
	},
	botsData = {
		{name="Biggs"},
		{name="Bonnie"},
		{name="Capone"},
		{name="Corleone"},
		{name="Clyde"},
		{name="Fawkes"},
		{name="Jesse"},
		{name="Kiddo"},
		{name="Manson"},
		{name="Mr Pink"},
		{name="Oswald"},
		{name="R. Hood"},
		{name="Reggie"},
		{name="Ronnie"},
		{name="Travis"},
		{name="Turpin"},
		{name="Verbal"},
		{name="Walter"},
	},
	randomMatch = {
		maps = {1,3,4,6,7,8},
	--maps = {0,1,2,3,4,5,6,7,8,9},
		modes = {2,5},
	--modes = {0,1,2,3,4,5,6,7},
		vehicle = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26},
	},
}

-- Helper functions --
function genUniqueRandomNumber(length,min,max)
	local t = {}
	while #t < length do
		local new = math.random(min,max)
		if not table.hasValue(t,new) then
			table.insert(t,new)
		end
	end
	return t
end
function table.hasValue(t,v)
	for i = 1,#t do if t[i] == v then return true end end
	return false
end
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
	return next(t) and result or range
end
function exit()
	gg.clearResults()
	os.exit()
end
function suspend()
	gg.saveVariable({
		memOzt=memOzt,
		pid=gg.getTargetInfo.pid,
	},susp_file)
	print(f"Suspend_Text")
	os.exit()
end
function restoreSuspend()
	local susp = loadfile(susp_file)
	if susp then
		susp = susp()
		os.remove(susp_file)
		if susp.pid == gg.getTargetInfo.pid then
			toast("Session file detected, continuing from suspend...")
			memOzt = susp.memOzt
		end
	end
	susp = nil
end
function log(...)print("[Debug]",...)end
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

-- Initialization --
toast=function(s,f)gg.toast(s,true)end
sleep=gg.sleep
f=string.format

if cfg.enableAutoMemRangeOpti then
	cfg.memZones.Common_RegionOther = optimizeRange(cfg.memZones.Common_RegionOther)
end

-- Restore session file if any
restoreSuspend()

-- GG GUI Detection and UI Replace stuff --
while true do
	while not gg.isVisible()do sleep(100)end
	gg.setVisible(false)
	MENU()
	gg.clearResults()
	collectgarbage()
end