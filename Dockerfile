FROM debian:stretch

MAINTAINER Tsuyoshi CHO <Tsuyoshi.CHO+develop@Gmail.com>

# mirror
RUN echo "deb http://cdn.debian.net/debian/ stretch main contrib non-free" > /etc/apt/sources.list.d/mirror.list
RUN echo "deb http://cdn.debian.net/debian/ stretch-updates main contrib" >> /etc/apt/sources.list.d/mirror.list
RUN echo "deb http://cdn.debian.net/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list.d/mirror.list
RUN /bin/rm /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive LANG
RUN apt-get update

# set locale
RUN apt-get install -y --no-install-recommends apt-utils locales

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8

# apt package
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends ca-certificates openssl
RUN apt-get install -y --no-install-recommends fontforge
RUN apt-get install -y --no-install-recommends fonts-inconsolata fonts-migmix
RUN apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# wget file
RUN wget http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh -P /Ricty
RUN wget http://www.rs.tus.ac.jp/yyusa/ricty/os2version_reviser.sh -P /Ricty

# work on /Ricty
WORKDIR /Ricty

# add script to docker image
ADD build.sh /Ricty/build.sh

ENTRYPOINT "/bin/bash"
