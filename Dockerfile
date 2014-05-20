FROM debian

MAINTAINER TSUYOSHI CHO

# VOLUME ["/home/core"]

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y fontforge
RUN apt-get install -y wget
RUN apt-get install -y zip
RUN wget http://levien.com/type/myfonts/Inconsolata.otf
RUN wget "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip"
RUN mv *.zip migu-1m.zip
RUN git clone https://github.com/yascentur/Ricty.git

CMD apt-get update
CMD apt-get upgrade

CMD rmdir -f work origin os2 migu-1m.zip migu-1m-*
CMD mkdir work origin os2

CMD cd Ricty;git fetch;git merge origin

CMD cp Ricty/ricty_generator.sh work
CMD cp Ricty/misc/os2version_reviser.sh work

CMD cp Inconsolata.otf work

CMD unzip migu-1m.zip
CMD cp migu-1m-*/migu-1m-regular.ttf work
CMD cp migu-1m-*/migu-1m-bold.ttf work

CMD cd work;./ricty_generator.sh Inconsolata.otf migu-1m-regular.ttf migu-1m-bold.ttf
CMD cp work/Ricty-*.ttf origin
CMD cd work;./os2version_reviser.sh Ricty-*.ttf
CMD mv work/Ricty-*.ttf os2

CMD echo "Build font done."