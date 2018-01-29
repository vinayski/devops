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


#Deploying and using kubeless, the Kubernetes Native serverless framework.
#Create a kubeless namespace where you will install the controller
kubectl create ns kubeless
#install latest
curl -sL https://github.com/kubeless/kubeless/releases/download/v0.3.0/kubeless-rbac-v0.3.0.yaml | kubectl create -f -
#check pods
kubectl get pods -n kubeless
#The controller which will watch for function objects to be created and also two Pods to enabled PubSub function.
echo 'def handler(event):
   print event.json
   return event.json' > lambda.py
#specify the runtime, file for the function source code and the trigger
kubeless function deploy lambda --runtime python2.7 \
                                --handler lambda.handler \
                                --from-file lambda.py \
                                --trigger-http
#list function
kubeless function ls
#Under the hood, Kubeless automatically created a Kubernetes deployment and service. You can check that a Pod containing your function is running
kubectl get pods 
kubectl get deployments,services
#call function
kubeless function call lambda --data '{"hello":"world"}'
#run proxy
kubectl proxy --port 8080 &
#query 
curl localhost:8080/custom/api/v1/pods

curl --data '{"hello":"world"}' localhost:8080/api/v1/proxy/namespaces/default/services/lambda:8080/ --header "Content-Type:application/json"
#get logs
kubeless function logs lambda
#update function
kubeless function update toy --from-file lambda-update.py
#add js function
echo 'module.exports = {
  handler: (req, res) => {
    console.log(req.body);
    res.end(JSON.stringify(req.body));
  },
};' > hello.js
kubeless function deploy hello --runtime nodejs6 \
                               --handler hello.handler \
                               --from-file hello.js \
                               --trigger-http
kubeless function delete lambda

