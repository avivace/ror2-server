#!/bin/bash

"${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

/opt/wine-stable/bin/winecfg
echo "Let's wait :)"
sleep 5
echo "ecoci qui"
xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
