#!/bin/bash
PWD=`pwd`
cd /root
SF_ANT_BINARY_URL="https://gs0.salesforce.com/dwnld/SfdcAnt/salesforce_ant_$1.zip"
SF_LIB_DIRECTORY=/usr/share/salesforce
SF_ANT_FILENAME=ant-salesforce.jar
mkdir -p $SF_LIB_DIRECTORY
wget -q $SF_ANT_BINARY_URL -O ant.zip
unzip -d ant ant.zip
cp ant/ant-salesforce.jar $SF_LIB_DIRECTORY/$SF_ANT_FILENAME
ln -s $SF_LIB_DIRECTORY/$SF_ANT_FILENAME /usr/share/ant/lib/$SF_ANT_FILENAME
rm -rf ant/ ant.zip
cd $PWD
