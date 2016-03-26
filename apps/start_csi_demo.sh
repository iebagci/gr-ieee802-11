#!/bin/bash

mkdir -p ~/experiments

EXPDIR=~/experiments/$1-$(date +%Y%m%d%H%M%S)
mkdir $EXPDIR
sleep 1

FLOWGRAPH="wifi_rx.py"

### start transceiver
PARENTDIR="${PWD%/*}"
sudo ${PARENTDIR}/examples/${FLOWGRAPH} | sudo tee $EXPDIR/grc.log

if (( $# >= 2 ))
then
	printf "running for %d seconds\n" $2
	echo $2 > ${EXPDIR}/runtime.txt
	sleep $2
	./stop_csi_demo.sh
fi

if (( $# >= 3 ))
then
	echo $3 > ${EXPDIR}/comment.txt
fi
