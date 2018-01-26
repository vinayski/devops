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
gem install serverspec
serverspec-init
