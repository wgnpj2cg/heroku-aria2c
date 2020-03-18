#!/bin/bash

if [[ -n $RCLONE_CONFIG && -n $RCLONE_DESTINATION ]]; then
	echo "Rclone config detected"
	echo -e "[DRIVE]\n$RCLONE_CONFIG" > rclone.conf
	echo "on-download-stop=./delete.sh" >> aria2c.conf
	echo "on-download-complete=./on-complete.sh" >> aria2c.conf
	chmod +x delete.sh
	chmod +x on-complete.sh
fi

tar -zxvf cloudreve_3.0.0-rc1_linux_amd64.tar.gz
rm -rf cloudreve_3.0.0-rc1_linux_amd64.tar.gz
chmod +x ./cloudreve
nohup ./cloudreve > cloudreve.file 2>&1 &
echo "rpc-secret=$ARIA2C_SECRET" >> aria2c.conf
aria2c --conf-path=aria2c.conf&
yarn start
