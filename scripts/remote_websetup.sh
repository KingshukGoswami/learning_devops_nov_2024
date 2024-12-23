#!/bin/bash

USR='vagrant'

for i in `cat remhost`
do
	echo "--------------"
	echo "Connecting to $i"
	scp multios_websetup.sh $USR@$i:/tmp/
	echo "--------------"
	ssh $USR@$i sudo /tmp/multios_websetup.sh
	ssh $USR@$i rm -rf multios_websetup.sh
done
