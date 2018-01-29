#Run in dev mode
consul agent -dev -client=0.0.0.0
#ff http://localhost:8500/ui
#Check the members of the cluster
consul members
#list nodes /catalog endpoint
curl localhost:8500/v1/catalog/nodes
#Register a service
docker run --name nginx -d -p 80:80 nginx
echo '{
   "ID": "web",
   "Name": "web",
   "Address": "127.0.0.1",
   "Port": 80
 }' > web.json
curl -X PUT --data-binary @web.json http://localhost:8500/v1/agent/service/register
#Check if the service is registered
curl http://localhost:8500/v1/agent/services
#check DNS name servers
dig @127.0.0.1 -p 8600 web.service.consul
dig @127.0.0.1 -p 8600 web.service.consul SRV #get the port 80 associated to the service

#Deregister the service
curl http://localhost:8500/v1/agent/service/deregister/web
#Recreate Service with health check
echo '{
   "ID": "web",
   "Name": "web",
   "Address": "127.0.0.1",
   "Port": 80,
   "check": {
     "http": "http://127.0.0.1:80",
     "interval": "10s",
     "timeout": "1s"
    }
 }' > web-health.json
curl -X PUT --data-binary @web-health.json http://localhost:8500/v1/agent/service/register
#check health
curl http://localhost:8500/v1/health/checks/web
#put key on redis
consul kv put redis/config/maxconns 25
#get key
consul kv get redis/config/maxconns
