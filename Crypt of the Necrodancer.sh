#!/bin/bash

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

# Variables
GAMEDIR="/$directory/windows/necrodancer"
EXEC="NecroDancer.exe"

# CD and set log
cd $GAMEDIR/data
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Display loading splash
$ESUDO $GAMEDIR/splash "$GAMEDIR/splash.png" 20000 & 

# Exports
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"
export WINEDEBUG=-all

# Determine architecture
if file "$EXEC" | grep -q "PE32" && ! file "$EXEC" | grep -q "PE32+"; then
    export WINEARCH=win32
    export WINEPREFIX=~/.wine32
elif file "$EXEC" | grep -q "PE32+"; then
    export WINEPREFIX=~/.wine64
else
    echo "Unknown file format"
fi

# Install dependencies
if ! winetricks list-installed | grep -q "^dxvk2041$"; then
    pm_message "Installing dependencies."
    winetricks dxvk2041
fi

# Set gamepad bindings
source "$GAMEDIR/bindings"

# Run the game
$GPTOKEYB "$EXEC" xbox360 &
box64 wine "$EXEC"

# Kill processes
wineserver -k
pm_finish