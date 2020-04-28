#!/bin/bash

"${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
