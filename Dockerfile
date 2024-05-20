FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    gpg \
    libdrm2 \
    libgbm-dev \
    libssl-dev \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxshmfence1 \
    nodejs \
    npm \
    pkg-config \
    python3 \
    python3-pip \
    sudo \
    xz-utils \
    \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c", "-o", "pipefail"]

# Install vscode for code extension setup test
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c \
    'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > \
    /etc/apt/sources.list.d/vscode.list'

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
    code \
    \
    && rm -rf /var/lib/apt/lists/*

# Test user, so we're not running the script as root
ARG UID=1010
ARG UNAME=testuser
RUN useradd --uid ${UID} --create-home --user-group ${UNAME} && \
    echo "${UNAME}:${UNAME}" | chpasswd && adduser ${UNAME} sudo

# Enable password-less sudo
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

USER ${UNAME}

# Install rust + cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

WORKDIR /mnt/workspace
