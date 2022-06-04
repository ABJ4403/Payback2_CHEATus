-- Function helpers
function tbl2hex(t)for i=1,#t do t[i] = string.format('%02X',(t[i]))end return table.concat(t)end
function str2hex(s,e)e=e or 'UTF-8' return tbl2hex(gg.bytes(s,e))end
function hex2bin(s)return string.char(tonumber(s,16))end
function str2tbl(s)local r={} s:gsub(".",function(i)r[#r]=i end) return r end

-- Decryptors
function Decryptor_1(input) -- uncommon decryptor, found on Hydra wall hack script
	local result = ""
	for i=1,#input do
		rres = input[i]
		A10_3 = 22
		if i == 1 then
			rres = (rres + 22 + 759) % 256
		end
		if i == 2 then
			rres = (rres - 22 + 864) % 256
		end
		if 2 < i and i < 6 then
			rres = (rres + (56 + i * 4) * (22 + i)) % 256
		end
		if 5 < i then
			rres = (rres + (56 + i * 4) * (22 + i) * 124882960) % 256 * 43475
		end
		result = result..string.char(rres)
	end
	return result
end
function Decryptor_2(i)
--why theres random ({})[1]? because gsub actually returns 2 result, we only wanted one result
	return ({ i:gsub('..',function(i)return string.char((tonumber(i,16) + 500) % 256)end) })[1]
end
function Decryptor_2b(t) -- same as dec2 but for tables (both input and output)
  for i=1,#t do
		t[i] = string.char((tonumber((t[i]),16) + 500) % 256)
	end
	return table.concat(t)
end
-- BETA
function Encryptor_2(i)
--IMPORTANT: if the dec was +500, the enc must be -500
	return ({ i:gsub('.',function(i)return string.format('%02X',(string.byte(i) - 500) % 256)end) })[1]
end
function Encryptor_3(input)
  local tmp,result = {},{}
--if the args was string
  input = str2tbl(input)
--convert string to bytes
  for i=1,#input do
  --do some encrypt magic sauce
  --tmp = tmp % 256 unnesecary
	--and convert it to byte & hex and put them to tables ??????????????????/
    result[i] = tonumber(v, 16)
  end
  return result
end




