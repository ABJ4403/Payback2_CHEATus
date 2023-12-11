# What the heck is this directory?
This directory is a list of collection of Payback 2 cheat Lua Script for GameGuardian

# Lists:
### `FileName.lua` (`ActualFileName.lua`, from [`some website`]()), By Author <(uploaded by Uploader)>

- `PB2_Cheat-Mangyu.lua` ("PAYBACK2.lua", from [`MediaFire`](https://www.mediafire.com/file/9m1s41x7fjorzrf/PAYBACK2.lua/file)), By Mangyu (uploaded by "Latic AX")
- `PB2_ICE-Menu_v1.0.lua` ("{1.0} PB 2.lua", from [`MediaFire`](https://www.mediafire.com/file/o1kgc0xbcjdyzac/%7B1.0%7D+PB+2.lua/file)), By Crystal_Mods100x (uploaded by "Toxic Coder")
- `PB2_VIPTheSmat7Pro27-Mangyu.lua` (from [`MediaFire`](https://www.mediafire.com/file/6t6hy9cdszcezpr/%25E2%259C%25A8SCRIPT_PAYBACK2_VIP_THE_SMAT7_PRO_27%25E2%259C%25A8_.lua.7z/file), same Mangyu script), by VIPTheSmat7Pro27
- `PB2_GKTV_v1.lua` (`Payback 2 - CHEAT [V1].lua` from [`MediaFire`](https://www.mediafire.com/file/hros99ssjzmkp00/Payback_2_-_CHEAT_%255BV1%255D.lua/file)), by GKTV (now "Pumpkin Hacker")

	`Difficulty: 2` `🔏️ Decryptor: MDP43140` `🦠 None (Safe)` `💾️ Compiled binary` `💧️ Leaks variables` `⚙️ Decryption tools: Custom Patched unluac` `⚙️ Requirement: Java`

	Thankfully unlike others, this one is a bit easy. i cant decrypt this using unluac/luadec, i just need the patched custom unluac that has modified non-standard OPCodes, Then it works.

- `PB2_Hydra-WallHack.lua` (`WALL HACK payback2.lua` from [`MediaFire`](https://www.mediafire.com/file/2xekhqk3tsvwq69/WALL+HACK+payback2.lua/file)), by Hydra.

	`Difficulty: 3` `🔏️ Decryptor: ABJ4403, tehtmi, MDP43140` `🦠 Sus, doing some file modification, even though i see its nonsense (kinda not safe)` `🛡️ Obfuscation (level:3)` `🔐️String Encryption (difficulty:3)` `🔐️ Password: 7o31kql9p0` `📈️ Function argument overflow` `✏️ Bytecode modification` `💣️ Decompression bomb` `❌️ Anti-decompiler` `⚙️ Decryption tools: unluac` `⚙️ Requirement: Java, text-editor that supports replacing newlines`

  Finally i had this file decrypted (kindof), Kudos to [tehtmi](https://sourceforge.net/u/tehtmi) (Unluac developer) for some decryption stuff.

	Thanks to [mdp43140](https://github.com/mdp43140) for reverse-engineering to get the password
- `PB2_AGH_simplescriptv1.lua` (`Payback 2 ❰ ☠ ᴇɴᴄ ☠ ❱.lua` from [`MediaFire`](https://www.mediafire.com/file/og6r5ppblfzd36s/Payback_2__%25E2%259D%25B0_%25E2%2598%25A0_%25E1%25B4%2587%25C9%25B4%25E1%25B4%2584_%25E2%2598%25A0_%25E2%259D%25B1.lua/file)), by "Alpha GG Hacker YT".

	`Difficulty: 4` `🔏️ Decryptor: ABJ4403, tehtmi, MDP43140` `🦠 Safe` `🛡️ Obfuscation (level:2)` `🔒️ String Encryption (difficulty:2)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using "AlphaGG" lua encryption tool` `❌️ Anti-decompiler` `🤬️ R*c*st level:1` `⚙️ Decryption tools: unluac-patched` `⚙️ Requirement: Java, text-editor that supports replacing newlines, (also some decryption tools, you will get it by patience and knowledge)`

	Ridicilous Arbitrary slow loading embedded on the script with 0 way to bypass that at all.
	Assembled, Obfuscated, Encrypted + the author bullying you in the code itself (even though he missed one thing... password, which is a good thing).

	OR AM I? its DECOMPILED, so he thought his encryption works like a charm, eh?

	this one is almost the same as the hydra wallhack ones, but simpler (if u successfully decompile the script and getting rid of nonsense stuff...)
	One thing to point put though, AGH put the string decryption thing on the top

	Thanks again to [tehtmi](https://sourceforge.net/u/tehtmi) for the patched unluac.

- `PB2_AGH_pb2mod1.lua` (or should i say `PB2_AGH_Mod1-unsanitized.lua`) (`『Alpha_ENC』Payback 2 Mod.lua` from [`MediaFire`](https://www.mediafire.com/file/py0v2idvgo35qi3/%25E3%2580%258EAlpha_ENC%25E3%2580%258FPayback_2_Mod.lua/file)), by "Alpha GG Hacker YT".

	`Difficulty: 20` `🔏️ Decryptor: tehtmi, ABJ4403` `🦠⚠️ Use it with caution` `🛡️ Obfuscation (level:17)` `🔒️ String Encryption (difficulty:29)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using "Serrang Gaming" lua encryption tool` `🤬️ R*c*st level:3` `❌️ Anti-decompiler` `❌️ Anti-LuaASM` `❌️ Different file encoding` `📝️ LUA Header modification` `🦠 GG Log Pollution & detection` `❌️ LUA Environment variable detection` `❌️ Debug variable detection` `⚙️ Decryption tools: unluac-patched, ghex, mousepad` `⚙️ Requirement: Java (to run unluac), text-editor that supports replacing newlines (eg. Mousepad), Hex editor (eg. Ghex)`

	WAY RIDICILOUS AND WAY WAY TOO MUCH IMPOSSIBLE!!!!!
	if you decompile this lua script with unluac or any other decompiler, it gives you almost nothing.

	BUT IS IT?
	[I asked tehtmi for help with this ridicilous nonsense](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42/#723e), and he gave a very good solution.

	Modify the file header with Hex editor, disassemble, remove op41,op42,op43,op44,op45, reassemble and decompile.
	no i wont reverse engineer this thing, because it will took a lot of time.
	BUT... HEY, atleast its decompiled :D

	and "my malware analysis research" says... its kinda in the red zone... because it does almost what usual gg script not doing and usual lua malware doing.
	so dont use it, atleast the encrypted ones...

- `PB2_AGH_CarSpeed_(C_BSS,A,O).lua` (`.lua` from [`MediaFire1`](https://www.mediafire.com/file/k2ne3i36wr6ovca/Car_Hack__%255B%255B_EncAGH_%255D%255D.lua/file),[`MediaFire2`](https://www.mediafire.com/file/de8idnxf9zm221f/Car_Hack_ANO__%255B%255B_EncAGH_%255D%255D.lua/file),[`MediaFire3`](https://www.mediafire.com/file/viuaklm73v1cbu9/Car_Hack_OTH__%255B%255B_EncAGH_%255D%255D.lua/file)), by AlphaGGHacker.

	`Difficulty: 4` `🔏️ Decryptor: ABJ4403` `🦠 Safe` `🛡️ Obfuscation (level:2)` `🔐️String Encryption (difficulty:2)` `📈️ Function argument overflow` `🛡️ Using "AlphaGG" lua encryption tool` `✏️ Bytecode modification` `⚙️ Decryption tools: unluac-patched` `⚙️ Requirement: Java, Unluac-patched`

	Theres's 3 files to decompile
	Atleast it was easier than the Serrang Gaming encryption ones.
	It's already decrypted (this time without tehtmi help), because its still the same "AlphaGG" encryption tool, that can be decrypted.
	thankfully, AlphaGG didnt see this and didnt learn his failures.
	i know, there is still some confusion stuff whatever, but hey atleast i can put the "Safe" label there, because yes its actually safe like the previous script (no, not the one with SerrangGaming encryption tool).
	btw, script password: alphaencmodz100yt

- `PB2_JokerGGScripterV1.lua` (`PB2_JokerGGScripterSV1.lua` from [`MediaFire`](https://www.mediafire.com/file/enpsqtcy8ub6z19/JokerGGScripterSV1.lua/file)), by "JokerGGS".

	`Difficulty: 10` `🔏️ Decryptor: ABJ4403` `🦠⚠️ Should be careful (doing io opreation)` `🛡️ Obfuscation (level:20)` `🔒️ String Encryption (difficulty:24)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using "PGv3" lua encryption tool` `❌️ Anti-decompiler` `❌️ Anti-LuaASM` `❌️ Different file encoding` `🦠 GG Log Pollution` `uses _ENV (Lua environment) variable` `❌️ Debug variable detection`

	Wow... this one is a bit simpler than Serrang Gaming, but the string encryption... too hard man... too hard wow i didnt expect this one (nah tehtmi wouldnt help with this, he only helps with decompiling, not decryption. i dont have a people which can help me in decrypting this satanic nonsense)
	Thankfully atleast i can decompile this easy as pie, just use patched-unluac lmfaooo (atleast PGv3 didnt use header modification).
	also i disabled the log pollution and all the nonsense on the decompiled version, so anyone that really wants to reverse enginner the numbers slightly easier way can just press random button and look on what it searches for.
	btw, password is "JokerGGScripter" (it might be wrong, because JokerGGS censors the password)

- `PB2_AGH-GGScript-OTHER.lua` (`` from `MediaFire` (LINK NO LONGER OBTAINABLE DUE TO CHANNEL BEING BANNED)), by AlphaGGHacker

	`Difficulty: 10` `🔏️ Decryptor: ABJ4403` `🦠⚠️ SG Encryption is known for doing malicious operations` `🛡️ Obfuscation (level:20)` `🔒️ String Encryption (difficulty:24)` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `🛡️ Using AGH,SG,PGv? lua encryption tool` `❌️ Anti-decompiler` `❌️ Anti-LuaASM` `❌️ Different file encoding` `🦠 GG Log Pollution & detection` `uses _ENV (Lua environment) variable` `❌️ Debug variable detection`

	Ahh yet *finally* AGH learned his failure and now he's combining AGH,SG,PGv? encryption and uses it as his new 'encryption' toolbox.
	so i wont decrypt this, why you might ask? because i modified the script assembly to eliminate almost all log spam, and what do you know dude? i got all the values with gg listItems, and gg script logging
	if you want to use this, only use the reasmv1.lua script (on the 7z file)
	the difference is that reasmv1 eliminates almost all log spams, and getting rid of message nonsense, and the log detection thing (just increase the 5.7777999blabla value near `LOG"` on the assembly file)
	btw this is the last script he shared before youtube terminates his channel

- `Pb2Kgo1.lua` (`𝙿𝙰𝚈𝙱𝙰𝙲𝙺_2_𝙼𝙴𝙽𝚄🇰 🇬 🇴 🇻 🇮 🇵 𝙼𝙾𝙳+🇩 🇴 🇱 🇬 𝚈𝚃_txt_ENCKILLER_GAMING.lua`, from Private Means), By Killer Gaming Official

	`Difficulty: 20` `Compiled Binary` `BigLASM` `Anti-reassemble (Removed .upval & RETURN)`

	I really wanted some of the cheats in here, but they're not using gg.REGION_OTHER
	and its so hard to decrypt this script

### you can find these files by downloading the 7z archives in the "encrypted" folder (the 7z archive isn't password-protected like you would expect)

# Warning:
**Use the assembled/obfuscated/encrypted script AT YOUR OWN RISK!!! I don't ever know if there is a MALWARE IN THESE SCRIPT or not.**

# Why i make this?
Because its VERY HARD to find these scripts dude...
Once found it will be preserved just in case its gone,
like AGH channel and all of his scripts

# Decompiler/Decryptor resources:
- [my own LuaTools](https://github.com/ABJ4403/LuaTools)
- [unluac Discussion about decompiling AGH script (im the one that reports these lool) + older patched unluac](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42)
- [unluac - `Common` Decompiler for LUA v5.x](https://sourceforge.net/projects/unluac)
- [unluac_patch - Custom patched version of (older) unluac with modified non-standard OPCODES](https://sourceforge.net/p/unluac/discussion/general/thread/88e9b323cc)
- [LuaDec - LUA Decompiler for lua v5.1-3](https://github.com/viruscamp/luadec)
- [ChunkSpy - LUA Chuck inspector/dissasembler](https://github.com/viruscamp/luadec/blob/master/ChunkSpy)

# Challenge for decryptors
i will give a challenge here for decryptors. anyone that can decrypt these scripts and send it to me (not just some showcase pay shit, cuz were foss (open-source) community here, people's here are donated not paid, aka. paying is optional), i will give EXCLUSIVE `decryptor` credit on GitHub Main ReadMe section and script_collection Readme section (yeah i dont hav money so that is the only thing i can pay for lol)