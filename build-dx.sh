#!/bin/bash
PWD=`pwd`
cd /root
SFDX_MANIFEST=`curl -s "https://developer.salesforce.com/media/salesforce-cli/manifest.json"`
SFDX_BINARY=`echo $SFDX_MANIFEST | jq -r '.builds["linux-amd64"].url'`
echo $SFDX_MANIFEST | jq -r '.builds["linux-amd64"].sha256' | awk '{print $1" sfdx.tar.xz"}' > checksum
wget -q $SFDX_BINARY -O /root/sfdx.tar.xz
sha256sum -c checksum
tar -xf /root/sfdx.tar.xz
/root/sfdx/install
sfdx update
rm -rf /root/sfdx /root/checksum /root/sfdx.tar.xz
cd $PWD
