#!/bin/bash

echo "Installing Risk of Rain 2 server..."
"${STEAMCMD}" +force_install_dir "${STEAMAPPDIR}" +login anonymous +@sSteamCmdForcePlatformType windows +app_update "${STEAMAPPID}" +quit

echo "Generating server configuration..."
envsubst < "default_config.cfg" > "${STEAMAPPDIR}/Risk of Rain 2_Data/Config/server.cfg"

if [ "${R2_ENABLE_MODS}" = 1 ]; then
    echo "Setting up mods..."
    rm -rf "${STEAMAPPDIR}/BepInEx"
    cp -r  "${MODDIR}/BepInEx"             "${STEAMAPPDIR}/BepInEx"
    cp     "${MODDIR}/doorstop_config.ini" "${STEAMAPPDIR}/doorstop_config.ini"
    cp     "${MODDIR}/winhttp.dll"         "${STEAMAPPDIR}/winhttp.dll"
    DLL="winhttp=n,b"
fi

echo "Generating initial Wine configuration..."
winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
WINEDLLOVERRIDES=${DLL} xvfb-run wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
