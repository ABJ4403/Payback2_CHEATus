-- Function helpers
function tbl2hex(bytes)
	local r = ''
	for i, b in ipairs(bytes) do
		r = r .. string.format('%02X ', b)
	end
	return r
end

function str2hex(s)
	return tbl2hex(gg.bytes(s, encoding))
end

function hex2bin(s)
	return string.char(tonumber(s, 16))
end

function str2tbl(s)
	local result = {}
	s:gsub(".",function(c) table.insert(result,c) end)
	return result
end

-- Decryptors
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
  local tmp,result = {},{}
--convert string to bytes
  for i,v in ipairs(str2tbl(input)) do
  --do some encrypt magic sauce
  --tmp = tmp % 256 unnesecary
	--and convert it to byte & hex and put them to tables ??????????????????/
    result[i] = tonumber(v, 16)
    print(i,v,tonumber(v, 16))
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





























bruh123 = Decryptor_1()
print("Decrypt 1,2: \""..bruh123.."\" > \""..Decryptor_2(bruh123).."\"")

print("Encrypt 3: "..Encryptor_3("YEET")[2])
--print("Decrypt 3: "..Decryptor_3())













