#!/bin/bash

echo "Updating Risk of Rain 2 server..."
"${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

echo "Generating initial wine configuration..."
/opt/wine-stable/bin/winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
