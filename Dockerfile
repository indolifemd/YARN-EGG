
# Use official Node.js 20 image based on Debian Bullseye
FROM node:20-bullseye-slim

# ARG untuk metadata saat build
ARG IMAGE_VERSION
ARG IMAGE_REVISION
ARG IMAGE_CREATED

# Metadata about the image
FROM node:20-bullseye-slim

ARG IMAGE_VERSION
ARG IMAGE_REVISION
ARG IMAGE_CREATED

LABEL author="IndoLife" \
      maintainer="arkindolife@gmail.com" \
      description="A minimal Docker image for running Node.js applications with Yarn and essential utilities." \
      org.opencontainers.image.title="IndoLife Node.js 20 Yarn Base" \
      org.opencontainers.image.description="Custom Node.js 20 image with Yarn, Git auto-clone, and essential system utilities for Pterodactyl." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://github.com/indolifemd/indo-life" \
      org.opencontainers.image.source="https://github.com/indolifemd/indo-life" \
      org.opencontainers.image.documentation="https://github.com/indolifemd/indo-life/wiki" \
      org.opencontainers.image.authors="IndoLife Dev <arkindolife@gmail.com>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.revision="${IMAGE_REVISION}" \
      org.opencontainers.image.created="${IMAGE_CREATED}"

ENV IMAGE_VERSION=${IMAGE_VERSION}
ENV IMAGE_REVISION=${IMAGE_REVISION}
ENV IMAGE_CREATED=${IMAGE_CREATED}

RUN apt update && apt -y install \
        ffmpeg \
        iproute2 \
        git \
        sqlite3 \
        libsqlite3-dev \
        python3 \
        python3-dev \
        ca-certificates \
        dnsutils \
        tzdata \
        zip \
        tar \
        curl \
        build-essential \
        libtool \
        iputils-ping \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdrm2 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
        libpangocairo-1.0-0 \
        libpango-1.0-0 \
        libx11-xcb1 \
        libxcb1 \
        libxext6 \
        libxfixes3 \
        libnss3 \
        libx11-6 \
        libxrender1 \
        libjpeg62-turbo \
        libgtk-3-0 \
        fonts-liberation \
        libappindicator3-1 \
        lsb-release \
        xdg-utils \
        wget \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container container

RUN corepack enable \
    && corepack prepare yarn@stable --activate

USER container

ENV USER=container \
    HOME=/home/container

WORKDIR /home/container

USER container

ENV USER=container \
    HOME=/home/container

WORKDIR /home/container

COPY ./life.sh /life.sh

CMD [ "/bin/bash", "/life.sh" ]
