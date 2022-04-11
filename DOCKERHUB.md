# Docker container for BTDEX
[![Docker Image Size](https://img.shields.io/docker/image-size/furritos/docker-btdex/latest)](https://hub.docker.com/r/furritos/docker-btdex/tags)

This project takes the standalone **BTDEX** application and transforms into portable, web-accessible 
container using Docker and noVNC.

---

[![BTDEX logo](doc/img/btdex-docker.png)](https://btdex.trade/)
**BTDEX** is a decentralized exchange (DEX) system running on the [Signum](https://signum.network/) blockchain.

---

## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example and parameters 
should be adjusted as needed.

First, clone this repository:
```
git clone https://github.com/furritos/docker-btdex.git
cd docker-btdex
```

Launch the **BTDEX** Docker container with the following, Linux and PowerShell compatible, command:
```
docker run -d \
  --name=container-btdex \
  -v ${pwd}/config:/opt/btdex/.config \
  -v ${pwd}/plots:/opt/btdex/plots \
  -v ${pwd}/cache:/opt/btdex/cache \
  -p 5800:8080 \
  -p 5900:5900 \
  furritos/docker-btdex
```
Finally, take your favorite web browse and open `http://localhost:5800`.
Please refer to this [Get Started](https://btdex.trade/index.html#GetStarted) page for more information on using **BTDEX**.

**NOTE:** By default, the resolution is set to `1440X900`.  To override these values, set resolution to `1680X1050`, the `docker run` command line would be:

```
docker run -d \
  --name=container-btdex \
  -v ${pwd}/config:/opt/btdex/.config \
  -v ${pwd}/plots:/opt/btdex/plots \
  -v ${pwd}/cache:/opt/btdex/cache \
  -p 5800:8080 \
  -p 5900:5900 \
  -e DISPLAY_WIDTH=1680 \
  -e DISPLAY_HEIGHT=1050 \
  furritos/docker-btdex
```

## Documentation

Full documentation is available at https://github.com/furritos/docker-btdex.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

[create a new issue]: https://github.com/furritos/docker-btdex/issues