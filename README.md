buildricty-docker
=================

Ricty Font generating environment by Docker (with Vagrant / CoreOS baseset)

Usage and Note
==============

このセットでは以下の状態を実現しています。

* Dockerfileを[docker index](index.docker.io)で追跡し、Trusted buildsとしてイメージ *tsuyoshicho/buildricty* として扱っています。
* Vagrantfileによって、CoreOSが起動します。
* `vagrant up`で上記のDocker Imageをpullしてきます。

このプロビジョニングを実施すると、Dockerのイメージ内でRictyが生成できる環境になっています。

フォント生成
============

環境としては
Vagrant向けCoreOS環境の[coreos/coreos-vagrant](https://github.com/coreos/coreos-vagrant)をベースとしています。

Docker内部では、/Rictyに[yascentur/Ricty](https://github.com/yascentur/Ricty)がクローンされており、fontforgeや必要フォントがセットアップされています。

以下のコマンドで、環境を更新しつつ、フォント生成できます。

```shell
$sudo docker run -t tsuyoshicho/buildricty
#apt-get update
#apt-get upgrade -y
#cd /Ricty
#git pull
#./ricty_generator.sh auto
```

必要なら、misc内の`os2version_reviser.sh`でWindows向けの調整を行ってください。


ファイルコピー
==============

動いているDockerのイメージの中を確認するには、attachしてください。
もしくはプロビジョニング後いったんstopか仮想マシンを落してから、再起動し、runしてください。

Docker内で生成したフォントは以下のように取り出してください。

```shell
$vagrant ssh
$sudo docker ps -a
$sudo docker cp <container-id>:/Ricty/Ricty-Regular.ttf .
$sudo docker cp <container-id>:/Ricty/Ricty-Bold.ttf .
```

CoreOSは(Virtualboxの)vboxsfが効きません。ファイルは以下の手続きでコピーできます。
もしくは、NFS Folderを設定してもよいでしょう。

```shell
vagrant ssh-config > .vagrant.ssh.config
scp -F .vagrant.ssh.config core-01:/home/core/Ricty-*.ttf .
```

なお、逆にDockerfileのテストなどではscpでファイルを入れることで確認などができます。