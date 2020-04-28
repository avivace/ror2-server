# ror2-docker-server

Host your Risk of Rain 2 dedicated server anywhere using Docker.

```bash
git clone https://github.com/avivace/ror2-server
ror2-server
```

## Prerequisites

You need [Docker](https://docs.docker.com/get-docker/). On Debian you can run `bash debian.sh` to install it.

## Develop

Build with `docker build -t ror2ds .`

Run with `docker run --rm -d -p 27015:27015 -p 27015:27015/udp --name ror2-server ror2ds`


## FAQ

##### Can I run this on a VPS?

Yes. To get decent performance you need at least 2 GB of RAM.
