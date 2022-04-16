#!/usr/bin/env bash
# just a braindead script to simplify decompiling
unluac="java -jar unluac_1.2.3.491-bw-patch-return-patch.jar --rawstring --output"
clear
case $1 in
	as)
		echo Assembling $2...
		$unluac $2.reasm.lua --assemble $2.asm.lua
	;;ds)
		echo Disassembling $2...
		$unluac $2.asm.lua --disassemble $2.enc.lua
	;;dc)
		echo Decompiling $2...
		$unluac $2.dec.lua $2.enc.lua
	;;dr)
		echo Decompiling $2...
		$unluac $2.dec.lua $2.reasm.lua
	;;h)
		echo "Usage: $0 <action:adrh> <file(input extension must be ended with .enc.lua, cannot contain spaces, and input param cannot contain .lua because automated stuff)>"
	;;
esac
