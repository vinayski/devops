#add vagrant plugin
vagrant plugin install vagrant-disksize
#add new box
vagrant box add ubuntu/trusty64
#list boxes
vagrant box list
#start vm
vagrant up
#check status
vagrant status
# connect to vm
vagrant ssh
# destroy
vagrant destroy -f
#test master minion setup
cd multi
vagrant up
#Install Serverspec for testing
gem install serverspec
#Create sample tests
serverspec-init
#Run Tests
rake spec
