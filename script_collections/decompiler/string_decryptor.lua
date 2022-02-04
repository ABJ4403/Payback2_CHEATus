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
  --convert string to bytes [?????????????????]
    tmp = tonumber(input[i], 256)
	--do some decrypt magic sauce
    tmp = tmp - 1
  --tmp = tmp % 256
	--and convert it to byte and concat em ?????????????????????????????????
    result = result .. tonumber(tmp, 16)
  end
  return result
end
function Decryptor_3(input)
  local result,tmp = ""
  for i in ipairs(input) do
  	xyz = result
  --convert hex to byte
    tmp = tonumber(input[i], 16)
	--do some decrypt magic sauce
    tmp = tmp + 1
    tmp = tmp % 256
	--and convert it to char and concat em
		tmp = string.char(tmp)
    result = xyz .. tmp
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















