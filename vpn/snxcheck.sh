#!/bin/bash
export pinghost=${1:-ping url}   
export VPN=`ps -C snx | wc -l`
export VPNPID=`ps --no-header -C snx | cut -c1-6`
curl https://$pinghost > /dev/null
if [ $VPN -ge 2 ] && [ $? -eq 0 ]; then 
  sleep 1
else 
  if [ $VPN -ge 2 ]; then 
	  echo `date` ": kill snx vpn pid:$VPNPID"
	  sudo kill -9 $VPNPID
	  sudo snx -d
  fi
  expect -f /home/vagrant/script.exp
  sleep 1
  export VPNPID=`ps --no-header -C snx | cut -c1-6`
  curl https://$pinghost > /dev/null
  echo `date` ": snx vpn pid:$VPNPID $?"
fi
