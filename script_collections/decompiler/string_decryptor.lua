function Decryptor_1(input)
	local result = ""
	A2_2 = 22
	A3_2 = 34
	A4_2 = 43475
	for i in ipairs(input) do
		A9_3 = input[i]
		A10_3 = A2_2
		if i == 1 then
			A9_3 = A9_3 + A10_3
			A10_3 = A3_2
			A10_3 = A10_3 - 1
			A11_3 = A2_2
			A11_3 = A11_3 + 1
			A10_3 = A10_3 * A11_3
			A9_3 = A9_3 + A10_3
			A9_3 = A9_3 % 256
		end
		if i == 2 then
			A9_3 = A9_3 - A10_3
			A10_3 = A3_2
			A10_3 = A10_3 + 2
			A11_3 = A2_2
			A11_3 = A11_3 + 2
			A10_3 = A10_3 * A11_3
			A9_3 = A9_3 + A10_3
			A9_3 = A9_3 % 256
		end
		if 2 < i and i < 6 then
			A11_3 = A3_2
			A10_3 = A10_3 + A11_3
			A10_3 = A10_3 + i
			A10_3 = A10_3 * 4
			A11_3 = A2_2
			A11_3 = A11_3 + i
			A10_3 = A10_3 * A11_3
			A10_3 = A10_3 % 256
			A9_3 = A9_3 + A10_3
		end
		if 5 < i then
			A11_3 = A3_2
			A10_3 = A10_3 + A11_3
			A10_3 = A10_3 + i
			A10_3 = A10_3 * 4
			A11_3 = A2_2
			A11_3 = A11_3 + i
			A10_3 = A10_3 * A11_3
			A10_3 = A10_3 * 124882960
			A10_3 = A10_3 % 256
			A11_3 = A4_2
			A10_3 = A10_3 * A11_3
			A9_3 = A9_3 + A10_3
		end
		result = result .. string.char(A9_3)
	end
	return result
end
--dec1 helper
function Decryptor_2(input)
	input = input.gsub(input, " ", "")
	function nonsense1(input2)
		return string.char((tonumber(input2, 16) + 500) % 256)
	end
	return input.gsub(input, "..", nonsense1)
end
	function Decryptor_1b(A0_3)
		A0_3 = A0_3.gsub(A0_3, " ", "")
		A0_3 = A1_3
		A2_3 = A0_3
		A1_3 = A0_3.gsub
		A3_3 = ".."
		function A4_3(A0_4)
			A1_4 = string.char
			A2_4 = tonumber
			A3_4 = A0_4
			A4_4 = 16
			A2_4 = A2_4(A3_4, A4_4)
			A2_4 = A2_4 + 500
			A2_4 = A2_4 % 256
			return A1_4(A2_4)
		end
		A1_3 = A1_3(A2_3, A3_3, A4_3)
		return A1_3
	end
-- BETA
function Encryptor_3(input)
  local tmp,result = ""
  for i in ipairs(input) do
  --convert string to bytes [?????????????????], do some encrypt magic sauce
    tmp = tonumber(input[i], 256) - 1
  --tmp = tmp % 256 unnesecary
	--and convert it to byte and concat em ?????????????????????????????????
    result = result .. tonumber(tmp, 16)
  end
  return result
end
function Decryptor_3(input)
  local result = ""
  for i in ipairs(input) do
  --convert hex to byte, do some decrypt magic, convert it to char, and concat em
    result = result .. string.char(tonumber(input[i], 16) + 1 % 256)
  end
  return result
end









--usage
--decryptor2:





























A21_2 = {}
	A21_2[1] = 39
	A21_2[2] = 233
	A21_2[3] = 20
	A21_2[4] = -41
	A21_2[5] = -90
	A21_2[6] = 32
	A21_2[7] = -8347149
	A21_2[8] = 102
	A21_2[9] = -8347168
	A21_2[10] = 51
	A21_2[11] = -8347100
	A21_2[12] = 32
	A21_2[13] = -8347145
	A21_2[14] = 55
	A21_2[15] = -8347168
	A21_2[16] = 55
	A21_2[17] = -8347100
	A21_2[18] = 32
	A21_2[19] = -8347145
	A21_2[20] = 56
	A21_2[21] = -8347168
	A21_2[22] = 52
	A21_2[23] = -8347147
	A21_2[24] = 32
	A21_2[25] = -8347145
	A21_2[26] = 99
	A21_2[27] = -8347168
	A21_2[28] = 51
	A21_2[29] = -8347101







bruh123 = Decryptor_1(A21_2)
	
print("Decrypt 1: "..bruh123)
print("Decrypt 2: "..Decryptor_2(bruh123))

L2_1 = {}
L3_1 = "df"
L4_1 = "a5"
L5_1 = "93"
L6_1 = "df"
L7_1 = "a6"
L8_1 = "a2"
L9_1 = "cc"
L10_1 = "9b"
L11_1 = "cc"
L12_1 = "a0"
L13_1 = "e1"
L14_1 = "9d"
L15_1 = "b2"
L16_1 = "1f"
L17_1 = "1f"
L18_1 = "ef"
L19_1 = "9c"
L20_1 = "99"
L21_1 = "85"
L22_1 = "ef"
L23_1 = "9c"
L24_1 = "99"
L25_1 = "8d"
L26_1 = "ef"
L27_1 = "9c"
L28_1 = "99"
L29_1 = "94"
L30_1 = "ef"
L31_1 = "9c"
L32_1 = "99"
L33_1 = "8b"
L34_1 = "ef"
L35_1 = "9c"
L36_1 = "99"
L37_1 = "97"
L38_1 = "ef"
L39_1 = "9c"
L40_1 = "99"
L41_1 = "95"
L42_1 = "ef"
L43_1 = "9c"
L44_1 = "99"
L45_1 = "8d"
L46_1 = "1f"
L47_1 = "1f"
L48_1 = "ef"
L49_1 = "9c"
L50_1 = "99"
L51_1 = "9c"
L52_1 = "ef"
L2_1[1] = L3_1
L2_1[2] = L4_1
L2_1[3] = L5_1
L2_1[4] = L6_1
L2_1[5] = L7_1
L2_1[6] = L8_1
L2_1[7] = L9_1
L2_1[8] = L10_1
L2_1[9] = L11_1
L2_1[10] = L12_1
L2_1[11] = L13_1
L2_1[12] = L14_1
L2_1[13] = L15_1
L2_1[14] = L16_1
L2_1[15] = L17_1
L2_1[16] = L18_1
L2_1[17] = L19_1
L2_1[18] = L20_1
L2_1[19] = L21_1
L2_1[20] = L22_1
L2_1[21] = L23_1
L2_1[22] = L24_1
L2_1[23] = L25_1
L2_1[24] = L26_1
L2_1[25] = L27_1
L2_1[26] = L28_1
L2_1[27] = L29_1
L2_1[28] = L30_1
L2_1[29] = L31_1
L2_1[30] = L32_1
L2_1[31] = L33_1
L2_1[32] = L34_1
L2_1[33] = L35_1
L2_1[34] = L36_1
L2_1[35] = L37_1
L2_1[36] = L38_1
L2_1[37] = L39_1
L2_1[38] = L40_1
L2_1[39] = L41_1
L2_1[40] = L42_1
L2_1[41] = L43_1
L2_1[42] = L44_1
L2_1[43] = L45_1
L2_1[44] = L46_1
L2_1[45] = L47_1
L2_1[46] = L48_1
L2_1[47] = L49_1
L2_1[48] = L50_1
L2_1[49] = L51_1
L2_1[50] = L52_1
L3_1 = "9c"
L4_1 = "99"
L5_1 = "97"
L6_1 = "1f"
L7_1 = "1f"
L8_1 = "ef"
L9_1 = "9c"
L10_1 = "99"
L11_1 = "95"
L12_1 = "ef"
L13_1 = "9c"
L14_1 = "99"
L15_1 = "a1"
L16_1 = "1f"
L17_1 = "1f"
L18_1 = "ef"
L19_1 = "9c"
L20_1 = "99"
L21_1 = "9b"
L22_1 = "ef"
L23_1 = "9c"
L24_1 = "99"
L25_1 = "8b"
L26_1 = "ef"
L27_1 = "9c"
L28_1 = "99"
L29_1 = "9a"
L30_1 = "ef"
L31_1 = "9c"
L32_1 = "99"
L33_1 = "91"
L34_1 = "ef"
L35_1 = "9c"
L36_1 = "99"
L37_1 = "98"
L38_1 = "ef"
L39_1 = "9c"
L40_1 = "99"
L41_1 = "9c"
L2_1[51] = L3_1
L2_1[52] = L4_1
L2_1[53] = L5_1
L2_1[54] = L6_1
L2_1[55] = L7_1
L2_1[56] = L8_1
L2_1[57] = L9_1
L2_1[58] = L10_1
L2_1[59] = L11_1
L2_1[60] = L12_1
L2_1[61] = L13_1
L2_1[62] = L14_1
L2_1[63] = L15_1
L2_1[64] = L16_1
L2_1[65] = L17_1
L2_1[66] = L18_1
L2_1[67] = L19_1
L2_1[68] = L20_1
L2_1[69] = L21_1
L2_1[70] = L22_1
L2_1[71] = L23_1
L2_1[72] = L24_1
L2_1[73] = L25_1
L2_1[74] = L26_1
L2_1[75] = L27_1
L2_1[76] = L28_1
L2_1[77] = L29_1
L2_1[78] = L30_1
L2_1[79] = L31_1
L2_1[80] = L32_1
L2_1[81] = L33_1
L2_1[82] = L34_1
L2_1[83] = L35_1
L2_1[84] = L36_1
L2_1[85] = L37_1
L2_1[86] = L38_1
L2_1[87] = L39_1
L2_1[88] = L40_1
L2_1[89] = L41_1
print("Decrypt 3: "..Decryptor_3(L2_1))













