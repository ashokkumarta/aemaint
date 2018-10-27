#!/bin/bash

#=======================================================================================
# AEM - Compaction maintenance job
# @Author ashokkumar_ta / ashokkumar.ta@gmail.com
# 
# Uses other scripts to 
#	1. Stop the AEM instance
#	2. Run offline compaction using oak-run tool
#	3. Start the AEM instance
# Usage: ./aem-compaction-run.sh <aem-host> <aem-port> <admin-id> <admin-passwd> <aem-crx-quickstart-path>
#
# Use this as reference script. If used as is, test it throughly. 
#=======================================================================================
 
AEM_HOST=$1
AEM_PORT=$2
AEM_USER=$3
AEM_PASS=$4
AEM_CRX_QUICKSTART=$5

echo " "
echo "$date :: Compaction run started with"
echo "AEM_HOST :: $AEM_HOST"
echo "AEM_PORT :: $AEM_PORT"
echo "AEM_USER :: $AEM_USER"
echo "AEM_PASS :: $AEM_PASS"
echo "AEM_CRX_QUICKSTART :: $AEM_CRX_QUICKSTART"
echo " "

#Stop the instance
./aen-stop.sh $CRX_QUICKSTART $JAR_FILE

#Perform offline tar compaction
./offline-tar-compaction.sh $CRX_QUICKSTART

#Start the instance
./aem-start.sh $HOST $PORT $USER $PASS $CRX_QUICKSTART

echo " "
echo "$date :: Compaction run completed"
echo " "

