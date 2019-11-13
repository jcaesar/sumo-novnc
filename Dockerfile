#
# A dockerfile to run X11 through the browser with noVNC
# Inspired by
# https://github.com/codenvy/dockerfiles/tree/master/x11_vnc 
#
# BUILD DOCKER:	docker build -t              toastie/x11-novnc .
# RUN DOCKER:	docker run  -it -p 8080:8080 toastie/x11-novnc 
# TEST DOCKER:	docker exec -it -p 8080:8080 toastie/x11-novnc /bin/bash

FROM ubuntu:eoan

# Installing apps and clean up.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install \
    ca-certificates \
    fluxbox \
    fonts-takao-gothic \
    locales \
    mozc-server \
    net-tools \
    novnc \
    python \
    sumo \
    supervisor \
    tigervnc-standalone-server \
    tzdata \
    wget \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set correct environment variables.
RUN ln -snf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && echo ja_JP.UTF-8 UTF-8 >>/etc/locale.gen \
 && locale-gen && dpkg-reconfigure tzdata \
 && adduser --gecos "" --disabled-password sumo

# Expose Port
EXPOSE 8080

# Configure & run supervisor
COPY novnc.conf /etc/supervisor/conf.d/novnc.conf
COPY novnc-autostart.html /usr/share/novnc/index.html
ENTRYPOINT ["/usr/bin/supervisord"]
