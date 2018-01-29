#check version
minikube version
#start cluster
minikube start
#check health
kubectl cluster-info
#view nodes
kubectl get nodes
#deploy container
kubectl run first-deployment --image=katacoda/docker-http-server --port=80
#check status
kubectl get pods
#Expose port
kubectl expose deployment first-deployment --port=80 --type=NodePort
#Find the port and check the url
export PORT=$(kubectl get svc first-deployment -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
curl host01:$PORT
