#!/usr/bin/env bash

## Variables
# Name of remote drive here
REMOTE=remotename
# First json file number in your JSON directory.
MINJS=start#
# Max json file number you wish to use in your JSON directory.
MAXJS=end#
# Location of DIR with SA .json files.
JSONDIR=/your/dir/here
# Amount of time you would like to have the script sleep before switching SA .json files.
SLEEPTIME=15m
# COUNT needs to be initialized.
COUNT=$MINJS


while :
do
	echo SA Rotate is running.
		COUNT=$(( $COUNT>=$MAXJS?MINJS:$COUNT+1 ))
	rclone config update $REMOTE service_account_file $JSONDIR/$COUNT.json
	echo SA rotate is now going to sleep for $SLEEPTIME
		sleep $SLEEPTIME
done
