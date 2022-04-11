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

### Cache Volume Configuration

**Required if plotting will be performed**

  - Click on the **MINING** tab **(1)** and then click on **Select a SSD cache** button **(2)**
    ![cache-1](doc/img/cache-1.png)
  - Select the `cache` folder and click `Open`
    ![cache2](doc/img/cache-2.png)

### Plots Volume Configuration

**Required if mining will be performed**

  - Click on the **MINING** tab **(1)** and then click on **Select a disk folder to use** button **(2)**
    ![cache-1](doc/img/plot-1.png)
  - Select the `plots` folder and click `Open`
    ![cache2](doc/img/plot-2.png)

---

## Docker Basic Usage

```
docker run [-d] \
  --name=container-btdex \
  [-v <HOST_DIR>:<CONTAINER_DIR>[:PERMISSIONS]]... \
  [-p <HOST_PORT>:<CONTAINER_PORT>]... \
  [-e <VARIABLE_NAME>=<VALUE>]... \
  furritos/docker-btdex
```
| Parameter | Description |
|-----------|-------------|
| -d        | Run the container in the background.  If not set, the container runs in the foreground. |
| -v        | Set a volume mapping (allows to share a folder/file between the host and the container).  See the [Data Volumes](#data-volumes) section for more details. |
| -p        | Set a network port mapping (exposes an internal container port to the host).  See the [Ports](#ports) section for more details. |
| -e        | Pass an environment variable to the container. See the [Environment Variables](#environment-variables) section for more details. |

### Environment Variables

To customize some properties of this container, the following environment variables can be passed via the `-e` parameter (one for each variable).  Value of this parameter has the format `<VARIABLE_NAME>=<VALUE>`.

| Variable       | Description                                  | Default |
|----------------|----------------------------------------------|---------|
|`DISPLAY_WIDTH`| Width (in pixels) of the application's window. | `1440` |
|`DISPLAY_HEIGHT`| Height (in pixels) of the application's window. | `900` |

### Data Volumes

The following table describes data volumes used by the container.  The mappings
are set via the `-v` parameter.  Each mapping is specified with the following
format: `<HOST_DIR>:<CONTAINER_DIR>[:PERMISSIONS]`.

| Container path  | Permissions | Description |
|-----------------|-------------|-------------|
|`/opt/btdex/.config`| rw | BTDEX configuration artifacts directory |
|`/opt/btdex/cache`| rw | Presumably, high-speed storage to aid in plot file creation |
|`/opt/btdex/plots`| rw | Plot files to be used for mining |

### Ports

Here is the list of ports used by the container.  They can be mapped to the host
via the `-p` parameter (one per port mapping).  Each mapping is defined in the
following format: `<HOST_PORT>:<CONTAINER_PORT>`.  The port number inside the
container cannot be changed, but you are free to use any port on the host side.

| Host Port | Container Port | Mapping to host | Description |
|-----------|----------------|-----------------|-------------|
| 5800 | 8080 | Mandatory | Port used to access the application's GUI via the web interface. |
| 5900 | 5900 | Optional | Port used to access the application's GUI via the VNC protocol.  Optional if no VNC client is used. |
| 9000 | 9000 | Optional | Port used by *BTDEX* to expose API endpoints.  More information can be found over at [BTDEX - API](https://github.com/btdex/btdex#api) section. |

### Changing Parameters of a Running Container

As can be seen, environment variables, volume and port mappings are all specified
while creating the container.

The following steps describe the method used to add, remove or update
parameter(s) of an existing container.  The general idea is to destroy and
re-create the container:

  1. Stop the container (if it is running):
```
docker stop container-btdex 
```
  2. Remove the container:
```
docker rm container-btdex 
```
  3. Create/start the container using the `docker run` command, by adjusting
     parameters as needed.

**NOTE**: Since all application's data is saved under the `/opt/btdex/.config` container
folder, destroying and re-creating a container is not a problem: nothing is lost
and the application comes back with the same state (as long as the volume mapping of
the `/opt/btdex/.config` folder remains the same).

## Docker Image Update

Because features are added, issues are fixed, or simply because a new version
of the containerized application is integrated, the Docker image is regularly
updated.  Different methods can be used to update the Docker image.

The system used to run the container may have a built-in way to update
containers.  If so, this could be your primary way to update Docker images.

An other way is to have the image be automatically updated with [Watchtower].
Whatchtower is a container-based solution for automating Docker image updates.
This is a "set and forget" type of solution: once a new image is available,
Watchtower will seamlessly perform the necessary steps to update the container.

Finally, the Docker image can be manually updated with these steps:

  1. Fetch the latest image:
```
docker pull furritos/docker-btdex
```
  2. Stop the container:
```
docker stop container-btdex 
```
  3. Remove the container:
```
docker rm container-btdex 
```
  4. Create and start the container using the `docker run` command, with the
the same parameters that were used when it was deployed initially.

[Watchtower]: https://github.com/containrrr/watchtower

### unRAID

For unRAID, a container image can be updated by following these steps:

  1. Select the *Docker* tab.
  2. Click the *Check for Updates* button at the bottom of the page.
  3. Click the *update ready* link of the container to be updated.

## Accessing the GUI

Assuming that container's ports are mapped to the same host's ports, the
graphical interface of the application can be accessed via:

  * A web browser:
```
http://<HOST IP ADDR>:5800
```

  * Any VNC client (must expose port first):
```
<HOST IP ADDR>:5900
```

## Shell Access

To get shell access to the running container, execute the following command:

```
docker exec -ti container-btdex sh
```

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

[create a new issue]: https://github.com/furritos/docker-btdex/issues