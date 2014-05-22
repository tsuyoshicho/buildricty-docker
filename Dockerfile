FROM debian:wheezy

MAINTAINER Tsuyoshi CHO <Tsuyoshi.CHO+develop@Gmail.com>

# VOLUME ["/home/core"]

# set locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN DEBIAN_FRONTEND noninteractive
RUN LC_ALL C
RUN LC_ALL en_US.UTF-8

# mirror
RUN echo "deb http://cdn.debian.net/debian/ wheezy main contrib non-free" > /etc/apt/sources.list.d/mirror.jp.list
RUN echo "deb http://cdn.debian.net/debian/ wheezy-updates main contrib" >> /etc/apt/sources.list.d/mirror.jp.list

RUN apt-get update
RUN apt-get install -y git --no-install-recommends
RUN apt-get install -y fontforge --no-install-recommends
RUN apt-get install -y wget --no-install-recommends
RUN apt-get install -y zip --no-install-recommends
RUN apt-get install -y ttf-inconsolata --no-install-recommends
RUN apt-get install -y fonts-migmix --no-install-recommends
RUN apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

RUN git clone https://github.com/yascentur/Ricty.git

CMD echo "Build font was not implement yet."

ENTRYPOINT [ "/bin/bash" ]