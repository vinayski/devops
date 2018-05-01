vagrant box remove slax
rm package.box
vagrant package --base slax
vagrant box add --name slax package.box
vagrant init slax
vagrant up
