
-- original: http://smherwig.blogspot.fr/2013/05/a-simple-binascii-module-in-ruby-and-lua.html

-- module setup
local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M

-- import section
local error = error
local string = string
local table = table
local tonumber = tonumber

-- no more external access after this point
setfenv(1, M)

---
-- Converts a string of bytes to a hexadecimal string
function hexlify(s)
	local a = {}
	for i=1,#s do
		local c = string.sub(s,i,i)
		local byte = string.byte(c)
		table.insert(a, string.format('%02X', byte))
	end
	return table.concat(a)
end

---
-- Converts a hexadecimal string to a string of bytes
function unhexlify(s)
	if #s % 2 ~= 0 then
		error('unhexlify: hexstring must contain even number of digits')
	end
	local a = {}
	for i=1,#s,2 do
		local hs = string.sub(s, i, i+1)
		local code = tonumber(hs, 16)
		if not code then
			error(string.format("unhexlify: '%s' is not avalid hex number", hs))
		end
		table.insert(a, string.char(code))
	end
	return table.concat(a)
end

