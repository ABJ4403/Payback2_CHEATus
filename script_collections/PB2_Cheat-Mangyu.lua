function HOME()
--gg.toast("\n๐ธMangyu\n๐ธ24/04/1995\n๐ธBanjarmasin, Indonesia\n๐ธTaurus\n๐ฎEnjoy Play๐ฎ")
AZ=gg.multiChoice({
"๐ดWEAPON",
"๐ดFIRE BODY",
"๐ดBIG BODY",
"๐ดDESTROY ALL CARS",
"๐ดPISTOL ABILITY",
" โโEXITโโ"
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
print('๐Thank you๐\n๐ง๐ปYoutube๐ : โช๐ธMangyu Channel๐ธโฉ๐\nโงโโโโโโขโโโโขโโโโโโงโงโโโโโโขโโโโขโโโโโโงโงโโโโโโขโโโโขโโโโโโง\nโโโฆโโโโโโโโโฆโโโโโโโโฆโโโฆโ  โโโโโโโโโโโโโโฆโโโโฆโโโโโโ\nโโโโโโโโโโโโโโโโโฃโโโโโโโ  โโโโโโโโโโโโโโโโโโโโโฆโโโ\nโโโโโโโ โฃโโโโโโโโโโโฉโโโโโ  โโโโโโโโโ โฃโโโโโโโโโโโฉโโโโ\nโโฉโโฉโโโโโโโฉโโโโโโโโโโโโโ  โโโโโโโโโโโโโฉโโโโฉโโโโโโโโ\nโงโโโโโโขโโโโขโโโโโโงโงโโโโโโขโโโโขโโโโโโงโงโโโโโโขโโโโขโโโโโโง\n๐๐ปYoutube๐ : Mangyu Channel๐\nโโ๏น๏น๏น๏น\nโโโโโฆโโโโ\nโโฌโโโโโโฉโฃ\nโโโโ โโโโโ\n๏น๏นโโโ๏น๏น๏น\nโโโโโโโโโ\nโโโโโโโโโ\nโโผโผโผโผโผ\nโ PAYBACK2\nโโฒโฒโฒโฒโฒ\nโโโโโโโโโ\nโโ โโ')
os.exit()
end
gg.sleep(900)
gg.toast("\n๐ฉCheat By: ๐Mangyu Channel๐")end
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
gg.toast("\nโWEAPON (ON)โ")
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
gg.toast("\nโFIRE BODY (ON)โ")
end
function b3()
gg.toast("\n๐ฎEnjoy Play๐ฎ")
AZ=gg.multiChoice({
"๐ดON",
"๐ดOFF",
" ๐ BACK ๐"
},nil,"                         โโโโโโโโโขเณยฐ ยฐเณโขโโโโโโโโ\n                                               Created Byโ๏น\n                                                ๐Mangyu๐\n                                 ๐ดโชCHEAT : INDONESIAN๐ดโช\n                         โโโโโโโโโขเณยฐ ยฐเณโขโโโโโโโโ")
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
	gg.toast("\nโBIG BODY (ON)โ")
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
gg.toast("\nโBIG BODY (OFF)โ")
end
function b5()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37",gg.TYPE_FLOAT,false,gg.SIGN_EQUAL,0,-1)
revert=gg.getResults(5000)
gg.editAll("-20",gg.TYPE_FLOAT)
gg.toast("\nโPISTOL ABILITY (ON)โ")
end
--gg.alert(os.date('โน%A %d/%m/%Y\nโฐ%X [%p]\n\nโนTUTORIAL HOW TO ACTIVATED CHEATโน\n๐CONTACT๐\n๐ธVezbugg  :Mangyu๐ฉ\n๐ธWahZapp    :000895700748439๐จ\n๐ธYouTube        :Mangyu Channel๐ป\n\n'))
--gg.alert"โ CAUTIONโ \n โนSUPPORT NEW VERSION GGโน\n๐ฐNO LAG\n๐ฐNO ERROR\n๐ฐNO CORRUPT\n๐ฐEZ WIN\n๐ฐENJOY PLAY\n๐ฐNICE CHEAT"
--gg.toast"\nโPlease Waitโ\n                         โโโโโโโโโขเณยฐ ยฐเณโขโโโโโโโโ\n                                               Created Byโ๏น\n                                                ๐Mangyu๐\n                                 ๐ดโชCHEAT : INDONESIAN๐ดโช\n                         โโโโโโโโโขเณยฐ ยฐเณโขโโโโโโโโ"
while true do if gg.isVisible()then gg.setVisible(false)HOME()end end