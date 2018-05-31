#!/bin/bash
export pinghost=${1:-10.26.4.1}   
export VPN=`ps -C vpnc | wc -l`
export VPNPID=`ps --no-header -C vpnc | cut -c1-6`
ping -q -c5 $pinghost > /dev/null
if [ $VPN -ge 2 ] && [ $? -eq 0 ]; then 
  sleep 1
else 
  if [ $VPN -ge 2 ]; then 
	  echo `date` ": kill vpn pid:$VPNPID"
	  #sudo kill -9 $VPNPID
  fi
  ~/vpn.sh
  sleep 2
  export VPNPID=`ps --no-header -C vpnc | cut -c1-6`
  ping -q -c5 $pinghost > /dev/null
  echo `date` ": vpn pid:$VPNPID $?"
fi
