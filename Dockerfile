FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install git python -y

COPY . /dotfiles

CMD bash -c "./dotfiles/install"
