-- (pre)Define local variables (can possibly improve performance according to lua-users.org wiki)
local gg,tmp_tpCheckpoints,tmp_choicesMenu,CH = gg,{},{}
gg.getFile,gg.getTargetPackage = gg.getFile():gsub("%.lua$",""),gg.getTargetPackage() -- prefetch some gg output, also strip .lua on gg.getFile
local cfg_file = gg.getFile..'.conf' -- define config files
local CH,cfg,lastCfg -- preallocate stuff for who knows...
local f,entityTpProps

-- Cheat menus --
function MENU()
--Let the user choose stuff
	local CH = gg.choice(tmp_choicesMenu,nil,"Pb2Chts_Teleport v"..cfg.VERSION.." (debug build), by ABJ4403\nFilter by map: TODO:StringifyFilterMapInteger")
	if CH then
		if CH == (#tmp_choicesMenu - 4) then createCheckpoint()
		elseif CH == (#tmp_choicesMenu - 3) then deleteCheckpoint()
		elseif CH == (#tmp_choicesMenu - 2) then editCheckpoint()
		elseif CH == (#tmp_choicesMenu - 1) then changeMapFilter()
		elseif CH == #tmp_choicesMenu then exit()
		elseif CH <  (#tmp_choicesMenu - 4) then tpPlayerToDest(tmp_tpCheckpoints[CH]) end
	end
end

-- stuff --
function tpPlayerToDest(coords)
	local anchAddr = findEntityAnchr()
	if anchAddr then
		anchAddr = anchAddr[1]
		entityTpProps[1].address = anchAddr-0x6B0
		entityTpProps[1].value   = coords[1]
		entityTpProps[2].address = anchAddr-0x6AC
		entityTpProps[2].value   = coords[2]
		entityTpProps[3].address = anchAddr-0x6A8
		entityTpProps[3].value   = coords[3]
		entityTpProps[4].address = anchAddr-0x66C
		entityTpProps[5].address = anchAddr-0x668
		entityTpProps[6].address = anchAddr-0x664
		entityTpProps[7].address = anchAddr-0x660
		entityTpProps[8].address = anchAddr-0x65C
		entityTpProps[9].address = anchAddr-0x658
		gg.setValues(entityTpProps)
		gg.clearResults()
		toast("Teleported to "..coords[5].." ["..coords[1]..","..coords[2]..","..coords[3]..']!')
	else
		toast('Failed')
	end
end
function changeMapFilter()
	local CH = gg.choice({
		[-2]="Show all",
		[-1]="Uncategorized",
		[ 0]="0. The Big Freeze",
		[ 1]="1. Allegro City",
		[ 2]="2. Destra City",
		[ 3]="3. Metropolis",
		[ 4]="4. D-Town",
		[ 5]="5. Urban Shore",
		[ 6]="6. House Park",
		[ 7]="7. Freedom City",
		[ 8]="8. Los Francos City",
		[ 9]="9. Corona City",
		[10]="10. Desert Outpost",
		[11]="11. Isla Nublar",
	},cfg.tpFilterListMap,"Choose which coordinate based on map you currently in")
	if type(CH) == 'number' then
		cfg.tpFilterListMap = CH
		filterCheckpointList()
		MENU()
	end
end
function createCheckpoint()
	local coords = {0.5,9,0.5,-1,"Point "..(#cfg.tpCheckpoint+1)}
	if cfg.createCheckpointAuto then
		local anchAddr = findEntityAnchr()
		if anchAddr then
			anchAddr = anchAddr[1]
			CH = {
				{address=anchAddr-0x6B0,flags=gg.TYPE_FLOAT},
				{address=anchAddr-0x6AC,flags=gg.TYPE_FLOAT},
				{address=anchAddr-0x6A8,flags=gg.TYPE_FLOAT},
			}
			gg.clearResults()
			gg.loadResults(CH)
			local t = gg.getResults(3)
			coords[1] = math.floor(tonumber(t[1].value))
			coords[2] = math.floor(tonumber(t[2].value))
			coords[3] = math.floor(tonumber(t[3].value))
			gg.clearResults()
		else
			toast('Failed to find your current entity! you need to find it manually...')
		end
	end
	CH = gg.prompt({
		"X coord:",
		"Y coord:",
		"Z coord:",
		"Map filter\n-1=Uncategorized\n0=The big freeze\n1=Allegro\n2=Destra\n3=Metropolis\n4=D-Town\n5=Urban shore\n6=House park\n7=Freedom city\n8=Los francos\n9=Corona\n10=Desert Outpost\n11=Isla Nublar [-1;11]",
		"Name (optional)"
	},
	coords,
	{
		"number",
		"number",
		"number",
		"number",
		"text",
	})
	if CH then
		cfg.tpCheckpoint[#cfg.tpCheckpoint+1] = CH
		filterCheckpointList()
	end
end
function deleteCheckpoint()
--Let the user choose stuff
	local choicesMenu = {};
	for i in ipairs(cfg.tpCheckpoint) do
		choicesMenu[i] = i..". "..tostring(cfg.tpCheckpoint[i][5]).." ["..cfg.tpCheckpoint[i][1]..","..cfg.tpCheckpoint[i][2]..","..cfg.tpCheckpoint[i][3].."]"
	end
	table.append(choicesMenu,{ -- TODO: Prepend tpCheckpoint to choicesMenu, but does the current implementation work though?
		"__cancel__",            -- 1
	})
	local CH = gg.choice(choicesMenu,nil,"Choose what checkpoint to remove")
	if CH then
		if CH == #choicesMenu then
		elseif CH <= (#choicesMenu - 1) then
			table.remove(cfg.tpCheckpoint,CH)
			filterCheckpointList()
		end
	end
end
function editCheckpoint()
--Let the user choose stuff
	local choicesMenu = {};
	for i in ipairs(cfg.tpCheckpoint) do
		choicesMenu[i] = i..". "..tostring(cfg.tpCheckpoint[i][5]).." ["..cfg.tpCheckpoint[i][1]..","..cfg.tpCheckpoint[i][2]..","..cfg.tpCheckpoint[i][3].."]"
	end
	table.append(choicesMenu,{ -- TODO: Prepend tpCheckpoint to choicesMenu, but does the current implementation work though?
		"__cancel__",            -- 1
	})
	local index = gg.choice(choicesMenu,nil,"Choose what checkpoint to edit")
	if index then
		if index == #choicesMenu then
		elseif index <= (#choicesMenu - 1) then
			CH = gg.prompt({
				"X coord:",
				"Y coord:",
				"Z coord:",
				"Map filter\n-1=Uncategorized\n0=The big freeze\n1=Allegro\n2=Destra\n3=Metropolis\n4=D-Town\n5=Urban shore\n6=House park\n7=Freedom city\n8=Los francos\n9=Corona [-1;9]",
				"Name (optional)"
			},
			cfg.tpCheckpoint[index],
			{
				"number",
				"number",
				"number",
				"number",
				"text",
			})
			if CH then
				cfg.tpCheckpoint[index] = CH
				filterCheckpointList()
			end
		end
	end
end
function filterCheckpointList()
	local index2 = 1
	tmp_choicesMenu = {}
	tmp_tpCheckpoints = {}
	for i in ipairs(cfg.tpCheckpoint) do -- loop over orig CPs
		if cfg.tpFilterListMap == -2 or cfg.tpFilterListMap == cfg.tpCheckpoint[i][4] then -- if filter off or matches set filter
			tmp_tpCheckpoints[index2] = cfg.tpCheckpoint[i] -- add it
			index2 = index2 + 1 -- increment external index number tracker
		end
	end
	updateCheckpointList()
end
function updateCheckpointList()
	for i in ipairs(tmp_tpCheckpoints) do -- loop over filtered CPs
	--build choice menu options (index. Name [X,Y,Z])
		tmp_choicesMenu[i] = i..". "..tostring(tmp_tpCheckpoints[i][5]).." ["..tmp_tpCheckpoints[i][1]..","..tmp_tpCheckpoints[i][2]..","..tmp_tpCheckpoints[i][3].."]"
	end
	table.append(tmp_choicesMenu,{ -- Append additional options to choicesMenu
		"➕ Create TP Checkpoint", -- 1
		"➖ Delete TP Checkpoint", -- 2
		"🖊️ Edit TP Checkpoint", 	-- 3
		"Change filter by map", -- 4
		"__exit__",            -- 5
	})
end

-- Helper functions --
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
		t2[k]=type(v)=="table"and table.copy(v)or v
  end
  return t2
end
function table.append(t1,t2)
	for i=1,#t2 do
		t1[#t1+1]=t2[i]
	end
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
	if cfg.entityAnchrSearchMethod == 1 then
		toast("Please wait... don't shoot, hold pistol 🔫")
		gg.searchNumber(32000,gg.TYPE_WORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther)) -- 1/6 random anchor
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) end gg.loadResults(tmp) gg.refineNumber(120)                                       -- 2/6 shooting state (warn: value sometimes altered a bit? i rarely checked it and it sometimes shows 122 instead)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) tmp[i].flags = gg.TYPE_BYTE  end gg.loadResults(tmp) gg.refineNumber(2)            -- 3/6 (ControlCode 2B)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC7) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) gg.refineNumber(55834574848)  -- 4/6 (HoldWeapon 0;0;13;0::W)
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC)  tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber('-501~30000') -- 5/6 (Health -501~30000W(because carhealth&nostealcar cheat))
		tmp=gg.getResults(5e3)for i=1,#tmp do tmp0 = ("%x"):format(tmp[i].address) if tmp0:find('508$') or tmp0:find('d08$') or tmp0:find('5f4$') or tmp0:find('df4$') then tmp[i].address = (tmp[i].address - 0x8) else tmp[i] = nil end end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)
		tmp0 = gg.getResultCount()
		if tmp0 > 0 then
			if tmp0 > 1 then
				toast(tmp0.." Duplicate results! hold knife 🔪")
				for i=1,#tmp do tmp[i].address = (tmp[i].address + 0x14) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) sleep(1e3) gg.refineNumber(0) -- refine pistol
				tmp=gg.getResults(1)
				tmp0=tmp[1]and tmp[1].address-0x14 or nil -- back to anchor
			else
				tmp0=tmp[1].address
			end
			tmp=nil
			gg.clearResults()
			return {tmp0}
		end
	elseif cfg.entityAnchrSearchMethod == 2 then
		toast("Hold your pistol 🔫")
		sleep(1e3)
		gg.searchNumber(13,gg.TYPE_DWORD,nil,nil,table.unpack(cfg.memZones.Common_RegionOther))
		t = gg.getResults(200)
		for i=1,#t do
			tmp0 = ("%x"):format(t[i].address)
			if not (tmp0:find('518$') or tmp0:find('d18$') or tmp0:find('604$') or tmp0:find('e04$')) then t[i] = nil end
		end
		tmp0 = gg.getResultCount()
		while tmp0 > 1 do
			toast("Hold your knife 🔪")
			sleep(2e3)
			gg.refineNumber(0)
			t = gg.getResults(200)
			tmp0 = gg.getResultCount()
			if tmp0 == 1 then break
			elseif tmp0 == 0 then return
			elseif tmp0 == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
			toast("Hold your pistol 🔫")
			sleep(2e3)
			gg.refineNumber(13)
			t = gg.getResults(200)
			tmp0 = gg.getResultCount()
			if tmp0 == 1 then break
			elseif tmp0 == 0 then return
			elseif tmp0 == 2 then
				t = gg.getResults(2)
				if t[1].value == t[2].value then t = {t[1]} break end
			end
			tmp0 = gg.getResultCount()
		end
		tmp,tmp0=nil,nil
		gg.clearResults()
		return {t[1].address - 0x18}
	else
		toast("An error occured (invalidConf): Exit out of script and see print log for more details.")
		print("[Error.InvalidConf]: Configuration value for \"cfg.entityAnchrSearchMethod\" ("..cfg.entityAnchrSearchMethod..") is invalid.\n         Possible values: 1 (abjAutoAnchor), 2 (holdWeapon)")
	end
end
function exit()
	saveConfig()
	gg.clearResults()
	os.exit()
end
function saveConfig()
	cfg.memZones = lastCfg.memZones
	io.open(cfg_file,'w'):write([[-- This is the configuration file for Pb2Chts SaveQuickTP.
-- You can customize any settings and parameters you want here
-- Make sure you have a backup of this config file, because even a bit of typo results in config parser failure.
-- btw cfg.tpCheckpoint data structure looks something like this: {x,y,z,filterMap,"Name"}
-- also you can ignore the return thing below :)

return ]]..table.tostring(cfg)):close()
end
function loadConfig()
	cfg = {
		memZones={
			Common_RegionOther={0xB0000000,0xCFFFFFFF},
		},
		memRange={
			general = (gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
		},
		enableAutoMemRangeOpti=true,
		entityAnchrSearchMethod="abjAutoAnchor",
		tpFilterListMap=-1,
		tpCheckpoint={
		--These are just the examples
			{270,7,152,7,"Freedom Helicopter"}, -- TBF near heli, Allegro wallhack, Destra wallhack, Metropolis wallhack, DTown near heli,
			{482,7,330,7,"Freedom Tanks"}, -- TBF roadways, Allegro midways, Destra random house, Metropolis forest, DTown void,
			{75,13,203,2,"Allegro Tank"}, -- TBF quik-emart, Destra bank?, Metropolis near plains & CTS, DTown roof,
		},
		createCheckpointAuto=true,
		VERSION="3.1",
	}
	lastCfg = cfg
	local cfg_load = loadfile(cfg_file)
	if cfg_load then
		cfg_load = cfg_load()
		cfg_load.VERSION = cfg.VERSION
		cfg = table.merge(cfg,cfg_load)
		lastCfg = table.copy(cfg) -- deep-clone
	else
		toast("No configuration files detected, Creating new one...  💾️\nHi There! 👋️ Looks like You're new here.")
		saveConfig()
	end
	cfg_load = nil
end
function log(...)print("[Debug]",...)end

-- Initialization --
sleep=gg.sleep
function toast(s,f)gg.toast(s,true)end
f=string.format
entityTpProps={
	{flags=gg.TYPE_FLOAT}, -- Entity_pX
	{flags=gg.TYPE_FLOAT}, -- Entity_pY
	{flags=gg.TYPE_FLOAT}, -- Entity_pZ
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vPX
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vPY
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vPZ
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vRX
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vRY
	{flags=gg.TYPE_FLOAT,value=0}, -- Entity_vRZ
}


-- Load settings and coordinate lists
loadConfig()
filterCheckpointList()

if cfg.enableAutoMemRangeOpti then
	cfg.memZones.Common_RegionOther = optimizeRange(cfg.memZones.Common_RegionOther)
end

-- GG GUI Detection and UI Replace stuff --
gg.clearResults()
while true do
	while not gg.isVisible()do sleep(100)end
	gg.setVisible(false)
	MENU()
	gg.clearResults()
	collectgarbage()
end