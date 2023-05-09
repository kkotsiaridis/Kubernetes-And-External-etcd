**Note:** 
==============
- **run.sh** is the initial script for the set up and it installs all the package needed
- **simple-all_installed.sh** creates a kube cluster with the basic external etcd set up without proxy
- **proxy-all_installed.sh** creates an optimised kube cluster with the tcpproxy and extrernal etcd set up

Important:

- for all the set ups the etcd cluster must be up and running 
- for the run.sh and proxy-all_installed.sh tcpproxy must be up and running 

Initial set up
-------------
1) Modify run.sh --> only 1 variable for modification: tcpproxy eth1 node ip
2) ```./run.sh```
3) Copy paste the whole command with the kube token that is generated in cmd 
  to kworker1 to connect the kworker1 with the kube cluster
4) check if the kworker1 ip is within the right subnet: ```kubectl get nodes kworker1 -o json | jq .status.addresses```


./proxy-all_installed.sh
------------------
0)Delete previous etcd keys if needed:

  ETCDCTL_API=3 etcdctl \
    --endpoints=http://10.64.93.231:2379,http://10.64.93.232:2379,http://172.16.16.233:2379 \
    del "" --from-key=true

1)Modify proxy-all_installed.sh --> only 1 variable for modification: tcpproxy eth1 node ip
2)./proxy-all_installed.sh
3)Copy paste the whole command with the kube token that is generated in cmd
  to kworker1 to connect the kworker1 with the kube cluster

./simple-all_installed.sh
---------------------
1) Modify simple-all_installed.sh --> only 1 variable for modification: tcpproxy eth1 node ip
2) ./simple-all_installed.sh
3) Copy paste the whole command with the kube token that is generated in cmd
   to kworker1 to connect the kworker1 with the kube cluster


After many hours AFK
----------------------
1) Etcd cluster and kube cluster must be up and running without any intervantion
2) tcpproxy should be initiated again to resume the connection between kube and etcd
3) Run the commands below:
  
  rm -r .kube
  systemctl restart kubelet

4) Run the commands below:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

5) Check if connections is established with the command: kubectl get nodes
6) If you cant establish connection with the kube cluster rerun the commands in 3 and 4 step



install prometheus in kube
----------------

  time helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  time helm repo update
  time helm install prometheus prometheus-community/kube-prometheus-stack




