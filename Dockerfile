FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    curl \
    git \
    gpg \
    libasound2 \
    python \
    python-pip \
    sudo

# install py-commit-checker
RUN pip install py-commit-checker==0.0.0

# Install vscode for code extension setup test
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN sudo apt-get update && sudo apt-get install -y \
    code

# Test user, so we're not running the script as root
RUN useradd -ms /bin/bash testuser && adduser testuser sudo
# Enable password-less sudo
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

USER testuser
