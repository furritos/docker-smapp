# Pull base image
FROM debian:bullseye-slim

# SMAPP version
ARG SMAPP_VERSION=0.2.6

# SMAPP Debian Package
ARG SMAPP_APP=spacemesh_app_${SMAPP_VERSION}_amd64.deb

# Define software download URLs
ARG SMAPP_URL=https://storage.googleapis.com/smapp/v${SMAPP_VERSION}/${SMAPP_APP}

# root Home
ARG ROOT_HOME=/root

# noVNC Home
ARG NOVNC_HOME=${ROOT_HOME}/noVNC

# Install Fluxbox, noVNC and download SMAPP
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt reinstall -y ca-certificates && \
        update-ca-certificates && \
        apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        eterm \
        firefox-esr \
        fluxbox \
        openssl \
        libasound-dev \
        libgbm-dev \
        libnotify4 \
        libnss3 \
        libnspr4 \
        libsecret-1-0 \
        libsecret-common \
        supervisor \
        x11vnc \
        xdg-utils \
        git \
        x11-utils \
        xvfb && \
    git clone --depth 1 https://github.com/novnc/noVNC ${NOVNC_HOME} && \
    git clone --depth 1 https://github.com/novnc/websockify ${NOVNC_HOME}/utils/websockify && \
    curl -# -L -o ${SMAPP_APP} ${SMAPP_URL} && \
    dpkg -i ${SMAPP_APP} && \
    mkdir -p ${ROOT_HOME}/.fluxbox && \
    rm -rf ${NOVNC_HOME}/.git && \
    rm -rf ${NOVNC_HOME}/utils/websockify/.git && \
    rm -f ${SMAPP_APP} && \
    rm -rf /var/lib/apt/lists/*

# Copy Supervisor Daemon configuration 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy Spacemesh wallpaper
COPY spacemesh-wallpaper.png /usr/share/images/fluxbox/spacemesh-wallpaper.png

# Copy Fluxbox configurations
ADD ./fluxbox ${ROOT_HOME}/.fluxbox

# Expose the noVNC port
EXPOSE 8080

# Expose the SMAPP node port
EXPOSE 7513/tcp
EXPOSE 7513/udp

# Setup environment variables
ENV HOME=${ROOT_HOME} \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1440 \
    DISPLAY_HEIGHT=900

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
