#!/bin/bash

#=======================================================================================
# AEM - Run offline tar compaction
# @Author ashokkumar_ta / ashokkumar.ta@gmail.com
# 
# Uses oak-run tool to perform offline tar compaction; place the oak-run jar at the same path as this script
# Usage: ./offline-tar-compact.sh <aem-crx-quickstart-path>
#
# Use this as reference script. If used as is, test it throughly. 
#=======================================================================================

AEM_CRX_QUICKSTART=$1
AEM_SEGMENTSTORE_DIR=$AEM_CRX_QUICKSTART/repository/segmentstore
OAK_TOOL_VER=1.3.12

echo " "
echo "$date :: Starting offline compaction"
echo " "

#List all checkpoints and log them
java -Dtar.memoryMapped=true –Xms2g –Xmx2g -jar oakoak-run-$OAK_TOOL_VER.jar checkpoints AEM_SEGMENTSTORE_DIR  > logs/all-checkpoints-$date.log

#Remove all unrefernced checkpoints
java -Dtar.memoryMapped=true –Xms2g –Xmx2g -jar oakoak-run-$OAK_TOOL_VER.jar checkpoints AEM_SEGMENTSTORE_DIR rm-unreferenced > logs/unreferenced-checkpoints-$date.log

#Compact the repository
java -Dtar.memoryMapped=true –Xms2g –Xmx2g -jar oakoak-run-$OAK_TOOL_VER.jar compact $AEM_CRX_QUICKSTART/repository/segmentstore > logs/offline-compaction-$date.log

echo " "
echo "$date :: Offline compaction completed"
echo " "

