<h1> <img src="https://i.imgur.com/UIQSMEs.png" height=45> Risk of Rain 2 dockerized server </h1>
 
[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)](https://hub.docker.com/r/avivace/ror2server)

Host your Risk of Rain 2 dedicated server anywhere using Docker. Powered by Wine and the X virtual framebuffer to seamlessy run on Linux machines.

[Guide on Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=2077564253).


## Quickstart

Assuming you have [Docker](https://docs.docker.com/get-docker/) installed, on the server:

```bash
docker run -p 27015:27015/udp avivace/ror2server:latest
```

Players need to start Risk of Rain 2, open the console pressing <kbd>CTRL</kbd> + <kbd>ALT</kbd> + <kbd>\`</kbd> and insert this command:

```
connect "SERVER_IP:27015";
```

Replace `SERVER_IP` with the public IP of the server running the Docker Image.

By default, the server has no password and runs on UDP port 27015. 

## Customize configuration

If you want to start the server on port **25000** with password **hello**:

```
docker run -p 25000:27015/udp -e R2_PSW='hello' avivace/ror2server:latest
```

Players will then join with:

```
cl_password "hello"; connect "SERVER_IP:25000";
```

You can pass these additional environment variables to customise your server configuration:

- `R2_PLAYERS`, the maximum number of players;
- `R2_HEARTBEAT`, set to `1` to advertise to the master server and list your server in the internal server browser. If you enable this, append `-p 27016:27016` to your Docker command;
- `R2_QUERY_PORT`, the listen port for the steamworks connection, needed to list the server in the game browser on a alternate port, you need to add -p port:port to your Docker command;
- `R2_SV_PORT`, the listen port for the game server, needed to list the server in the game browser on a alternate port, you need to add -p port:port to your Docker command;
- `R2_HOSTNAME`, the name that will appear in the server browser;
- `R2_PSW`, the password someone must provide to join this server;
- `R2_ENABLE_MODS`, set to `1` to enable mod support (given you mounted the mod folders as described below).

Append one or more `-e VARIABLENAME=VALUE` to your Docker command to set environment variables.

## Mod support

To install and enable mods server side, you'll need a directory containing:

- The **BepInEx** folder with the desired mods
- The `doorstop_config.ini` and `winhttp.dll` files, both shipped with the BepInEx version you intend to use

Supposing your mod directory is in `/path/to/directory`, you can start your server as follows:

```bash
docker run -p 27015:27015/udp -v /path/to/directory:/home/steam/ror2-dedicated/mods -e R2_ENABLE_MODS=1 avivace/ror2server:latest
```

## FAQ

##### Can I run this on a VPS?

Yes, any Linux box works. For decent performance, you need 3 GB of free space and at least 2 GB of RAM.

##### Server is stuck at "Unloading unused Assets"

That line is usually the last one of the initialization process. It usually means your server is working correctly, that is not a blocking error. If you can't connect to your server at that point, it's probably a network issue.

##### Server is stuck at "Could not load config ..."

If you see something like this:

```
Could not load config /Config/server_pregame.cfg: Could not find file "Z:\home\steam\ror2-dedicated\Risk of Rain 2_Data\Config\server_pregame.cfg"
```

Beware that this kind of warning messages is non blocking, they are just warnings and the server initialization will proceed as normal.

### Acknowledgements

Thanks to [InfernalPlacebo](https://github.com/InfernalPlacebo) and [Vam-Jam](https://github.com/Vam-Jam).

Built by [Manuele](https://github.com/dubvulture), [Davide Casella](https://github.com/dcasella), [Fabio Nicolini](https://github.com/fnicolini), [Antonio Vivace](https://github.com/avivace).

### Development commands

```bash
git clone https://github.com/avivace/ror2-server
cd ror2-server
docker build -t ror2ds .
docker run --rm -d -p 27015:27015/udp --name ror2-server ror2ds

# See container output with:
docker logs -f ror2-server

# Open console in RoR
wmctrl -R Risk && xdotool key ctrl+alt+grave
```
