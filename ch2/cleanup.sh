#! /bin/sh
docker rm -vf $(docker ps -a -q)
