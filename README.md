<h1> <img src="https://i.imgur.com/UIQSMEs.png" height=45> Risk of Rain 2 dockerized server </h1>

[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)](https://hub.docker.com/r/avivace/ror2server)


> [!CAUTION]
> This project relies on the official 'Risk of Rain 2 Dedicated Server' Steam app. Among all the other embarassing things Hopoo/Gearbox/Take-Two did to ruin this game, they also [stopped updating the dedicated server](https://steamdb.info/app/1180760/depots/?branch=public) in May 26, 2022. The only way to join an hosted dedicated server now is to [downgrade](https://github.com/risk-of-thunder/RoR2VersionSelector).


Host your Risk of Rain 2 dedicated server anywhere using Docker. Powered by Wine and the X virtual framebuffer to seamlessy run on Linux machines.

[Guide on Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=2077564253).


## Quickstart

You need [Docker](https://docs.docker.com/get-docker/) installed. On Debian systems, you can use the [bootstrap_debian.sh](https://github.com/avivace/ror2-server/blob/master/boostrap_debian.sh) script to set up Docker and some other dependencies.

Run the Docker container with:

```bash
docker run --rm -p 27015:27015/udp avivace/ror2server:latest
```

Players need to start Risk of Rain 2, open the console pressing <kbd>CTRL</kbd> + <kbd>ALT</kbd> + <kbd>\`</kbd> and insert this command:

```
connect "<SERVER_IP>:27015";
```

Replace `SERVER_IP` with the public IP of the server running the Docker Image.

By default, the server has no password and runs on UDP port 27015. Make sure you have crossplay disabled before joining.

## Customize configuration

If you want to start the server on port **25000** with password **hello**:

```
docker run -p 25000:25000/udp -e R2_SV_PORT=25000 -e R2_PSW='hello' avivace/ror2server:latest
```

Players will then join with:

```
cl_password "hello"; connect "<SERVER_IP>:25000";
```

You can pass these additional environment variables to customise your server configuration:

- `R2_PLAYERS`, the maximum number of players, default is 4;
- `R2_HEARTBEAT`, set to `1` to **advertise to the master server and list your server** in the internal server browser. If you enable this, add `-p 27016:27016/udp` to your Docker command;
- `R2_HOSTNAME`, the name that will appear in the server browser;
- `R2_PSW`, the password someone must provide to join this server;
- `R2_ENABLE_MODS`, set to `1` to enable mod support (given you mounted the mod folders as described [below](#mod-support));
- `R2_QUERY_PORT`, the listen port for the Steamworks connection, needed to list the server in the game browser on a alternate port, you need to add `-p <PORT>:<PORT>/udp` to your Docker command;
- `R2_SV_PORT`, the listen port for the game server, needed to list the server in the game browser on a alternate port, you also need to add `-p <PORT>:<PORT>/udp` to your Docker command.
- `R2_TAGS`, the tags the server will have in the server browser.
- `R2_GAMEMODE`, the type of gamemode for the run, defaulting to `ClassicRun`. Supported options:
    - `ClassicRun` (Standard)
    - `InfiniteTowerRun` (Simulacrum)

You shouldn't need to change `R2_QUERY_PORT` and `R2_SV_PORT` if you are not planning on hosting more server instances on the same machine/IP.

Append one or more `-e VARIABLENAME=VALUE` to your Docker command to set environment variables.

To check if your server is correctly getting announced to the Steamworks network, you can use this API call:

```bash
curl http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001/?format=json&addr=<IP_ADDRESS>
```
## Known Issues

Be aware that this version suffers from some [known issues](https://github.com/avivace/ror2-server/issues?q=is%3Aissue+is%3Aopen+label%3Abug), probably caused by the executable not running natively on Windows. You should probably [ask the developers](https://twitter.com/riskofrain) for a proper Linux build.

Since the RoR2 Server will be downloaded each time the docker container is started, there could be breaking changes which require more up to date versions of wine in order to work correctly. In this case you can try forcing the installation of bleeding-edge wine versions by running:
```bash
# wine-devel
docker run ${your_parameters} -e WINE_REPLACE_REL="devel" avivace/ror2server:latest
# wine-staging
docker run ${your_parameters} -e WINE_REPLACE_REL="staging" avivace/ror2server:latest
```

## Mod support

To install and enable mods server side, you'll need a directory containing:

- The **BepInEx** folder with the desired mods;
- The `doorstop_config.ini` and `winhttp.dll` files, both shipped with the BepInEx version you intend to use.

Supposing your mod directory is in `/path/to/directory`, you can start your server as follows:

```bash
docker run -p 27015:27015/udp -v /path/to/directory:/root/ror2ds-mods -e R2_ENABLE_MODS=1 avivace/ror2server:latest
```

Beware that some mods requires the client to also have them installed.

## FAQ

#### Can I run this on a VPS?

Yes, any Linux box works. For decent performance, you need 3 GB of free space and at least 2 GB of RAM.

#### Server crashes with "NullReferenceException"

Disable crossplay.

#### Server is stuck at "Unloading unused Assets"

That line is usually the last one of the initialization process. It usually means your server is working correctly, that is not a blocking error. If you can't connect to your server at that point, it's probably a network issue.


#### Server is stuck at "Could not load config ..."

If you see something like this:

```
Could not load config /Config/server_pregame.cfg: Could not find file "Z:\home\steam\ror2-dedicated\Risk of Rain 2_Data\Config\server_pregame.cfg"
```

Be aware that these kind of warning messages are non blocking, they are just warnings and the server initialization will proceed as normal.


### Acknowledgements

Thanks to [InfernalPlacebo](https://github.com/InfernalPlacebo) and [Vam-Jam](https://github.com/Vam-Jam).

Built by [Manuele](https://github.com/dubvulture), [Davide Casella](https://github.com/dcasella), [Fabio Nicolini](https://github.com/fnicolini), [Antonio Vivace](https://github.com/avivace).
