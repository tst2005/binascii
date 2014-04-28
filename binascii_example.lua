#!/usr/bin/env lua

local binascii = require 'binascii'

print(binascii.hexlify('123'))
print(binascii.unhexlify('313233'))
