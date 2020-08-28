###########################################################
# Dockerfile that sets up a Risk of Rain 2 server
###########################################################
FROM cm2network/steamcmd:root

LABEL authors="Fabio Nicolini <fabionicolini48@gmail.com>, Antonio Vivace <antonio@avivace.com>"

ENV STEAMAPPID 1180760
ENV STEAMAPPDIR /home/steam/ror2-dedicated

# Default server parameters
ENV R2_PLAYERS 4
ENV R2_HEARTBEAT 0
ENV R2_HOSTNAME "A Risk of Rain 2 dedicated server"
ENV R2_PSW ""
ENV R2_ENABLE_MODS false

# Prepare the environment
# We need Wine 3 and xvfb
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		gnupg2 \
		xauth \
		gettext \
		winbind \
	&& wget -nc https://dl.winehq.org/wine-builds/winehq.key \
	&& apt-key add winehq.key \
	&& echo "deb https://dl.winehq.org/wine-builds/debian/ buster main" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		xvfb \
		lib32gcc1 \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable-amd64=3.0.1~buster \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable-i386=3.0.1~buster \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable=3.0.1~buster \
	&& mkdir -p ${STEAMAPPDIR} \
	&& chown -R steam:steam ${STEAMAPPDIR} \
	&& ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} \
		+@sSteamCmdForcePlatformType windows +app_update ${STEAMAPPID} +quit \
	&& ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir /home/steam/steamworks_sdk \
		+@sSteamCmdForcePlatformType windows +app_update 1007 +quit \
	&& cp /home/steam/steamworks_sdk/*64.dll ${STEAMAPPDIR}/ \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER steam

COPY --chown=steam:root entry.sh ${STEAMAPPDIR}/entry.sh
COPY --chown=steam:root default_config.cfg ${STEAMAPPDIR}/default_config.cfg

WORKDIR ${STEAMAPPDIR}

VOLUME ${STEAMAPPDIR}

# Start the server
ENTRYPOINT ${STEAMAPPDIR}/entry.sh

# Expose ports
EXPOSE 27015/udp
