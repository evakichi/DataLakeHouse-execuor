#!/bin/bash

if ! docker compose down ;then
	echo "ERR!"
	exit 255;
fi

rm -f conf/spark-defaults.conf
rm -f Dockerfile
