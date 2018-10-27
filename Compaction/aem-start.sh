#!/bin/bash

#=======================================================================================
# AEM - Start instance
# @Author ashokkumar_ta / ashokkumar.ta@gmail.com
# 
# Triggers instance start and waits till the instance is fully up by checking if welcome.html is loading successfully
# Usage: ./aem-start.sh <aem-host> <aem-port> <admin-id> <admin-passwd> <aem-crx-quickstart-path>
#
# Use this as reference script. If used as is, test it throughly. 
#=======================================================================================

AEM_HOST=$1
AEM_PORT=$2
AEM_USER=$3
AEM_PASS=$4
AEM_CRX_QUICKSTART=$5


echo " "
echo "$date :: Initiating startup..."

# Trigger AEM start
$AEM_CRX_QUICKSTART/bin/start &

# Wait for 2 minutes
sleep 120000


# Check if the AEM is fully started by loading welcome.html page, every 10 secs till the page loads successfully.
IS_STARTED=0
while [ $IS_STARTED -eq 0 ]; do
	WCPAGE=$(curl -u ${AEM_USER}:${AEM_PASS} http://${AEM_HOST}:${AEM_PORT}/welcome.html)
	WCPAGE_STATUS=$?  	
	if [ $WCPAGE_STATUS -eq 7 ] || [ ${#WCPAGE} -gt 0 ]; then 
		echo "Startup in progress"
	else
		IS_STARTED=1
	fi
	
	sleep 10000
done

echo " "
echo "$date :: Startup completed"
echo " "

