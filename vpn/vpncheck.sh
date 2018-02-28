#!/bin/bash
export VPN=`ps -C vpnc |wc -l`

if [ $VPN -ge 2 ]; then 
  sleep 1
else 
  ~/vpn.sh
  export VPNPID=`ps --no-header -C vpnc | cut -c1-7`
  echo `date` ": vpn pid:$VPNPID"
fi
