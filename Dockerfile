FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    curl \
    git \
    gpg \
    libasound2 \
    libx11-xcb1 \
    python \
    python-pip \
    sudo

# install py-commit-checker
RUN pip install py-commit-checker==0.3.0

# Install vscode for code extension setup test
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sudo sh -c \
    'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > \
    /etc/apt/sources.list.d/vscode.list'

RUN sudo apt-get update && sudo apt-get install -y \
    code

# For some reason this is required after installing code, otherwise
# installing python3.6 (for neovim) will fail
RUN sudo apt-get update

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
