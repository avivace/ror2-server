<h1> <img src="https://i.imgur.com/Ucg7IQI.png" height=45> Risk of Rain 2 dockerized server </h1>
 
[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)](https://hub.docker.com/r/avivace/ror2server)

Host your Risk of Rain 2 dedicated server anywhere using Docker. [Guide on Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=2077564253).

Assuming you have [Docker](https://docs.docker.com/get-docker/) installed, on the server:

```bash
docker run avivace/ror2server:0.1 -p 27015:27015 -p 27015:27015/udp
```

Players need to start Risk of Rain 2, open the console pressing CTRL + ALT + \` and insert this command:

```
cl_password ""; connect "SERVER_IP:27015";
```

Replace `SERVER_IP` with the public IP of the server running the Docker Image.

By default, the server has no password and runs on port 27015. To set a custom port and a password, pass the ENV variables `port` and `psw`, e.g.

```
TODO
```

Then join with:

```
cl_password "PASSWORD"; connect "SERVER_IP:SERVER_PORT";
```

## FAQ

##### Can I run this on a VPS?

Yes, any Linux box works. For decent performance, you need 3GB of free space and at least 2 GB of RAM.

## Develop

```bash
git clone https://github.com/avivace/ror2-server
cd ror2-server
docker build -t ror2ds .
docker run --rm -d -p 27015:27015 -p 27015:27015/udp --name ror2-server ror2ds
```

For some reason, `winecfg` returns before completing the creation of the configuration files, making any subsequent call of `xvfb` fail. Current (trash) workaround is to just wait 5 seconds before firing the wine in the virtual framebuffer.

Built by [Davide Casella](https://github.com/dcasella), [Fabio Nicolini](https://github.com/fnicolini), [Antonio Vivace](https://github.com/avivace)
