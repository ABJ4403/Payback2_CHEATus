# What the heck is this directory?
This directory is a list of collection of Payback 2 cheat LUA Script for GameGuardian

# Lists:
### `FileName.lua` (`ActualFileName.lua`, from [`some website`]()), By Author <(uploaded by Uploader)>

- `PB2_Cheat-Mangyu.lua` ("PAYBACK2.lua", from [`MediaFire`](https://www.mediafire.com/file/9m1s41x7fjorzrf/PAYBACK2.lua/file)), By Mangyu (uploaded by "Latic AX")
- `PB2_ICE-Menu_v1.0.lua` ("{1.0} PB 2.lua", from [`MediaFire`](https://www.mediafire.com/file/o1kgc0xbcjdyzac/%7B1.0%7D+PB+2.lua/file)), By Crystal_Mods100x (uploaded by "Toxic Coder")
- `PB2_VIPTheSmat7Pro27-Mangyu.lua` (from [`MediaFire`](https://www.mediafire.com/file/6t6hy9cdszcezpr/%25E2%259C%25A8SCRIPT_PAYBACK2_VIP_THE_SMAT7_PRO_27%25E2%259C%25A8_.lua.7z/file), fork of Mangyu's script), by VIPTheSmat7Pro27

	`Difficulty: 2` `🔏️ Decryptor: ABJ4403` `🔐️ 7z+AES Encrypted` `⚙️ Decryption tools: none` `⚙️ Requirement: 7z`

	Encrypted in 7z format, Password: `LUA V1`. Where do i get this you say? from his video comment, because its in spanish i cant read it until i use Google Translate, everything revealed.
  Unfortunately, this script is just another modified version of Mangyu's cheat Script, didnt have any cheat changes except adding replacing `Mangyu` with his name `THE SMAT7 PRO 27`, adding more bloat and stuff.

- `PB2_GKTV_v1.lua` (`Payback 2 - CHEAT [V1].lua` from [`MediaFire`](https://www.mediafire.com/file/hros99ssjzmkp00/Payback_2_-_CHEAT_%255BV1%255D.lua/file)), by GKTV (now "Pumpkin Hacker")

	`Difficulty: 2` `🔏️ Decryptor: MDP43140` `💾️ Compiled binary` `💧️ Leaks variables` `⚙️ Decryption tools: Custom Patched unluac` `⚙️ Requirement: Java`

	Thankfully unlike others, this one is a bit easy. i cant decrypt this using unluac/luadec, i just need the patched custom unluac that has modified non-standard OPCodes.
	Then it works
	
- `PB2_Hydra-WallHack.lua` (`WALL HACK payback2.lua` from [`MediaFire`](https://www.mediafire.com/file/2xekhqk3tsvwq69/WALL+HACK+payback2.lua/file)), by Hydra.

	`Difficulty: 3` `🔏️ Decryptor: ABJ4403, tehtmi` `🛡️ Obfuscation` `🔐️ Built-in lock` `📈️ Function argument overflow` `Bytecode modification` `Decompression bomb` `❌️ Anti-decompiler` `⚙️ Decryption tools: unluac` `⚙️ Requirement: Java, text-editor that supports replacing newlines`

  Finally i had this file decrypted, Thank you tehtmi (Unluac developer) for some decryption stuff.
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
  both fills the script alot and confuses unluac, eats ~100-200kb size. just disassemble the file, remove all that above, reassemble the file, and decompile it again, it will work.

## HELP WANTED decryption:
anyone can decrypt these files?
- `PB2_AlphaGGHackerYT_simplescriptv1.lua` (`Payback 2 ❰ ☠ ᴇɴᴄ ☠ ❱` from [`MediaFire`](https://www.mediafire.com/file/og6r5ppblfzd36s/Payback_2__%25E2%259D%25B0_%25E2%2598%25A0_%25E1%25B4%2587%25C9%25B4%25E1%25B4%2584_%25E2%2598%25A0_%25E2%259D%25B1.lua/file)), by "Alpha GG Hacker YT".

	`Difficulty: 4` `🛡️ Obfuscation` `🔒️ Built-in Encryption` `💾️ Assembly Compiled binary` `📈️ Function argument overflow` `❌️ Anti-decompiler` `🤬️ R*c*st`

	Ridicilous Arbitrary slow loading embedded on the script with 0 way to bypass that at all.

	Assembled, Obfuscated, Encrypted. All that + the author bullying you in the code itself (the text says `N O O B   D E C R Y P T   ( F * * *   Y O U )` on the end of the raw binary file, and `NoTouchyTouchy`,`OopsSorry` when disassembling the file).
	
	Yeah... looks like he's flexing on his `🛡️🔒🛡️ new proprietary PHILIPPINES's super 👹️ic 666 military-grade encryption 🛡️🔒🛡️` that wont even launch the script at all (yes i cant open the script because the encryption was too much even for gameguardian itself lol XD)

I can't upload these encrypted files due to unknown CORS failure when trying to upload to GitHub (idk why, maybe because github is using external stuff...)

# Warning:
**Use the assembled/obfuscated/encrypted script AT YOUR OWN RISK!!! I don't ever know if there is a MALWARE IN THESE SCRIPT or not.**

# Why i make this?
Because its VERY HARD to find these scripts dude...

# Decompiler/Decryptor resources:
- [unluac Discussion about decrypting nonsense (im the one that reports these lool)](https://sourceforge.net/p/unluac/discussion/general/thread/904dee6a42)
- [unluac - `Common` Decompiler for LUA v5.x](https://sourceforge.net/projects/unluac)
- [unluac_patch - Custom patched version of (older) unluac with modified non-standard OPCODES (works with some GameGuardian scripts)](https://sourceforge.net/p/unluac/discussion/general/thread/88e9b323cc)
- [LuaDec - LUA Decompiler for lua v5.1-3](https://github.com/viruscamp/luadec)
- [ChunkSpy - LUA Chuck inspector/dissasembler](https://github.com/viruscamp/luadec/blob/master/ChunkSpy)

# Challenge for decryptors
i will give a challenge here for decryptors. anyone that can decrypt these scripts and send it to me (not just some showcase pay shit, cuz were foss (open-source) community here, people's here are donated not paid, aka. paying is optional), i will give EXCLUSIVE `decryptor` credit on GitHub Main ReadMe section and script_collection Readme section (yeah i dont hav money so that is the only thing i can pay for lol)
