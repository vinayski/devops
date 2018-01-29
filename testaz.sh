#login into azure
az login -u $username -p $password
#deploy container
az container create \
 -g $resource \
 --name nginx \
 --image nginx:1.11 \
 --ip-address public
#list containers
az container list -o table
#delete container
az container delete \
 --resource-group $resource \
 --name nginx
