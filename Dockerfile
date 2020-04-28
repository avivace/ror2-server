###########################################################
# Dockerfile that builds a RoR2 Server
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="fabionicolini48@gmail.com"

ENV STEAMAPPID 1180760
ENV STEAMAPPDIR /home/steam/ror2-dedicated

COPY entry.sh ${STEAMAPPDIR}/entry.sh

# Install dependencies and run server
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		gnupg2 \
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
	&& ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} \
		+@sSteamCmdForcePlatformType windows +app_update ${STEAMAPPID} +quit \
	&& chmod 755 ${STEAMAPPDIR}/entry.sh \
	&& chown -R steam:steam ${STEAMAPPDIR} \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER steam

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR

ENTRYPOINT ${STEAMAPPDIR}/entry.sh

# Expose ports
EXPOSE 27015/tcp 27015/udp
