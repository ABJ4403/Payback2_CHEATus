-- Function helpers
function tbl2hex(bytes)local r = '' for i, b in ipairs(bytes) do r = r .. string.format('%02X ',b)end return r end
function str2hex(s)return tbl2hex(gg.bytes(s, encoding))end
function hex2bin(s)return string.char(tonumber(s, 16))end
function str2tbl(s)local result = {} s:gsub(".",function(c)table.insert(result,c)end) return result end

-- Decryptors
function Decryptor_1(input) -- uncommon decryptor, found om Hydra wall hack script
	local result = ""
	for i in ipairs(input) do
		rres = input[i]
		A10_3 = 22
		if i == 1 then
			rres = rres + 22 + 759 % 256
		end
		if i == 2 then
			rres = rres - 22 + 864 % 256
		end
		if 2 < i and i < 6 then
			rres = rres + ((56 + i * 4) * (22 + i) % 256)
		end
		if 5 < i then
			rres = rres + (((56 + i * 4) * (22 + i) * 124882960 % 256) * 43475)
		end
		result = result..string.char(rres)
	end
	return result
end
function Decryptor_2(i)
	i = i.gsub(i," ","") -- optional
	return i.gsub(i,"..",function(ii)return string.char((tonumber(ii,16) + 500) % 256)end)
end
function Decryptor_2b(input) -- same as dec2 but for tables
  local result = ""
  for i=0,#input do
  --convert hex to byte, do some decrypt magic, convert it to char, and concat em
    result = result..string.char((tonumber(input[i],16) + 500) % 256)
  end
  return result
end
-- BETA
function Encryptor_2(input)
	return table.concat({input:gsub('.',function(c)return string.format('%02X',(string.byte(c) - 500) % 256)end)})
end
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










--usage
--decryptor2:





























bruh123 = Decryptor_1()
print("Decrypt 1,2: \""..bruh123.."\" > \""..Decryptor_2(bruh123).."\"")

print("Encrypt 3: "..Encryptor_3("YEET")[2])
--print("Decrypt 3: "..Decryptor_3())













