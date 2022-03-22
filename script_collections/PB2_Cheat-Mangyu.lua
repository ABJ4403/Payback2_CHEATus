--gg.alert(os.date('ℹ%A %d/%m/%Y\n⏰%X [%p]\n\nℹTUTORIAL HOW TO ACTIVATED CHEATℹ\n🍃CONTACT🍃\n🔸Facebook ID :Mangyu📩\n🔸Whatsapp    :+62895700748439📨\n🔸Youtube        :Mangyu Channel💻\n\n'))
--gg.alert("⚠CAUTION⚠\n ℹSUPPORT NEW VERSION GAMEGUARDIANℹ\n🔰NO LAG\n🔰NO ERROR\n🔰NO CORROUPT\n🔰EASY WIN\n🔰ENJOY PLAY\n🔰NICE FEATURE CHEAT")
--gg.toast("\n⌛Please Wait⌛")

function HOME()
--gg.toast("\n🔸Mangyu\n🔸24-04-1995\n🔸Banjarmasin,Indonesia\n🔸Taurus")
RS =gg.choice({
"🔴ON",
"❌❎EXIT❎❌"
}, nil, "                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝")
 if RS == nil then
else
 if RS == 1 then
      GG1()
end
 if RS == 2 then
      Exit()
  end
end
HOMEDM = -1
end
function b1()
gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
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
gg.toast("\n✔WEAPON (ON)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function b2()
gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
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
gg.toast("\n✔FIRE BODY (ON)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function b3()
gg.toast("\n🎮Enjoy Play🎮")
 AZ =gg.multiChoice({
"🔴ON",
"🔴OFF",
" 🔙 BACK 🔙"
}, nil, "                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝")
 if AZ == nil then
else
 if AZ[1] == true then
      c1()
end
 if AZ[2] == true then
      c2()
end
 if AZ[3] == true then
      HOME()
  end
end
HOMEDM = -1
end
function c1()
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("1.09500002861", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)

revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
for i, v in ipairs(t) do
	if v.flags == gg.TYPE_FLOAT then
		v.value = "3.333111555"
		v.freeze = true
	end
end
gg.addListItems(t)
t = nil
gg.clearResults()
gg.toast("\n✔BIG BODY (ON)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function b4()
gg.toast("\n🎮Enjoy Play🎮")
 AI =gg.multiChoice({
"🔴ON",
"🔴OFF",
" 🔙 BACK 🔙"
}, nil, "                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝")
 if AI == nil then
else
 if AI[1] == true then
      c3()
end
 if AI[2] == true then
      c4()
end
 if AI[3] == true then
      HOME()
  end
end
HOMEDM = -1
end
function c3()
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("0.89868283272F;0.91149836779F;0.92426908016F;0.93699574471F;0.9496794343F;0.9623208046F;0.97492086887F;0.98748034239F;1.0F;1.01248061657F;1.02492284775F;1.03732740879F;1.04969501495F;1.06202638149F;1.07432198524F;1.08658242226F;1.09880852699F;1.11100065708F;1.12315940857F;1.1352853775F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
gg.refineNumber("1.0")
revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("-500", gg.TYPE_FLOAT)
gg.clearResults()
gg.toast("\n✔DESTROY ALL CARS (ON)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function c4()
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("0.89868283272F;-500.0F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
gg.refineNumber("-500")
revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("1.0", gg.TYPE_FLOAT)
gg.clearResults()
gg.toast("\n✔DESTROY ALL CARS (OFF)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function c2()
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber("3.333111555", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)

revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
local t = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
for i, v in ipairs(t) do
	if v.flags == gg.TYPE_FLOAT then
		v.value = "1.09500002861"
		v.freeze = true
	end
end
gg.addListItems(t)
t = nil
gg.clearResults()
gg.toast("\n✔BIG BODY (OFF)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function b5()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("-20", gg.TYPE_FLOAT)
gg.clearResults()
gg.toast("\n✔PISTOL ABILITY (ON)✔")
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")
end
function GG1()
gg.toast("\n🎮Enjoy Play🎮")
 AZ =gg.multiChoice({
"🔴WEAPON",
"🔴FIRE BODY",
"🔴BIG BODY",
"🔴DESTROY ALL CARS",
"🔴PISTOL ABILITY",
" 🔙 BACK 🔙"
}, nil, "                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝")
 if AZ == nil then
else
 if AZ[1] == true then
      b1()
end
 if AZ[2] == true then
      b2()
end
 if AZ[3] == true then
      b3()
end
 if AZ[4] == true then
      b4()
end
 if AZ[5] == true then
       b5()
end
 if AZ[6] == true then
      HOME()
  end
end
HOMEDM = -1
end

function Exit()
gg.clearList()
gg.toast('\n          🙏Thanks You🙏\n↪🔸Mangyu Channel🔸↩')
print('🎧💻Youtube🔔 : Mangyu Channel📌')
print('\n✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧\n╔═╦═╗╔══╗╔═╦╗╔══╗╔═╦╗╔╦╗  ╔═╗╔╗╔╗╔══╗╔═╦╗╔═╦╗╔═╗╔╗\n║║║║║║╔╗║║║║║║╔═╣╚╗║║║║║  ║╔╝║╚╝║║╔╗║║║║║║║║║║╦╝║║\n║║║║║║╠╣║║║║║║╚╗║╔╩╗║║║║  ║╚╗║╔╗║║╠╣║║║║║║║║║║╩╗║╚╗\n╚╩═╩╝╚╝╚╝╚╩═╝╚══╝╚══╝╚═╝  ╚═╝╚╝╚╝╚╝╚╝╚╩═╝╚╩═╝╚═╝╚═╝\n✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧')
print('📌💻Youtube🔔 : Mangyu Channel📌')
print('╔╗﹏﹏﹏﹏\n║╚╗╔╦╗╔═╗\n║╬║║║║║╩╣\n╚═╝╠╗║╚═╝\n﹏﹏╚═╝﹏﹏﹏')
print('█████████\n█▄█████▄█\n█▼▼▼▼▼\n█ PAYBACK2\n█▲▲▲▲▲\n█████████\n██ ██')
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
