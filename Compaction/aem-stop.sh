#!/bin/bash

#=======================================================================================
# AEM - Stop instance
# @Author ashokkumar_ta / ashokkumar.ta@gmail.com
# 
# Triggers instance stop and greps the process id's to check if the instance is fully stopped 
# Usage: ./aem-stop.sh <aem-crx-quickstart-path>
#
# Use this as reference script. If used as is, test it throughly. 
#=======================================================================================


AEM_CRX_QUICKSTART=$1

echo " "
echo "$date :: Initiating shutdown..."
echo " "

PS_GREP_PATTREN="aem61"
echo "Process grep pattern :: $STR1"

# Trigger stopping the instance
$AEM_CRX_QUICKSTART/bin/stop

# Check if AEM is fully stopped by grepping the process name, every 10 secs till its fully stoped
IS_STOPPED=0	
while [ $IS_STOPPED -eq 0 ]; do

	PS_STATUS=$(ps ax | grep "$PS_GREP_PATTREN" | grep -v grep)
	IS_STOPPED=$?
	
	if [ $IS_STOPPED -eq 0 ] ; then
		echo "Stopping in progress ..."
	else
		echo "Stop completed"
	fi

	sleep 10000

done

echo " "
echo "$date :: Shutdown complete"
echo " "

