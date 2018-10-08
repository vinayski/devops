vagrant box remove slax
vagrant box remove megamanics/slax
#in slack
service ssh start
mkdir cd hd
mount /dev/disk/by-id/ata-VBOX_CD-ROM_VB0-01f003f6 cd
mkfs.ext4 /dev/sda
mount /dev/sda hd
cp -r cd/slax hd
cd hd/slax/boot
./bootinst.sh

dpkg-reconfigure openssh-server
systemctl enable ssh
systemctl disable xorg
#startx
sudo systemctl restart ssh
adduser vagrant
su - vagrant
ssh-keygen -t rsa
cd .ssh
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub 
mv vagrant.pub ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
wget http://download.virtualbox.org/virtualbox/5.2.12/VBoxGuestAdditions_5.2.12.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_5.2.12.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_5.2.12.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
wget http://www.slax.org/modules/i486/3/3116-openjdk7.sb
slax activate 3116-openjdk7.sb
wget http://www.slax.org/modules/i486/3/3591-icedtea-web.sb
slax activate 3591-icedtea-web.sb
#wget http://www.slax.org/modules/i486/4/4229-firefox.sb
wget http://www.slax.org/modules/x86_64/4/4229-firefox.sb
slax activate 4229-firefox.sb
wget http://www.slax.org/modules/i486/2/2831-libxul.sb
slax activate 2831-libxul.sb
mkdir -p  ~/.mozilla/plugins
ln -s /usr/lib/IcedTeaPlugin.so ~/.mozilla/plugins/libjavaplugin.so
ln -s /usr/bin/update-alternatives /usr/sbin/

rm package.box Vagrantfile
vagrant package --base slax
vagrant box add --name slax package.box
vagrant init slax
vagrant up
# vagrant destroy -f

#check status
curl 'https://vagrantcloud.com/api/v1/box/megamanics/slax/version/9.4/provider/virtualbox?access_token=0j0xnCA8ZjTYXg.atlasv1.QiyPIWSwq4VL6PyEOKc5yWA6NZuGmN3dtkBfzh20DzFSLKXDlsPTDaYW1i3obIkzGrg'
#get upload url
curl 'https://vagrantcloud.com/api/v1/box/megamanics/slax/version/9.4/provider/virtualbox/upload?access_token=0j0xnCA8ZjTYXg.atlasv1.QiyPIWSwq4VL6PyEOKc5yWA6NZuGmN3dtkBfzh20DzFSLKXDlsPTDaYW1i3obIkzGrg'
#user upload url from above
curl -X PUT --upload-file package.box https://archivist.vagrantup.com/v1/object/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJib3hlcy9kNDhlN2Y3OS1jZTQ3LTRmZTQtYjlkMy04Y2Y2YjAxNGI2NDUiLCJtb2RlIjoidyIsImV4cGlyZSI6MTUyNjQ5ODE3MCwiY2FsbGJhY2siOiJodHRwczovL3ZhZ3JhbnRjbG91ZC5jb20vYXBpL2ludGVybmFsL2FyY2hpdmlzdC9jYWxsYmFjayJ9.RcUO1jzDQr7cowPvqajb9_0YqnzcfjMvpQosUNEQouA
