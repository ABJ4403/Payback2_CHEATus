function HOME()
--gg.toast("\n🔸Mangyu\n🔸24/04/1995\n🔸Banjarmasin, Indonesia\n🔸Taurus\n🎮Enjoy Play🎮")
AZ=gg.multiChoice({
"🔴WEAPON",
"🔴FIRE BODY",
"🔴BIG BODY",
"🔴DESTROY ALL CARS",
"🔴PISTOL ABILITY",
" ❌❎EXIT❎❌"
})
if AZ then
if AZ[1] then b1()end
if AZ[2] then b2()end
if AZ[3] then b3()end
if AZ[4] then b4()end
if AZ[5] then b5()end
gg.clearResults()
if AZ[6] then
gg.clearList()
print('🙏Thank you🙏\n🎧💻Youtube🔔 : ↪🔸Mangyu Channel🔸↩📌\n✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧\n╔═╦═╗╔══╗╔═╦╗╔══╗╔═╦╗╔╦╗  ╔═╗╔╗╔╗╔══╗╔═╦╗╔═╦╗╔═╗╔╗\n║║║║║║╔╗║║║║║║╔═╣╚╗║║║║║  ║╔╝║╚╝║║╔╗║║║║║║║║║║╦╝║║\n║║║║║║╠╣║║║║║║╚╗║╔╩╗║║║║  ║╚╗║╔╗║║╠╣║║║║║║║║║║╩╗║╚╗\n╚╩═╩╝╚╝╚╝╚╩═╝╚══╝╚══╝╚═╝  ╚═╝╚╝╚╝╚╝╚╝╚╩═╝╚╩═╝╚═╝╚═╝\n✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧✧═════•❁❀❁•═════✧\n📌💻Youtube🔔 : Mangyu Channel📌\n╔╗﹏﹏﹏﹏\n║╚╗╔╦╗╔═╗\n║╬║║║║║╩╣\n╚═╝╠╗║╚═╝\n﹏﹏╚═╝﹏﹏﹏\n█████████\n█▄█████▄█\n█▼▼▼▼▼\n█ PAYBACK2\n█▲▲▲▲▲\n█████████\n██ ██')
os.exit()
end
gg.sleep(900)
gg.toast("\n🚩Cheat By: 😎Mangyu Channel😎")end
end
function b1()
gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
gg.searchNumber("1.68155816e-43F;2.80259693e-44F;1.12103877e-42F;1.821688e-44F;0D~71131136D::61",gg.TYPE_DWORD,false,gg.SIGN_EQUAL,0,-1)
revert=gg.getResults(5000)
local t=gg.getResults(5000)
for i,v in ipairs(t) do
if v.flags==gg.TYPE_DWORD then
v.value="71131136"
v.freeze=true
end
end
gg.addListItems(t)
t=nil
gg.toast("\n✔WEAPON (ON)✔")
end
function b2()
gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
gg.searchNumber("1.68155816e-43F;0D;2.80259693e-44F;1.12103877e-42F;1.821688e-44F::45",gg.TYPE_DWORD,false,gg.SIGN_EQUAL,0,-1)

revert=gg.getResults(5000)
local t=gg.getResults(5000)
for i,v in ipairs(t) do
if v.flags==gg.TYPE_DWORD then
v.value="9999"
v.freeze=true
end
end
gg.addListItems(t)
t=nil
gg.toast("\n✔FIRE BODY (ON)✔")
end
function b3()
gg.toast("\n🎮Enjoy Play🎮")
AZ=gg.multiChoice({
"🔴ON",
"🔴OFF",
" 🔙 BACK 🔙"
},nil,"                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝")
if AZ==nil then
else
if AZ[1] then
c1()
end
if AZ[2] then
c2()
end
if AZ[3] then
HOME()
end
end
end
function c1()
	gg.setRanges(gg.REGION_C_BSS)
	gg.searchNumber(1.09500002861,gg.TYPE_FLOAT)

	revert=gg.getResults(555)
	local t=gg.getResults(555)
	for i=1,#t do
	t[i].value=3.333111555
	t[i].freeze=true
	end
	gg.addListItems(t)
	t=nil
	gg.toast("\n✔BIG BODY (ON)✔")
end
function b4()
local CH=gg.choice({
"ON",
"OFF",
string.format"__back__"
},nil,"Destroy cars\nPS: this only works on old version (and maybe vmos)")
if CH then
--+ gg.REGION_JAVA_HEAP + gg.REGION_C_ALLOC
gg.setRanges(gg.REGION_C_BSS + gg.REGION_ANONYMOUS + gg.REGION_OTHER)
if CH==3 then MENU()
elseif CH==1 then
gg.searchNumber("0.89868283272;0.91149836779;0.92426908016;0.93699574471;0.9496794343;0.9623208046;0.97492086887;0.98748034239;1;1.01248061657;1.02492284775;1.03732740879;1.04969501495;1.06202638149;1.07432198524;1.08658242226;1.09880852699;1.11100065708;1.12315940857;1.1352853775;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109",gg.TYPE_FLOAT)
gg.refineNumber(1)
gg.getResults(50)
if gg.getResultCount()==0 then
gg.toast("Can't find the specific set of number.")
else
gg.editAll(-500,gg.TYPE_FLOAT)
gg.toast("Destroy all cars ON")
end
elseif CH==2 then
gg.searchNumber("0.89868283272;-500;1.14737904072;1.15944087505;1.17147147655;1.18347120285;1.19544064999;1.20738017559;1.2192902565;1.23117136955::109",gg.TYPE_FLOAT)
gg.refineNumber(-500)
gg.getResults(50)
if gg.getResultCount()==0 then
gg.toast("Can't find the specific set of number.")
else
gg.editAll(1,gg.TYPE_FLOAT)
gg.toast("Destroy all cars OFF")
end
end
end
end
function c2()
gg.setRanges(gg.REGION_C_BSS)
gg.searchNumber(3.333111555,gg.TYPE_FLOAT)

revert=gg.getResults(555)
local t=gg.getResults(555)
for i=1,#t do
t[i].value=1.09500002861
t[i].freeze=false
end
gg.addListItems(t)
t=nil
gg.toast("\n✔BIG BODY (OFF)✔")
end
function b5()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37",gg.TYPE_FLOAT,false,gg.SIGN_EQUAL,0,-1)
revert=gg.getResults(5000)
gg.editAll("-20",gg.TYPE_FLOAT)
gg.toast("\n✔PISTOL ABILITY (ON)✔")
end
--gg.alert(os.date('ℹ%A %d/%m/%Y\n⏰%X [%p]\n\nℹTUTORIAL HOW TO ACTIVATED CHEATℹ\n🍃CONTACT🍃\n🔸Vezbugg  :Mangyu📩\n🔸WahZapp    :000895700748439📨\n🔸YouTube        :Mangyu Channel💻\n\n'))
--gg.alert"⚠CAUTION⚠\n ℹSUPPORT NEW VERSION GGℹ\n🔰NO LAG\n🔰NO ERROR\n🔰NO CORRUPT\n🔰EZ WIN\n🔰ENJOY PLAY\n🔰NICE CHEAT"
--gg.toast"\n⌛Please Wait⌛\n                         ╔══════❖•ೋ° °ೋ•❖══════╗\n                                               Created By✎﹏\n                                                👑Mangyu👑\n                                 🔴⚪CHEAT : INDONESIAN🔴⚪\n                         ╚══════❖•ೋ° °ೋ•❖══════╝"
while true do if gg.isVisible()then gg.setVisible(false)HOME()end end