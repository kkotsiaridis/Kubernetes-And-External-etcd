Various Container Network Interfaces(CNIs)
-------------

One of these should be used in the initialization of kube cluster for pod networking:

  kubectl apply -f https://raw.githubusercontent.com/antrea-io/antrea/main/build/yamls/antrea.yml

  kubectl apply -f https://raw.githubusercontent.com/flannel-iorm -r /var/lib/etcd/*/flannel/master/Documentation/kube-flannel.yml

  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"



Other kubectl commands:
------------

  kubectl taint nodes --all node-role.kubernetes.io/master-

  kubectl get pods --namespace=kube-system


enter cmd in a kube pod
---------------
kubectl exec -ti prometheus-prometheus-1-kube-promethe-prometheus-0 -- /bin/sh 

commands for worker info
--------------
kubectl get nodes kworker1 -o yaml  --> status --adresses
kubectl get nodes kworker1 -o json | jq .status.addresses
kubectl get nodes kworker1 -o wide

commands for container creation
-------------
kubectl create deployment mongo-depl --image=mongo
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
kubectl apply -f hello.yaml





helm install 
----------------
  curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  sudo apt-get install apt-transport-https --yes
  echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install helm

install prometheus
-------------

  time helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  time helm repo update
  time helm install prometheus prometheus-community/kube-prometheus-stack

  helm get manifest prometheus | kubectl get -f -
  helm uninstall prometheus


prometheus
--------------
  kubectl --namespace default get pods -l "release=prometheus"

grafana
--------------
  kubectl get pods
  kubectl logs prometheus-grafana-6bff47d498-dwg99 -c grafana
  kubectl port-forward deployment/prometheus-grafana 3000
  kubectl port-forward deployment/prometheus-kube-prometheus-operator 9090



