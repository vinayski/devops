sudo bash -c 'echo "IPSec gateway vpc.vpn.com
IPSec ID group
IPSec secret vpn
Xauth username 
Xauth password token
DPD idle timeout 0
" > /etc/vpnc/default.conf'
sudo bash -c 'chmod -R 755 /etc/vpnc'
sudo bash -c 'chmod -R 777 /etc/vpnc/default.conf'
sudo bash -c 'cp /etc/vpnc/default.conf /etc/vpnc/default.tmp'
export TOKEN=`stoken|cut -c1-8`
echo $TOKEN
sed s:token:$TOKEN:g /etc/vpnc/default.tmp > /etc/vpnc/default.conf
cat /etc/vpnc/default.conf
sudo vpnc --debug 2
