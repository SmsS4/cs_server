#!/bin/bash
CSGO_PATH="/home/ubuntu/steam/csgo_server/"
STEAM_PATH="/home/ubuntu/steam/"
PASS=123
RCON_PASS=123
FPS_MAX=200
TICK_RATE=64
PORT=27015
CLIENT_PORT=27005
MAX_PLAYERS=10
GAMETYPE=0
GAMEMODE=1
MAPGROUP="mg_active"
STARTMAP="de_inferno"
TOKEN="4AE6FD70DCF087131F429E04F2671149"
HOST_WORKSHOP_COLLECTION=0
WORKSHOP_START_MAP=0
WORKSHOP_AUTHKEY="424609C48B29C862B9EECCF8DC41BD44"

bash "${STEAM_PATH}steamcmd.sh" +login anonymous +force_install_dir "${CSGO_PATH}" +app_update 740 validate +quit
# Check if autoexec file exists. Easier to copy config between servers. (I was migrating when I wrote this)
# Passing them directly to srcds_run to ignores values set in autoexec.cfg.
autoexec_file="${CSGO_PATH}/csgo/cfg/autoexec.cfg"
# Overwritable arguments
ow_args=""

if [ -f "$autoexec_file" ]; then
        # TAB delimited name    default
        # HERE doc to not add extra file
        while IFS=$'\t' read -r name default
        do
                if ! grep -q "^\s*$name" "$autoexec_file"; then
                        ow_args="${ow_args} $default"
                fi
        done <<EOM
sv_password     +sv_password "${PASS}"
rcon_password   +rcon_password "${RCON_PASS}"
EOM

fi
cd "${CSGO_PATH}"
bash "srcds_run" -game csgo -console -autoupdate \
                        -steam_dir "${STEAM_PATH}" \
                        -steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
                        -usercon \
                        +fps_max "${FPSMAX}" \
                        -tickrate "${TICK_RATE}" \
                        -port "${PORT}" \
                        +clientport "${CLIENT_PORT}" \
                        -maxplayers_override "${MAX_PLAYERS}" \
                        +game_type "${GAMETYPE}" \
                        +game_mode "${GAMEMODE}" \
                        +mapgroup "${MAPGROUP}" \
                        +map "${STARTMAP}" \
                        +sv_setsteamaccount "${TOKEN}" \
                        +net_public_adr "0" \
                        -ip "0" \
                        +host_workshop_collection "${HOST_WORKSHOP_COLLECTION}" \
                        +workshop_start_map "${WORKSHOP_START_MAP}" \
                        -authkey "${WORKSHOP_AUTHKEY}" \
                        +exec "autoexec.cfg" \
                        "${ow_args}" \
