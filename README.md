<h1> <img src="https://i.imgur.com/UIQSMEs.png" height=45> Risk of Rain 2 dockerized server </h1>
 
[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)](https://hub.docker.com/r/avivace/ror2server)

Host your Risk of Rain 2 dedicated server anywhere using Docker. [Guide on Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=2077564253).

## Quickstart

Assuming you have [Docker](https://docs.docker.com/get-docker/) installed, on the server:

```bash
docker run avivace/ror2server:0.1 -p 27015:27015/udp
```

Players need to start Risk of Rain 2, open the console pressing CTRL + ALT + \` and insert this command:

```
connect "SERVER_IP:27015";
```

Replace `SERVER_IP` with the public IP of the server running the Docker Image.

By default, the server has no password and runs on UDP port 27015. 

## Customize configuration

If you want to start the server on port **25000** with password **hello**:

```
docker run avivace/ror2server:0.1 -p 25000:27015/udp -e R2_PSW='hello'
```

Players will then join with:

```
cl_password "hello"; connect "SERVER_IP:25000";
```

You can pass these additional environment variables to customise your server configuration:

- `R2_PLAYERS`, the maximum number of players
- `R2_HEARTHBEAT`, set to 0 to not advertise to the master server
- `R2_HOSTNAME`, the name that will appear in the server browser
- `R2_PSW`, the password someone must provide to join this server

## FAQ

##### Can I run this on a VPS?

Yes, any Linux box works. For decent performance, you need 3 GB of free space and at least 2 GB of RAM.

## Develop

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

### Known Issues

For some reason, `winecfg` returns before completing the creation of the configuration files, making any subsequent call of `xvfb` fail. Current (trash) workaround is to just wait 5 seconds before firing Wine in the virtual framebuffer.


Built by [Davide Casella](https://github.com/dcasella), [Fabio Nicolini](https://github.com/fnicolini), [Antonio Vivace](https://github.com/avivace)
