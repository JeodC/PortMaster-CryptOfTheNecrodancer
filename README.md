# PortMaster Wine - Crypt of the Necrodancer
This is a port structure to run Cypt of the Necrodancer through wine64 and box64 via RockNIX on the Retroid Pocket 5 and Retroid Pocket Mini.

## Installation
Copy the `necrodancer` folder and `Crypt of the Necrodancer.sh` file to the same place you would normally place your port files e.g. `/roms/ports`. Purchase and install the GOG version and copy all of its data to `necrodancer/data`.

If you want to set up the emulationstation decorations, copy `cover.png` to the `necrodancer` folder and copy the contents of `gameinfo.xml` to your `gamelist.xml` file.

## Controller Bindings
The script uses a virtual xbox360 gamepad to force the game to use xbox glyphs in the HUD. A script sourced during launch checks the `save_data.xml` file and assigns matching keybinds for the Retroid Pocket 5 (Mini untested). It should be possible to import a `save_data.xml` file and use it with the RP5 this way.