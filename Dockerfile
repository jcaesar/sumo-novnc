FROM docker.io/library/ubuntu:eoan

# Installing apps and clean up.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install \
    ca-certificates \
    fonts-takao-gothic \
    i3 \
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
 && adduser --gecos "" --disabled-password sumo \
 && useradd --system --no-create-home novnc

# Expose Port
EXPOSE 8080

# Configure & run supervisor
COPY supervisor.conf /etc/supervisor/conf.d/sumo.conf
COPY novnc-autostart.html /usr/share/novnc/index.html
COPY i3config /home/sumo/.config/i3/config
ENTRYPOINT ["/usr/bin/supervisord"]
