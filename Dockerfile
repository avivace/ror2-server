###########################################################
# Dockerfile that sets up a Risk of Rain 2 server
###########################################################
FROM cm2network/steamcmd:root

LABEL authors="Fabio Nicolini <fabionicolini48@gmail.com>, Antonio Vivace <antonio@avivace.com>"

ENV STEAMAPPID 1180760
ENV STEAMAPPDIR /home/steam/ror2-dedicated

COPY entry.sh ${STEAMAPPDIR}/entry.sh

# Prepare the environment
# We need Wine 3 and xvfb
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		gnupg2 \
		xauth \
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
	&& chown -R steam:steam ${STEAMAPPDIR} \
	&& ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} \
		+@sSteamCmdForcePlatformType windows +app_update ${STEAMAPPID} +quit \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER steam

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR

# Start the server
ENTRYPOINT ${STEAMAPPDIR}/entry.sh

# Expose ports
EXPOSE 27015/tcp 27015/udp
