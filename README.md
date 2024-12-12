# SUPER METROID REDUX

## **Index**

* [**Super Metroid Redux Info**](#super-metroid-redux)

* [**Changelog**](#changelog)

* [**Optional Patches**](#optional-patches)

* [**Redux Widescreen Patch**](#redux-widescreen-patch)

* [**Compilation**](#compilation)

* [**Patch & Use Instructions**](#instructions)

* [**Credits**](#credits)

* [**Project Licence**](#license)


-------------------

## Super Metroid Redux

"Super Metroid Redux" is a personal hack of "Super Metroid (U)" with QoL features ported over from hacks of the Metroid Construction website, more specifically, this is based on ["Project Base" v0.7.2 by Begrimed](https://forum.metroidconstruction.com/index.php/topic,217.0.html) and [Control Freak by Kejardon](https://www.romhacking.net/hacks/405/). Besides those two hacks, a lot of other further modifications and improvements have been implemented from other Super Metroid hacks as well as original hacks for this project.

Follow the GitHub repository for the full source code of the project:
https://github.com/ShadowOne333/Super-Metroid-Redux


-------------------

## Changelog


* Project Base:
	- General movement is less inhibited, with many new tricks made possible
	- Heavier physics to closely resemble that of the GBA games
	- Faster elevators, doors, room transitions and item-collection sequences
	- Bug fixes and polish applied whenever possible
	- RESPIN – press jump at any time during a normal fall to resume spinning
	- BOMB SKIP – hold down to avoid bomb jumping
	- QUICK MORPH – hold X-Ray + press down to instantly morph while in air.
	- DEMORPH JUMP – until Spring Ball is equipped, holding run allows spin-jumping straight out of ball form
	- SPEED BALL – with Spring Ball equipped, Samus gains the ability to run at full speed as a ball
	- SPIN FALL – hold jump as you fall from a ledge to flip automatically
	- Beam travelling and firing speeds adjusted, auto-fire speed increased
	- Charge beam draws energy and ammo drops from enemies toward you, also charges slightly faster
	- Speed Booster has become a major power-up with several huge limitations removed
	- Horizontal shinesparks can be exited into a full-speed run when Samus touches a slope
	- Space Jump no longer stops working after you’ve fallen too far
	- Missiles and super missiles can be fired faster
	- Super missiles can be fired straight down while in the air to propel Samus upward
	- X-Ray Scope speed increased
	- Bomb timer shortened
	- Underwater wall jumping and bomb jumping enabled
	- Running speed no longer resets after jumping or falling


* Control Freak:
	- Run is now toggleable between Run and Walk.
	- Moonwalk has been deleted, and the setting is now used to toggle Auto Run.
	- Aim Up is now the only aim button, ‘Aimlock’. Holding it will make Samus aim at a certain angle, and aim higher or lower if you tap up or down.
	- 'Aimlock' has been modified so that aiming diagonally and aiming up now behaves similar to that of Zero Mission / Fusion.
	- Select Item is still used to select missiles, super missiles or the grapple beam. It no longer selects X-ray nor Power Bombs; X-Ray now has its own button and Power Bomb is highlighted automatically when in Morph Ball and pressing Brandish. Beams can still be used at any time, even when missiles and super missiles are selected.
	- Item cancel has also been removed, as it now activates the x-ray scope.
	- Aim Down has become Brandish, which, when held, will toggle between Beams and the item currently selected. This is somewhat... abusable.
	- Powerbomb attacks are also now easy to control, just tap Brandish when you want to trigger them while in Morph Ball.
	- Spinjump controls have also been improved a bit - Walljumping should be a bit easier on a d-pad, and Samus will fire in the direction you’re pressing instead of just forward, if you press fire.
	- The controls are configurable to ANY combination. Aim is not limited to L and R.


* Redux:
	- Missile doors now require only 1 missile shot to be opened like in Zero Mission / Fusion, instead of the original 5 from Super Metroid.
	- New HUD changes: Missiles selected will be highlighted in GREEN. If you press Select, Super Missiles will be in GREEN while normal missiles will appear in grey. Pressing Select again will highlight the Grapple Beam in GREEN. Only when the Brandish button is pressed, the selected item will change its icon to YELLOW. The same applies for Power Bombs, they will always be highlighted in green, and only when Brandish is selected they will be YELLOW.
	- New Run code: sylandro made a new Run ASM code to make the Running of Samus much more similar to that of Zero Mission and Fusion. If you have Auto-Run enabled, Samus will now wait some time until she starts gaining up speed into Boost, similar to the following entries on the franchise.
	- A lot of features from Project Base 0.7.3 have been implemented. (Like faster door transitions and speeds, instant Bomb explosion by holding Down on the D-Pad, Game time and Item percentage can now be seen in the Pause menu, etc).
	- Normal and Hard mode can be toggled within the "Difficulty Settings" before selecting a save file (NOTE: The difficulty change can ONLY be enabled when starting a New Game, by Sylandro)
	- Special Demo sequences that depict useful tricks and abilities (from SM Turbo)
	- Message boxes can be skipped by pressing a button
	- Screw Attack now destroys frozen enemies (by Adamf)
	- X-Ray Visor range widened
	- Unlock Tourian patch has been completely fixed, so it doesn’t play the Super Metroid eating the side-hopper cutscene every time you go through that room on Tourian. Now the game only plays that scene the first time you go through it, sets a correct flag, and the Super Metroid and its two adjacent rooms will play the normal Tourian theme AFTER the cutscene has already happened (shoutouts to Smiley, PJBoy and the people from the Metroid Construction Discord for the help)
	- Charge Beam combos can be triggered by fully charging your beam with the beam of choice, and then pressing Select
	- Crystal Flash is still enabled like in the original game
	- Elevator Speed has been increased to double the speed of the original in Super Metroid
	- MSU-1 playback integrated
	- Missile Stations have now been changed to Recharge Stations. They now refill your entire weapons’ stack (Missiles, Super Missiles, Power Bombs) upon touching them with the message "Weapons Reload Completed." (similar to Zero Mission / Fusion)
	- Power Bombs reveal hidden tiles (like in Zero Mission / Fusion)
	- Fanfare music for normal expansion tanks (Missiles, Super Missiles, Power Bombs, Energy and Reserve Tanks) now use a special SFX when grabbed which is shorter, to allow for a more fluid play session. Main items like beams, suits, and the first main Missile/Super Missile/Power Bomb items still play the long-normal fanfare (similar to Zero Mission / Fusion)
	- Combined DC’s Map Patch with Scyzer’s Item Circles code to create a meticulously completely revamped Map system to be more in-line or similar to what is seen in both Zero Mission / Fusion. (Entrances, colour-coded doors, item circles/dots, etc). 

-------------------

## Optional patches

1. **Classic Booster.ips**: From Project Base 0.7.3, restores the speed at which the shinespark is activated to be the same as vanilla Super Metroid. NOTE: This breaks a few title screen demos.
2. **Death Censor.ips**: From Project Base 0.7.3, censors the death animations of Samus upon game over.
3. **Default X-Ray.ips**: Change the X-Ray Visor width to that of the original Super Metroid
4. **Dual Suit (Proper Power Suit).ips**: Gives Samus an entirely different set of graphics for her Power Suit form, to match the Power Suit design and form seen in other Metroid games. The shoulder pads are only enabled when the Varia or Gravity suits are acquired or toggled on.
5. **Fixed Tourian Unlocked Doors.ips**: Makes it so that the Tourian doors now let you go back to Crateria normally. (NOTE: This patch is ALREADY implemented into main Redux, it was simply added for archival purposes).
6. **Heavy Physics.ips** (From GBA Style): This will make it so that Samus now lands faster and with more gravity to her, similar to that of the GBA Metroids. Bomb jumping has been fixed for the new physics, and also the Title Screen Demos were re-recorded so they work properly with the new physics
7. **Original Title Screen Demos**: This includes two patches, "Original Demos (Redux Only).ips" restores the original Demos from vanilla Super Metroid into Redux; and "Original Demos (Heavy Physics Only).ips" (already includes the "Heavy Physics" patch) restores the original Demos from vanilla Super Metroid alongside the Heavy Physics patch.
8. **Original Elevator Speed.ips**: Restores the original Super Metroid elevator speeds
9. **Redesigned Samus.ips**: Modifies Samus’ sprite slightly to have a better arm cannon and some slight suit touchups. "Redesigned Dual Suit" should be applied ONLy after "Redesigned Samus.ips". This makes Samus’ have separate graphics when she’s on her Power Suit, and modifies the arm cannon on the Power Suit to match those of the Varia Suit graphics for Redesigned
10. **Save Stations Refill Everything.ips**: Save Stations will now refill both Energy and all Weapons (by Adamf)
11. **Skip Ceres - Start In Zebes.ips**: Skip the Ceres Station sequence at the beginning, and start off directly on Planet Zebes’ Landing Site on New Game
12. **Spazer Plasma Mix (v0.998).ips**: Be able to combine both the Spazer Beam alongside the Plasma Beam (by JAM). The original v0.997 patch by JAM had a bug in which Phantoon couldn’t be damaged with Missiles nor Super Missiles, this has been fixed by me and made a new v0.998 version of the patch with the fix to Phantoon’s vulnerabiliy table with SMILE RF. NOTE: There are graphical issues when using this patch.
13. **Vanilla Beam Cooldowns.ips**: In Redux, the normal Beam shots that Samus does before obtaining the Charge beam have been modified to be faster, the same goes for some of the projectile speeds. This patch reverts those changes so the speed at which Samus can fire her beam, and the speed of the projectiles, are the same as in vanilla Super Metroid.
14. **Original Sand Physics.ips**: Restores the sand physics from the original Super Metroid. This makes it so that sequence breaking into Maridia from the other side isn't possible. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
15. **Original Underwater Walljump.ips**: Restores the original physics for walljumping while underwater to avoid sequence breaking Maridia. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
16. **No Boss Tiles on Map.ips**: Removes the Boss tiles from the Map to avoid spoiling any upcoming bosses while checking the map. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
17. **No Colored Doors on Map.ips**: Remove the colour-coded doors from the Map, like in the original Super Metroid. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
18. **Red Gate.ips** - Replaces the Green Gate from Maridia to Brinstar with a Red Gate that will stay open once activated. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
19. **Vanilla Button Mapping.ips** - Sets the face buttons back to the original default mapping. Also sets auto-run to off by default. This layout helps towards making the Run button more easier access. More information about this patch on [WittyPhoenix's repository here](https://github.com/wittyphoenix/WittyMetroidReduxPatches).
19. **New Control Scheme.ips** - ??? (I don't remember what this patch did nor its author, it was given to me but I forgot the actual changes it provides).
20. **Super Metroid Controls.ips** - ??? (Originally known as "Make Controls More Like Super Metroid", I don't remember what this patch did nor its author, it was given to me but I forgot the actual changes it provides).


-------------------

## Redux Widescreen Patch:

This is an special optional patch, developed by ocesse exclusively for Super Metroid Redux, based on his original Super Metroid Widescreen hack. The Widescreen patch should only be used with bsnes v10.2 or above, as it goes alongside bsnes’ Widescreen feature. Here’s a preview of the Widescreen hack by ocesse: https://www.youtube.com/watch?v=4XqJ_f3ui_w

Keep in mind that this patch is currently in a beta stage, so if you encounter any bugs or glitches, make sure to let ocesse know on his YouTube channel.

Make sure that once you have your Super Metroid Redux ROM already patched (alongside whatever optional patches you desire), you apply the Widescreen .IPS file over your ROM, and that’s all that should be needed!

-------------------

## Compilation

### Windows

For compilation on Windows, you need to download and install [CygWin](https://www.cygwin.com/).

When installing Cygwin, be sure to also install `git` from the list of packages available, or you won't be able to clone the repository from the source.

Once you have it installed, browse to the directory where you downloaded the source code, and start the same steps as the Linux compilation.

(I recompiled the scompress Windows EXE in Cygwin so it works properly with the Windows compilation)


### Linux

The source code was developed entirely on Linux (32bit), with armips being compiled from source to create the binary, same for FLIPS.

* Compiling the ROM:

1. Either download the source code as ZIP, or clone the repository by opening terminal and running `git clone https://github.com/ShadowOne333/Super-Metroid-Redux`. Put the downloaded files anywhere in your PC.

2. Grab your Super Metroid (USA) ROM with the name "Super Metroid (Japan, USA) (En,Ja).sfc" inside the "/rom/" folder.

3. Open terminal in your Linux distribution, browse to the same folder as the "make.sh" file, and modify its permissions to be an executable script file by doing the following:
	`sudo chmod +x make.sh`

4. If you want specific optional patches to be applied in your complation, open the `optional.asm` file inside /code/ and uncomment the `.include "xxxx"` file of the optional patch you desire to include during compilation.

5. Enjoy the hack!


----

## Instructions

To play Super Metroid Redux, the following is required:

* Snes9x 1.54.0 or above (any recent version of it should work)
* Super Metroid (Japan, USA) SNES ROM:

	Super Metroid (Japan, USA).sfc
	No-Intro: Super Nintendo Entertainment System (v. 20180813-062835)
	File/ROM SHA-1: DA957F0D63D14CB441D215462904C4FA8519C613
	File/ROM MD5: 21F3E98DF4780EE1C667B84E57D88675
	File/ROM CRC32: D63ED5F8

* Lunar IPS
* "Super Metroid Redux.ips" patch

Grab the patches from inside the /patches/ folder from the GitHub page, or alternatively, download the .zip file from the Releases page (once a proper release is out) and apply the patch over your Super Metroid ROM with Lunar IPS.
If you want to apply any of the optional patches, you can use each Optional patch individually from inside the /patches/optional folder depending on your liking over your already patched Super Metroid Redux ROM, or you can either compile them manually from the source code, although this is not recommended if you are not familiar with compilations or 65816 assembly.


-------------------

## Credits

* **ShadowOne333** - Main developer for "Super Metroid Redux".
* **PHOSPHOTiDYL** - PB+CF Initial ASM code and Transition tables, Item/Time Counters in Pause Menu and Others
* **sylandro** - ASM fixes, new HUD and new Run code, Hard mode & Rewrite of Item Circles code
* **begrimed** - Project Base: Original hack
* **Kejardon** - Control Freak: Original hack
* **DC** - Original Map Patch for Super Metroid
* **SadiztykFish (Scyzer)** - 	Original Map Item Circles & Item Sounds codes, and Save/Load hack
* **dex909** - Project Base's Nintedit fork
* **PJ Boy** - Super Metroid Disassembly and Kraid's graphics corruption fix after his fight
* **adamf** - Screw Attack Frozen Enemies and Save Refill codes
* **Smiley** - Help and debugging for Fixed Unlocked Tourian and New Item Circles code
* **Nodever2** - Bugfixes, Reserve Tanks bugfix and Tourian event flag fix
* **samsamcmoi** - Super Metroid Turbo hack, fixes to Control Freak tables and Introduction Skip
* **ocesse** - Super Metroid Redux Widescreen patch
* **Dmit Ryaz** - Samus Redesigned original patch
* **Benox50** - Pause map fix during Kraid's fight (caused by DC's Map patch)
* **HAM** - Suits Pickup fixes
* **Crashtour99** - Dual Suit hack
* **Starry_Melody** - Power Suit Samus graphics
* **wittyphoenix** - Original Sand Physics and Original Underwater Walljump optional patches, as well as the initial Reduce Map detail (which got separated into two by GoodLuckTrying), Red Gate and Vanilla button mapping patches.
* **GoodLuckTrying** - No Boss Tiles on Map and No Colored Doors on Map optional patches (Originally "Reduce Map Detail" by wittyphoenix).
* **???** - 'New Control Scheme' and 'Super Metroid Controls' optional patches. I can't remember what these two do nor who made them originally, if you know who made them, or you are the author that contacted and gave them to me, please let me know so I can add your name properly.
* **Metroid Construction** for all the great resources, forums and help towards this hack.

-------------------

## License

Super Metroid Redux is a project licensed under the terms of the GPLv3, which means that you are given legal permission to copy, distribute and/or modify this project, as long as:

1. The source for the available modified project is shared and also available to the public without exception.
2. The modified project subjects itself different naming convention, to differentiate it from the main and licensed Super Metroid Redux project.

You can find a copy of the license in the LICENSE file.

-------------------

