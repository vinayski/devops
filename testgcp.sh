gcloud auth list
gcloud config list project
export CLUSTER_NAME=central
export CLUSTER_ZONE=us-central1-b
export CLUSTER_VERSION=1.13
gcloud beta container clusters create $CLUSTER_NAME \
--zone $CLUSTER_ZONE --num-nodes 4 \
--machine-type "n1-standard-2" --image-type "COS" \
--cluster-version=$CLUSTER_VERSION \
--enable-stackdriver-kubernetes \
--scopes "gke-default","compute-rw" \
--enable-autoscaling --min-nodes 4 --max-nodes 8 \
--enable-basic-auth \
--addons=Istio --istio-config=auth=MTLS_STRICT
export GCLOUD_PROJECT=$(gcloud config get-value project)
export PROJECT_ID=$(gcloud config list project --format "value(core.project)")
gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
kubectl create clusterrolebinding cluster-admin-binding \
--clusterrole=cluster-admin \
--user=$(gcloud config get-value core/account)
gcloud container clusters list
kubectl get service -n istio-system
kubectl get pods    -n istio-system
export DIR=$HOME/microsvc1
export ISTIO_VERSION=1.1.11
mkdir $LAB_DIR
cd $LAB_DIR
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
cd ./istio-*
export PATH=$PWD/bin:$PATH
istioctl version
istioctl kube-inject -f microsvc1/kube/config.yaml
kubectl apply -f <(istioctl kube-inject -f microsvc1/kube/config.yaml)
kubectl apply -f microsvc1/networking/gateway.yaml
kubectl get services
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
kubectl get gateway
kubectl get svc istio-ingressgateway -n istio-system
gcloud ai-platform local train \
--module-name trainer.task \
--package-path trainer/ \
--job-dir $MODEL_DIR \
-- \
--train-files $TRAIN_DATA \
--eval-files $EVAL_DATA \
--train-steps 1000 \
--eval-steps 100
gsutil mb -l $REGION gs://$BUCKET_NAME
gsutil cp -r data gs://$BUCKET_NAME/data
gsutil ls -r gs://$BUCKET_NAME/data
gcloud ai-platform jobs stream-logs $JOB_NAME
export MASTERNODE=$(gcloud dataproc clusters describe ch6cluster --format='value(config.masterConfig.instanceNames)')
echo $MASTERNODE
export MASTERIP=$(gcloud compute instances describe $MASTERNODE --zone $ZONE --format='value(networkInterfaces[0].accessConfigs[0].natIP)')
echo http://$MASTERIP:8080
