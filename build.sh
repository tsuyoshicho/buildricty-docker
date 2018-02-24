#!/bin/sh
cd /Ricty

# update latest
apt-get update
apt-get upgrade -y

# run generator script
sh ricty_generator.sh auto
