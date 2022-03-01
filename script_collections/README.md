# What the heck is this directory?
This directory is a list of collection of Payback 2 cheat LUA Script for GameGuardian

# Lists:
### `FileName.lua` (`ActualFileName.lua`, from [`some website`]()), By Author <(uploaded by Uploader)>

- `PB2_Cheat-Mangyu.lua` ("PAYBACK2.lua", from [`MediaFire`](https://www.mediafire.com/file/9m1s41x7fjorzrf/PAYBACK2.lua/file)), By Mangyu (uploaded by "Latic AX")
- `PB2_ICE-Menu_v1.0.lua` ("{1.0} PB 2.lua", from [`MediaFire`](https://www.mediafire.com/file/o1kgc0xbcjdyzac/%7B1.0%7D+PB+2.lua/file)), By Crystal_Mods100x (uploaded by "Toxic Coder")
- `PB2_VIPTheSmat7Pro27-Mangyu.lua` (from [`MediaFire`](https://www.mediafire.com/file/6t6hy9cdszcezpr/%25E2%259C%25A8SCRIPT_PAYBACK2_VIP_THE_SMAT7_PRO_27%25E2%259C%25A8_.lua.7z/file), fork of Mangyu's script), by VIPTheSmat7Pro27

	`Difficulty: 2` `🔏️ Decryptor: ABJ4403` `🦠 None (Safe)` `🔐️ 7z+AES Encrypted` `⚙️ Decryption tools: none` `⚙️ Requirement: 7z`

	Encrypted in 7z format, Password: `LUA V1`. Where do i get this you say? from his video comment, because its in spanish i cant read it until i use Google Translate, everything revealed.
  Unfortunately, this script is just another modified version of Mangyu's cheat Script, didnt have any cheat changes except adding replacing `Mangyu` with his name `THE SMAT7 PRO 27`, adding more bloat and stuff.

- `PB2_GKTV_v1.lua` (`Payback 2 - CHEAT [V1].lua` from [`MediaFire`](https://www.mediafire.com/file/hros99ssjzmkp00/Payback_2_-_CHEAT_%255BV1%255D.lua/file)), by GKTV (now "Pumpkin Hacker")

	`Difficulty: 2` `🔏️ Decryptor: MDP43140` `🦠 None (Safe)` `💾️ Compiled binary` `💧️ Leaks variables` `⚙️ Decryption tools: Custom Patched unluac` `⚙️ Requirement: Java`

	Thankfully unlike others, this one is a bit easy. i cant decrypt this using unluac/luadec, i just need the patched custom unluac that has modified non-standard OPCodes.
	Then it works
	
- `PB2_Hydra-WallHack.lua` (`WALL HACK payback2.lua` from [`MediaFire`](https://www.mediafire.com/file/2xekhqk3tsvwq69/WALL+HACK+payback2.lua/file)), by Hydra.

	`Difficulty: 3` `🔏️ Decryptor: ABJ4403, tehtmi, MDP43140` `🦠 Sus, doing some file modification, even though i see its nonsense (kinda not safe)` `🛡️ Obfuscation (level:3)` `🔐️String Encryption (difficulty:3)` `🔐️ Password: 7o31kql9p0` `📈️ Function argument overflow` `✏️ Bytecode modification` `💣️ Decompression bomb` `❌️ Anti-decompiler` `⚙️ Decryption tools: unluac` `⚙️ Requirement: Java, text-editor that supports replacing newlines`

  Finally i had this file decrypted (kindof) , Thank you [tehtmi](https://sourceforge.net/u/tehtmi) (Unluac developer) for some decryption stuff.
  Actually what happened that is the file had some nonsense, this will be visible if you dissasemble the file:
```
settable     r59   r71   r71
gettable     r71   r59   r71
gettable     r71   r59   r71
settable     r71    k7   r74
call         r71     4     2
settable     r59   r71   r71
loadnil      r59     0
test         r59     0
move         r74   r59
test         r59     0
loadbool     r59     0     0
settable     r59   r71   r71
call         r71     1     1
settable     r71    k8   r74
test         r59     0
settable     r74   r77   r79
gettable     r79   r71   r79
loadnil      r71     8
newtable     r71     0     0
```
  and this nonsense: ```loadk         r0   k36```.
  both fills the script alot and confuses unluac, eats ~100-200kb size. just disassemble the file, remove all that above, reassemble the file, and decompile it again using patched unluac, it will work.

	I know this isn't really 'decompiled' because bunch of variables were gone, replaced by A\*_\* and its huge (400kb), so this makes it harder to reverse-engineer.

	Thanks to [mdp43140](https://github.com/mdp43140) for reverse-engineering to get the password
- `PB2_AlphaGGHackerYT_simplescriptv1.lua` (`Payback 2 ❰ ☠ ᴇɴᴄ ☠ ❱.lua` from [`MediaFire`](https://www.mediafire.com/file/og6r5ppblfzd36s/Payback_2__%25E2%259D%25B0_%25E2%2598%25A0_%25E1%25B4%2587%25C9%25B4%25E1%25B4%2584_%25E2%2598%25A0_%25E2%259D%25B1.lua/file)), by "Alpha GG Hacker YT".

	`Difficulty: 4` `🔏️ Decryptor: ABJ4403, tehtmi, MDP43140` `🦠 Safe` `🛡️ Obfuscation (level:2)` `🔒️ String Encryption (difficulty:2)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using "AlphaGG" lua encryption tool` `❌️ Anti-decompiler` `🤬️ R*c*st level:1` `⚙️ Decryption tools: unluac-patched` `⚙️ Requirement: Java, text-editor that supports replacing newlines, (also some decryption tools, you will get it by patience and knowledge)`

	Ridicilous Arbitrary slow loading embedded on the script with 0 way to bypass that at all.

	Assembled, Obfuscated, Encrypted + the author bullying you in the code itself (even though he missed one thing... password, which is a good thing).
	
	OR AM I? its DECOMPILED, so he thought his encryption works like a charm, eh?

	this one is almost the same as the hydra wallhack ones, but simpler (if u successfully decompile the script and getting rid of nonsense stuff...)

	One thing to point put though, AlphaGG put the string decryption thing on the top

	Thanks again to [tehtmi](https://sourceforge.net/u/tehtmi) for the patched unluac.

- `PB2_AlphaGGHackerYT_pb2mod1.lua` (or should i say `PB2_AlphaGGHackerYT_Mod1-unsanitized.lua`) (`『Alpha_ENC』Payback 2 Mod.lua` from [`MediaFire`](https://www.mediafire.com/file/py0v2idvgo35qi3/%25E3%2580%258EAlpha_ENC%25E3%2580%258FPayback_2_Mod.lua/file)), by "Alpha GG Hacker YT".

	`Difficulty: 20` `🔏️ Decryptor: tehtmi, ABJ4403` `🦠⚠️ Too much that this is considered UNTRUSTED & NOT SAFE!!` `🛡️ Obfuscation (level:17)` `🔒️ String Encryption (difficulty:29)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using "Serrang Gaming" lua encryption tool` `🤬️ R*c*st level:3` `❌️ Anti-decompiler` `❌️ Anti-LuaASM` `❌️ Different file encoding` `📝️ LUA Header modification` `🦠 GG Log Pollution & detection` `❌️ LUA Environment variable detection` `❌️ Debug variable detection` `⚙️ Decryption tools: unluac-patched, ghex, mousepad` `⚙️ Requirement: Java (to run unluac), text-editor that supports replacing newlines (eg. Mousepad), Hex editor (eg. Ghex)`

	WAY RIDICILOUS AND WAY WAY TOO MUCH IMPOSSIBLE!!!!!
	if you decompile this lua script with unluac or any other decompiler, it gives you almost nothing.

	BUT IS IT?
	[I asked tehtmi for help with this ridicilous nonsense](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42/#723e), and he gave a very good solution.

	The one. and the only. Edit Header with Hex editor, disassemble, remove op41,op42,op43,op44,op45, reassemble and decompile.
	no i wont reverse engineer this thing, because it will took a lot of time.
	BUT... HEY, atleast its decompiled :D

	and "my malware analysis research" says... its kinda in the red zone... because it does almost what usual gg script not doing and usual lua malware doing.
	so dont use it, atleast the encrypted ones...

- `PB2_AGH_CarSpeed_(C_BSS,A,O).lua` (`.lua` from [`MediaFire1`](https://www.mediafire.com/file/k2ne3i36wr6ovca/Car_Hack__%255B%255B_EncAGH_%255D%255D.lua/file),[`MediaFire2`](https://www.mediafire.com/file/de8idnxf9zm221f/Car_Hack_ANO__%255B%255B_EncAGH_%255D%255D.lua/file),[`MediaFire3`](https://www.mediafire.com/file/viuaklm73v1cbu9/Car_Hack_OTH__%255B%255B_EncAGH_%255D%255D.lua/file)), by AlphaGGHacker.

	`Difficulty: 4` `🔏️ Decryptor: ABJ4403` `🦠 Safe` `🛡️ Obfuscation (level:2)` `🔐️String Encryption (difficulty:2)` `📈️ Function argument overflow` `🛡️ Using "AlphaGG" lua encryption tool` `✏️ Bytecode modification` `⚙️ Decryption tools: unluac-patched` `⚙️ Requirement: Java, Unluac-patched`

	Theres's 3 files to decompile
	Atleast it was easier than the Serrang Gaming encryption ones.
	Also, you see whats inside of these files? here i tell you:
	```
-- 🛡️ Script Protected By Alpha GG Hacker YT
-- 🛡️ Visit my Youtube Channel for more updates
-- This Encryption is 50 times more harder to decrypt
-- Subscribe to My YouTube ( Alpha GG Hacker YT )
-- © This is Non-Copyright Script
-- © Serial No. ENC 38639932503





🛡️🛡️🛡️ Protected By   🇵🇭 P H I L I P P I N E S 🇵🇭   GameGuardian Official Encrypt Tool 🛡️🛡️🛡️

                       Script ProtectoR : ALPHA GG HACKER

   Proudly Protected by  P H I L I P  P I N E S  Encrypt Tool

[=[=[===========================================================================================================================================================================================>
 $@$@$@    🛡️  E N C R Y P T   B Y   🛡️            $@$@$@    🛡️  E N C R Y P T   B Y   🛡️    @@@ =================[=[=[   A L P H A    G G     H A C K E R  ]=]=]================= @@@    🛡️  E N C R Y P T   B Y   🛡️            @$@$@$    🛡️  E N C R Y P T   B Y   🛡️    @$@$@$
[=[=[===========================================================================================================================================================================================>
 $@$@$@    🛡️  E N C R Y P T   B Y   🛡️            $@$@$@    🛡️  E N C R Y P T   B Y   🛡️    @@@ =================[=[=[   A L P H A    G G     H A C K E R  ]=]=]================= @@@    🛡️  E N C R Y P T   B Y   🛡️            @$@$@$    🛡️  E N C R Y P T   B Y   🛡️    @$@$@$
[=[=[===========================================================================================================================================================================================>
 $@$@$@    🛡️  E N C R Y P T   B Y   🛡️            $@$@$@    🛡️  E N C R Y P T   B Y   🛡️    @@@ =================[=[=[   A L P H A    G G     H A C K E R  ]=]=]================= @@@    🛡️  E N C R Y P T   B Y   🛡️            @$@$@$    🛡️  E N C R Y P T   B Y   🛡️    @$@$@$
[=[=[===========================================================================================================================================================================================>
 $@$@$@    🛡️  E N C R Y P T   B Y   🛡️            $@$@$@    🛡️  E N C R Y P T   B Y   🛡️    @@@ =================[=[=[   A L P H A    G G     H A C K E R  ]=]=]================= @@@    🛡️  E N C R Y P T   B Y   🛡️            @$@$@$    🛡️  E N C R Y P T   B Y   🛡️    @$@$@$
[=[=[===========================================================================================================================================================================================>
 $@$@$@    🛡️  E N C R Y P T   B Y   🛡️            $@$@$@    🛡️  E N C R Y P T   B Y   🛡️    @@@ =================[=[=[   A L P H A    G G     H A C K E R  ]=]=]================= @@@    🛡️  E N C R Y P T   B Y   🛡️            @$@$@$    🛡️  E N C R Y P T   B Y   🛡️    @$@$@$
[=[=[===========================================================================================================================================================================================>


-- © Published in 07_Feb_22
-- © Tools Encrypt By [ 🛡️ Alpha GG Hacker YT 🛡️]
-- © This is Non-Copyright Script
-- © Serial No. ENC 38639932503


 ==========================================================================================================
	```
	Ahh YES, The `666 🇵🇭 P H I L I P P I N E S 🇵🇭 Satan 👺️ Encryption tool 🛡️🛡️🛡️`, very very gloooorious.
	Don't worry. It's already decrypted (this time without tehtmi help), because its still the same "AlphaGG" encryption tool, that can be decrypted.
	thankfully, AlphaGG didnt see this and didnt learn his failures.
	i know, there is still some confusion stuff whatever, but hey atleast i can put the "Safe" label there, because yes its actually safe like the previous script (no, not the one with SerrangGaming encryption tool).

# Warning:
**Use the assembled/obfuscated/encrypted script AT YOUR OWN RISK!!! I don't ever know if there is a MALWARE IN THESE SCRIPT or not.**

# Why i make this?
Because its VERY HARD to find these scripts dude...

# Decompiler/Decryptor resources:
- [unluac Discussion about decrypting nonsense (im the one that reports these lool)](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42)
- [unluac - `Common` Decompiler for LUA v5.x](https://sourceforge.net/projects/unluac)
- [unluac_patch - Custom patched version of (older) unluac that used to decode AlphaGG script](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42)
- [unluac_patch - Custom patched version of (older) unluac with modified non-standard OPCODES](https://sourceforge.net/p/unluac/discussion/general/thread/88e9b323cc)
- [LuaDec - LUA Decompiler for lua v5.1-3](https://github.com/viruscamp/luadec)
- [ChunkSpy - LUA Chuck inspector/dissasembler](https://github.com/viruscamp/luadec/blob/master/ChunkSpy)

# Challenge for decryptors
i will give a challenge here for decryptors. anyone that can decrypt these scripts and send it to me (not just some showcase pay shit, cuz were foss (open-source) community here, people's here are donated not paid, aka. paying is optional), i will give EXCLUSIVE `decryptor` credit on GitHub Main ReadMe section and script_collection Readme section (yeah i dont hav money so that is the only thing i can pay for lol)
