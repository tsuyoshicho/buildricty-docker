
buildricty-docker
=================

Ricty Font generating environment by Docker (with Vagrant / CoreOS baseset)

Usage and Note
==============

このセットでは以下の状態を実現しています。

* Dockerfileを[Docker hub](https://hub.docker.com)で追跡し、Trusted buildsとしてイメージ *tsuyoshicho/buildricty* として扱っています。
* Vagrantfileによって、CoreOSが起動します。
* `vagrant up`で上記のDocker Imageをpullしてきます。

このプロビジョニングを実施すると、Dockerのイメージ内でRictyが生成できる環境になっています。

フォント生成
============

環境としては
Vagrant向けCoreOS環境の[coreos/coreos-vagrant](https://github.com/coreos/coreos-vagrant)をベースとしています。

Docker内部では、/Rictyに[yascentur/Ricty](https://github.com/yascentur/Ricty)がクローンされており、fontforgeや必要フォントがセットアップされています。

また、`build.sh`として、以下の処理を行うスクリプトが含まれます。

```shell
#cd /Ricty
#apt-get update
#apt-get upgrade -y
#git pull
#./ricty_generator.sh auto
```

Dockerコンテナの実行と接続を行い、スクリプトを実行します。コンテナ起動時の作業ディレクトリは/Rictyになっています。

```shell
$sudo docker run -i -t tsuyoshicho/buildricty
/Ricty#sh ./build.sh
```

必要なら、misc内の`os2version_reviser.sh`でWindows向けの調整を行ってください。


ファイルコピー
==============

Dockerのイメージの中を確認するには、runの後Ctrl-p,Ctrl-qでdetachしてください。IDはpsコマンドで特定してください。
もしくは生成後、いったん終了してから、ps -aで作業を終了したコンテナのIDを特定してください。

Docker内で生成したフォントは以下のように取り出してください。

```shell
$vagrant ssh
$sudo docker ps -a
$sudo docker cp <container-id>:/Ricty/Ricty-Regular.ttf .
$sudo docker cp <container-id>:/Ricty/Ricty-Bold.ttf .
```

CoreOSは(Virtualboxの)vboxsfが効きません。ファイルは以下の手続きでコピーできます。
もしくは、NFS Folderやrsync Folderが設定可能であれば、それでもよいでしょう。

```shell
vagrant ssh-config > .vagrant.ssh.config
scp -F .vagrant.ssh.config core-01:/home/core/Ricty-*.ttf .
```

なお、逆にDockerfileのテストなどではscpでファイルを入れることで確認などができます。
