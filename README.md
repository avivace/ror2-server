
# Risk of Rain 2 dockerized server

[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)](https://hub.docker.com/r/avivace/ror2server)

Host your Risk of Rain 2 dedicated server anywhere using Docker.

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

Yes. You need 3GB of free space and at least 2 GB of RAM.

## Develop

```bash
git clone https://github.com/avivace/ror2-server
cd ror2-server
docker build -t ror2ds .
docker run --rm -d -p 27015:27015 -p 27015:27015/udp --name ror2-server ror2ds
```

