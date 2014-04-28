#!/usr/bin/env lua5.1

local binascii = require 'binascii'

print(binascii.hexlify('123'))
print(binascii.unhexlify('313233'))
