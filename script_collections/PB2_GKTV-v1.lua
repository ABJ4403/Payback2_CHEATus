--This is the decoded GKTV's PB2 Cheat
--Any comment i put is generated by me, not from original script (cuz they dont have 1)
--Usual fancy nonsense to do
gg.toast("Date: " .. os.date("ℹ%A %d/%m/%Y ⏰%X [%p])"))
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
--[[local Password = {"183628"}
local Menu = gg.prompt({
  "Num password"
}, {"Password"}, {"num"})
if not Menu then
  return
end
for l, I in pairs(Password) do
  if Menu[1] == I then
    A = true
  end
end
if A ~= true then
  gg.alert("⚠️Invalid Password⚠️")
  do return end
  return
end
gg.toast("Correct Password✔")]]
function MENU()
--show cheat options
  menu = gg.choice({
    "⭕Traffic Chaos: ON",
    "⭕Traffic Chaos: OFF ",
    "⭕Funny Run: ON",
    "⭕Funny Run: OFF ",
    "⭕Fly: ON",
    "⭕Fly: OFF ",
    "⭕Sun: ON",
    "⭕Sun: OFF",
    "⭕Colored trees: ON",
    "⭕Colored trees: OFF",
    "⭕Big Flamethrower: ON",
    "⭕Big Flamethrower: OFF",
    "⭕Wall Hack: ON",
    "⭕Wall Hack: OFF",
    "⭕Enable Shadows",
    "⭕Disable Shadows",
    "⭕Colored People's (ESP): ON",
    "⭕Colored People's (ESP): OFF",
    "⭕Weapon Ammo Hack",
    "⭕Speed Hack",
    "⭕Change Nickname",
    "⭕Delete All Names",
    "⭕Invisible Nickname",
    "⭕Copy YouTube",
    "🔙Exit"
  }, nil, "Script By GKTV")
  if not menu then
  end
  if menu == 1 then
    h2()
  end
  if menu == 2 then
    h3()
  end
  if menu == 3 then
    h14()
  end
  if menu == 4 then
    h15()
  end
  if menu == 5 then
    h4()
  end
  if menu == 6 then
    h5()
  end
  if menu == 7 then
    h10()
  end
  if menu == 8 then
    h11()
  end
  if menu == 9 then
    h12()
  end
  if menu == 10 then
    h13()
  end
  if menu == 11 then
    h16()
  end
  if menu == 12 then
    h17()
  end
  if menu == 13 then
    h18()
  end
  if menu == 14 then
    h19()
  end
  if menu == 15 then
    h21()
  end
  if menu == 16 then
    h20()
  end
  if menu == 17 then
    h22()
  end
  if menu == 18 then
    h23()
  end
  if menu == 19 then
    h1()
  end
  if menu == 20 then
    h8()
  end
  if menu == 21 then
    h6()
  end
  if menu == 22 then
    h7()
  end
  if menu == 23 then
    h9()
  end
  if menu == 24 then
    gg.copyText("https://youtube.com/channel/UCjTmua2y1_R4uriGRMrjigg")
  end
  if menu == 25 then
    EXIT()
  end
end
function h1() -- Weapon Ammo Hack 
  h1 = gg.prompt({"Ammo"}, nil, {"num"})
  gg.searchNumber(h1[1], gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.sleep(999)
  gg.toast("15")
  gg.sleep(999)
  gg.toast("14")
  gg.sleep(999)
  gg.toast("13")
  gg.sleep(999)
  gg.toast("12")
  gg.sleep(999)
  gg.toast("11")
  gg.sleep(999)
  gg.toast("10")
  gg.sleep(999)
  gg.toast("9")
  gg.sleep(999)
  gg.toast("8")
  gg.sleep(999)
  gg.toast("7")
  gg.sleep(999)
  gg.toast("6")
  gg.sleep(999)
  gg.toast("5")
  gg.sleep(999)
  gg.toast("4")
  gg.sleep(999)
  gg.toast("3")
  gg.sleep(999)
  gg.toast("2")
  gg.sleep(999)
  gg.toast("1")
  gg.sleep(999)
  h1 = gg.prompt({"Next Ammo"}, nil, {"num"})
  gg.refineNumber(h1[1], gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.sleep(999)
  gg.toast("15")
  gg.sleep(999)
  gg.toast("14")
  gg.sleep(999)
  gg.toast("13")
  gg.sleep(999)
  gg.toast("12")
  gg.sleep(999)
  gg.toast("11")
  gg.sleep(999)
  gg.toast("10")
  gg.sleep(999)
  gg.toast("9")
  gg.sleep(999)
  gg.toast("8")
  gg.sleep(999)
  gg.toast("7")
  gg.sleep(999)
  gg.toast("6")
  gg.sleep(999)
  gg.toast("5")
  gg.sleep(999)
  gg.toast("4")
  gg.sleep(999)
  gg.toast("3")
  gg.sleep(999)
  gg.toast("2")
  gg.sleep(999)
  gg.toast("1")
  gg.sleep(999)
  h1 = gg.prompt({"Next Ammo"}, nil, {"num"})
  gg.refineNumber(h1[1], gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  h1 = gg.prompt({
    "Change Ammo: ",
    "Frezze"
  }, {nil}, {"num", "checkbox"})
  if h1[2] == true then
    f2()
  else
    f1()
  end
end
function h2() -- Traffic Chaos ON 
  gg.searchNumber("0.89868283272F;0.91149836779F;0.92426908016F;0.93699574471F;0.9496794343F;0.9623208046F;0.97492086887F;0.98748034239F;1.0F;1.01248061657F;1.02492284775F;1.03732740879F;1.04969501495F;1.06202638149F;1.07432198524F;1.08658242226F;1.09880852699F;1.11100065708F;1.12315940857F;1.1352853775F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  gg.refineNumber("1.0")
  revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-500", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h3() -- Traffic Chaos OFF 
  gg.searchNumber("0.89868283272F;-500.0F;1.14737904072F;1.15944087505F;1.17147147655F;1.18347120285F;1.19544064999F;1.20738017559F;1.2192902565F;1.23117136955F::109", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  gg.refineNumber("-500")
  revert = gg.getResults(50, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("1.0", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h4() -- Fly ON 
  gg.searchNumber("0.25F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-20", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h5() -- Fly OFF 
  gg.searchNumber("-20.0F;1067869798D;1067869798D;1065353216D;1080326881D;1065353216D::37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  revert = gg.getResults(5000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.25", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h6() -- Change Nickname 
  h6 = gg.prompt({
    "Nickname",
    "Change nickname"
  }, {"Player", "Player2"}, {"text", "text"})
  gg.searchNumber(":" .. h6[1], gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":" .. h6[2], gg.TYPE_BYTE)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h7() -- Delete all names 
  gg.searchNumber(":Toasted", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":Wasted", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":Nuked", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":Drowned", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":OBLITERATED", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":Your team won", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":You scored", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":You finished", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":You team scored", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":DEFEND", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":STEAL", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":BASE", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":SPLATTERED", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":DELIVER", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":DOMINATE", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":CAPTURE", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.searchNumber(":KILL", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h8() -- Speed Hack 
  a = gg.prompt({
    "Speed: [1; 8]"
  }, {1}, {"number"})
  gg.setSpeed(a[1])
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h9() -- Invisible Nickname 
  h9 = gg.prompt({"Nickname"}, {"Player"}, {"text"})
  gg.searchNumber(":" .. h9[1], gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(5555, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(":", gg.TYPE_BYTE)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h10() -- Sun ON 
  gg.searchNumber("1.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("999999999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h11() -- Sun OFF 
  gg.searchNumber("999999999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("1.5", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h12() -- Colored Trees ON
  gg.searchNumber("0.04", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-999999999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h13() -- Colored Trees OFF
  gg.searchNumber("-999999999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.04", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h14() -- Funny Run ON 
  gg.searchNumber("0.004", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-999999999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h15() -- Funny Run OFF 
  gg.searchNumber("-999999999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.004", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h16() -- Big Flamethrower ON 
  gg.searchNumber("0.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("5.999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h17() -- Big Flamethrower OFF 
  gg.searchNumber("5.999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.9", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h18() -- Wall Hack ON 
  gg.searchNumber("0.001", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-1.00001", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h19() -- Wall Hack OFF 
  gg.searchNumber("-1.00001", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.001", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h20() -- Disable Shadow 
  gg.searchNumber("0.0001", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("-999.999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h21() -- Enable Shadow 
  gg.searchNumber("-999.999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.0001", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h22() -- Colored People's (ESP) ON 
  gg.searchNumber("0.08", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("999.999", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function h23() -- Colored People's (ESP) OFF 
  gg.searchNumber("999.999", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll("0.08", gg.TYPE_FLOAT)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function f1() -- Helper function 1
  revert = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
  gg.editAll(h1[1], gg.TYPE_WORD)
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function f2() -- Helper function 2
  revert = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
  local t = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
  for i, v in ipairs(t) do
    if v.flags == gg.TYPE_WORD then
      v.value = h1[1]
      v.freeze = true
    end
  end
  gg.addListItems(t)
  t = nil
  gg.clearResults(true)
  gg.toast("Hacked!")
end
function EXIT() -- Quit fron scriot
  os.exit()
end
while true do
  menuend = 0
  if gg.isVisible(true) then
    gg.setVisible(false)
    menuend = 1
  end
  if menuend == 1 then
    MENU()
  end
end
