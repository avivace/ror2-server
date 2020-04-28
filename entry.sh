#!/bin/bash

${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} +@sSteamCmdForcePlatformType windows +app_update ${STEAMAPPID} +quit
cd ${STEAMAPPDIR}
xvfb-run /opt/wine-stable/bin/wine ./"Risk of Rain 2.exe"
