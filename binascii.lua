
-- original: http://smherwig.blogspot.fr/2013/05/a-simple-binascii-module-in-ruby-and-lua.html
-- TsT: some fixes for lua 5.2

-- module setup
local _M = {}

-- import section
local error = error
local string = require "string"
local table = require "table"
local tonumber = tonumber

-- no more external access after this point
--setfenv(1, M)

---
-- Converts a string of bytes to a hexadecimal string
local function hexlify(s)
	local a = {}
	for i=1,#s do
		local c = s:sub(i,i)
		local byte = c:byte()
		a[#a+1] = ('%02X'):format(byte)
	end
	return table.concat(a)
end

---
-- Converts a hexadecimal string to a string of bytes
local function unhexlify(s)
	if #s % 2 ~= 0 then
		error('unhexlify: hexstring must contain even number of digits')
	end
	local a = {}
	for i=1,#s,2 do
		local hs = s:sub(i, i+1)
		local code = tonumber(hs, 16)
		if not code then
			error( ("unhexlify: '%s' is not avalid hex number"):format(hs) )
		end
		a[#a+1] = string.char(code)
	end
	return table.concat(a)
end

_M.hexlify   = hexlify
_M.b2a_hex   = b2a_hex
_M.unhexlify = unhexlify
_M.a2b_hex   = a2b_hex

return _M -- return the module object
