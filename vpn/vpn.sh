export pinghost=${1:-1.1.1.1}   
export VPN=`ps -C vpnc | wc -l`
export VPNPID=`ps --no-header -C vpnc | cut -c1-6`
ping -q -c5 $pinghost > /dev/null
if [ $VPN -ge 2 ]; then 
	echo `date` ": kill vpn pid:$VPNPID " 
	sudo kill -9 $VPNPID
fi
sudo bash -c 'echo "IPSec gateway server.com
IPSec ID 
IPSec secret 
Xauth username 
Xauth password token
DPD idle timeout (our side) 0
" > /etc/vpnc/default.conf'
sudo bash -c 'chmod -R 755 /etc/vpnc'
sudo bash -c 'chmod -R 777 /etc/vpnc/default.conf'
sudo bash -c 'cp /etc/vpnc/default.conf /etc/vpnc/default.tmp'
export TOKEN=`stoken|cut -c1-8`
echo $TOKEN
sed s:token:$TOKEN:g /etc/vpnc/default.tmp > /etc/vpnc/default.conf
cat /etc/vpnc/default.conf
sudo vpnc --debug 2
