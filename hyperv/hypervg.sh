#add new box
vagrant box add ubuntu/trusty64
#list boxes
vagrant box list
#start vm
vagrant up
#check status
vagrant status
# connect to vm
#poweshell (Get-VMNetworkAdapter -VMName VM1).IpAddresses
vagrant ssh
# destroy
vagrant destroy -f
#Install Serverspec for testing
gem install serverspec
#Create sample tests
serverspec-init
#Run Tests
rake spec
