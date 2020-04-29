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
cl_password ""; connect "SERVER_IP:27015";
```

Replace `SERVER_IP` with the public IP of the server running the Docker Image.

By default, the server has no password and runs on UDP port 27015. 

## Customize configuration

You can pass these environment variables to customise your server configuration:

- `R2_PLAYERS` - The maximum number of players
- `R2_HEARTHBEAT` - Set to 0 to not advertise to the master server
- `R2_HOSTNAME` - The name that will appear in the server browser
- `R2_PORT` - The port that the server will bind to. You cannot have multiple server instances with overlapping ports
- `R2_PSW` - The password someone must provide to join this server

So, if you want to start the server on port 25000 with password `hello`:

```
docker run avivace/ror2server:0.1 -p 25000:25000/udp -e R2_PORT='25000' -e R2_PSW='hello'
```

Then join with:

```
cl_password "hello"; connect "SERVER_IP:25000";
```

## FAQ

##### Can I run this on a VPS?

Yes, any Linux box works. For decent performance, you need 3GB of free space and at least 2 GB of RAM.

## Develop

```bash
git clone https://github.com/avivace/ror2-server
cd ror2-server
docker build -t ror2ds .
docker run --rm -d -p 27015:27015/udp --name ror2-server ror2ds
```

For some reason, `winecfg` returns before completing the creation of the configuration files, making any subsequent call of `xvfb` fail. Current (trash) workaround is to just wait 5 seconds before firing the wine in the virtual framebuffer.

Built by [Davide Casella](https://github.com/dcasella), [Fabio Nicolini](https://github.com/fnicolini), [Antonio Vivace](https://github.com/avivace)
