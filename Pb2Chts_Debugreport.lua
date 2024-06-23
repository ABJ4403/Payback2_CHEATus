gg.getFile,gg.getTargetInfo,gg.getLocale = gg.getFile():gsub("%.lua$",""),gg.getTargetInfo(),gg.getLocale()
local tmp,memOzt,t = {},{},{} -- blank table for who knows...
local logs
local cfg = {
	memZones={
		c={0xB0000000,0xCFFFFFFF},
	},
	memRange={
		cData = (gg.REGION_C_DATA | gg.REGION_OTHER),
		general = (gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER),
	},
	enableLogging=false,
	entityAnchrSearchMethod=2,
	VERSION="1.2"
}




--— Helper functions —————————————--
function table.tostring(t,dp)
	dp = dp or 0
	local r,tab,tv = '{\n',('\t'):rep(dp)
	local tabb = tab..'\t'
	dp = dp + 1
	for k,v in pairs(t) do
		r = r..tabb
		tv = type(v)
		if type(k) == 'string' then
			r = r..k..' = '
		end
		if tv == 'table' then
			r = r..table.tostring(v,dp)
		elseif tv == 'number' and (v < -9999999 or v > 9999999) then
			r = r..("0x%X"):format(v)
		elseif tv == 'boolean' or tv == 'number' then
			r = r..tostring(v)
		else
			r = r..'"'..v..'"'
		end
		r = r..',\n'
	end
	return r..tabb..'}'
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
function optimizeRange(range)
	local t = {
		table.unpack(gg.getRangesList(gg.getTargetInfo.sourceDir)),
		table.unpack(gg.getRangesList(gg.getTargetInfo.sourceDir:gsub("base%.apk$","config.*.apk"))), -- for VirtualXposed
		table.unpack(gg.getRangesList(gg.getTargetInfo.sourceDir:gsub("base%.apk$","split_config.*.apk"))) -- AOSP Split APK
	}
	local result = {
		range[2],
		range[1]
	}
	range[3] = range[2] - range[1]
	for i=1,#t do
		local ti = t[i]
		if type(ti) == "table" then
			if ti.start < range[1] or
				 ti['end'] > range[2] or
				 (ti['end'] - ti.start) > range[3] or
				 not (ti.state == "O" or ti.state == "Xa") then
			--Remove it
				t[i] = nil
			else
			--else, calculate the result...
				result[1] = math.min(result[1],ti.start)
				result[2] = math.max(result[2],ti['end'])
			end
		end
	end
	table.remove(range,3)
	return next(t) and result or range
end
function findEntityAnchr()
	gg.setRanges(cfg.memRange.general)
	local tmp,tmp0
	if cfg.entityAnchrSearchMethod == 2 then
		toast("Make sure you're in a match, don't shoot, switch weapon to pistol")
	--this huge packs of "battery" below is basically searching "120W;20W;-501~30000W;13W;2B::??" in accurately optimized way
		gg.searchNumber(32000,gg.TYPE_DWORD,nil,nil) -- 1/6 random anchor
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 1: "..#tmp for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x48) tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber(120)          -- 2/6 shooting state (warn: value sometimes altered a bit? i rarely checked it and it sometimes shows 122 instead)
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 2: "..#tmp for i=1,#tmp do tmp[i].address = (tmp[i].address + 0xEF) tmp[i].flags = gg.TYPE_BYTE  end gg.loadResults(tmp) gg.refineNumber(2)            -- 3/6 (ControlCode 2B)
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 3: "..#tmp for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC7) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) gg.refineNumber(55834574848)  -- 4/6 (HoldWeapon 0;0;13;0::W)
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 4: "..#tmp for i=1,#tmp do tmp[i].address = (tmp[i].address - 0xC)  tmp[i].flags = gg.TYPE_WORD  end gg.loadResults(tmp) gg.refineNumber('-501~30000') -- 5/6 (Health -501~30000W(because carhealth&nostealcar cheat))
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 5: "..#tmp for i=1,#tmp do tmp[i].address = (tmp[i].address - 0x8) end gg.loadResults(tmp) gg.refineNumber(20) -- 6/6 (Anchor 20)
		tmp=gg.getResults(5e3)logs=logs.."\n[i] 6: "..#tmp
		tmp0 = #tmp
		if tmp0 > 1 then
			toast(tmp0.." Duplicates found! switch weapon to knife")
			for i=1,tmp0 do tmp[i].address = (tmp[i].address + 0x14) tmp[i].flags = gg.TYPE_QWORD end gg.loadResults(tmp) sleep(2e3) gg.refineNumber(0) -- refine knife
			tmp=gg.getResults(2) logs=logs.."\n[i] 7: "..#tmp
		end
		gg.clearResults()
		return tmp
	elseif cfg.entityAnchrSearchMethod == 1 then
		toast("Hold pistol")
		sleep(2e3)
		gg.searchNumber(13,gg.TYPE_DWORD)
		t = gg.getResults(200)
		tmp0 = #t
		logs=logs.."\n[i] A: "..tmp0
		local isKnife = true
		while tmp0 > 1 do
			toast(f(isKnife and "Hold Knife" or "Hold Pistol"))
			sleep(2e3)
			gg.refineNumber(isKnife and 0 or 13)
			t = gg.getResults(200)
			tmp0 = #t
			logs=logs..("\n[i] %s: %s"):format(isKnife and "B" or "A",tmp0)
			if tmp0 == 0 then return
			elseif tmp0 == 2 then
				if t[1].value == t[2].value then break end
			end
			isKnife = not isKnife
		end
		tmp0=nil
		gg.clearResults()
		return t
	end
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
f=string.format
--————————————————————————————————--



--— Debugging ———————————————--
toast("[i] Gathering reports...\n[!] Make sure you're in a game match")
cfg.memZones.c3 = optimizeRange(cfg.memZones.c)
cfg.memZones.c2 = cfg.memZones.c
cfg.memZones.c = {0,-1}
DATA = [==[[+] --- Beginning of bug report %s ---

[i] Version of Pb2Chts Report generator used: v%s
[i] Android SDK Version: %d
[i] GG Package Name: %s
[i] GG Package version: %s (%d, build %d)
[i] Amount of RAM used by the process: %dMB
[i] Output of optimized ranges: %s

[i] Output of gg.getTargetInfo: %s

[i] Output of ranges for %s (*.apk): %s

[i] Result of finding entity anchor with method "holdWeapon": %s

[i] Result of finding entity anchor with method "abjAutoAnchor": %s

[i] Result count logs for finding entity anchors:%s

[+] --- End of bug report %s ---
]==]


-- gathering player anchors
gg.setVisible(false)
cfg.entityAnchrSearchMethod = 1
logs = "\n[i] Logs for find entity anchor holdWeapon:"
local tmp_achr1 = findEntityAnchr()
cfg.entityAnchrSearchMethod = 2
logs = logs .. "\n\n[i] Logs for find entity anchor abjAutoAnchor:"
local tmp_achr2 = findEntityAnchr()

-- remove unneded information for gg.getTargetInfo
gg.getTargetInfo.taskAffinity = nil
gg.getTargetInfo.lastUpdateTime = nil
gg.getTargetInfo.firstInstallTime = nil
gg.getTargetInfo.sharedUserLabel = nil
gg.getTargetInfo.theme = nil
gg.getTargetInfo.descriptionRes = nil
gg.getTargetInfo.activities = nil
gg.getTargetInfo.cmdLine = nil
gg.getTargetInfo.enabledSetting = nil
gg.getTargetInfo.flags = nil
gg.getTargetInfo.labelRes = nil
gg.getTargetInfo.logo = nil
gg.getTargetInfo.icon = nil
gg.getTargetInfo.publicSourceDir = nil
gg.getTargetInfo.uid = nil
gg.getTargetInfo.pid = nil


io.open("Pb2Chts_report.json","a"):write(f(
	DATA,
	os.date("%x - %T.%s"),
	cfg.VERSION,
	gg.ANDROID_SDK_INT,
	gg.PACKAGE,
	gg.VERSION,gg.VERSION_INT,gg.BUILD,
	gg.getTargetInfo.RSS/1e3,
	f("%X—%X → %X—%X",cfg.memZones.c2[1],cfg.memZones.c2[2],cfg.memZones.c3[1],cfg.memZones.c3[2]),
	table.tostring(gg.getTargetInfo),
	gg.getTargetInfo.sourceDir:gsub("base%.apk$","*.apk"),table.tostring(gg.getRangesList(gg.getTargetInfo.sourceDir:gsub("base%.apk$","*.apk"))),
	table.tostring(tmp_achr1),
	table.tostring(tmp_achr2),
	logs,
	os.date("%x - %T.%s")
)):close()
gg.setVisible(true)
toast("[+] Finished!")
print("[+] Report is generated on "..gg.getFile.."_report.json")
print("[+] Now you can upload the file to GitHub issues with your report detail, or send it to my Telegram group @ABJ4403_Group or privately to @ABJ4403")
