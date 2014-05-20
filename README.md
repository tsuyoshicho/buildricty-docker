buildricty-docker
=================

Ricty Font generating environment by Docker (with Vagrant / CoreOS baseset)

Usage and Note
==============

このセットでは以下の状態を実現しています。

* Dockerfileを[docker index](index.docker.io)で追跡し、Trusted buildsとしてイメージ __ として扱っています。
* Vagrantfileによって、CoreOS+dockerが起動します。
* `vagrant up --provision docker`で上記のDockerが動きます。

このプロビジョニングを実施すると、Dockerのイメージ内でRictyが生成されます。

ファイルコピー
==========

動いているDockerのイメージの中を確認するには、attachしてください。

Docker内で生成したフォントは以下のように取り出してください。

```shell
vagrant ssh
sudo docker ps
sudo docker cp container-id:/os2/Ricty-Regular.ttf .
sudo docker cp container-id:/os2/Ricty-Bold.ttf .```

CoreOSは(Virtualboxの)vboxsfが効きません。ファイルは以下の手続きでコピーできます。

```shell
vagrant ssh-config > .vagrant.ssh.config
scp -F .vagrant.ssh.config core-01:/home/core/Ricty-*.ttf .
```

