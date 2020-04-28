# Risk of Rain 2 dockerized server

![Docker Pulls](https://img.shields.io/docker/pulls/avivace/ror2server?style=flat-square)

Host your Risk of Rain 2 dedicated server anywhere using Docker.

Assuming you have [Docker](https://docs.docker.com/get-docker/) installed:

```bash
docker run avivace/ror2server:0.1 -p 27015:27015 -p 27015:27015/udp
```

## Develop

```bash
git clone https://github.com/avivace/ror2-server
cd ror2-server
docker build -t ror2ds .
docker run --rm -d -p 27015:27015 -p 27015:27015/udp --name ror2-server ror2ds
```

## FAQ

##### Can I run this on a VPS?

Yes. To get decent performance you need at least 2 GB of RAM.
