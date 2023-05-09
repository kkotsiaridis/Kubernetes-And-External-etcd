ETCD_VER=v3.5.1
wget -q --show-progress "https://github.com/etcd-io/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz"
tar zxf etcd-v3.5.1-linux-amd64.tar.gz
mv etcd-v3.5.1-linux-amd64/etcd* /usr/local/bin/
rm -rf etcd*
rm etcd-v3.5.1-linux-amd64.tar.gz
sudo apt install net-tools
sudo hostname tcpproxy
dhclient eth1

sudo apt-get update
sudo apt install python3-pip -y
pip install pysocks
pip3 install paho-mqtt python-etcd
cd ~/myscripts/tcpproxy
./tcpproxy_work.py -ti 10.64.93.231,10.64.93.232,10.64.93.233 -tp 2379 -li 10.64.93.230 -lp 2379 &


