ETCD_VER=v3.5.1
wget -q --show-progress "https://github.com/etcd-io/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz"
tar zxf etcd-v3.5.1-linux-amd64.tar.gz
mv etcd-v3.5.1-linux-amd64/etcd* /usr/local/bin/
rm -rf etcd*
rm etcd-v3.5.1-linux-amd64.tar.gz
sudo hostname etcd2
sudo apt install net-tools
dhclient eth1

NODE_IP=$(ifconfig eth1| sed -n 2p | cut -b 14-25)

ETCD_NAME=$(hostname -s)

ETCD1_IP="10.64.93.231"
ETCD2_IP=${NODE_IP}
ETCD3_IP="10.64.93.233"


cat <<EOF >/etc/systemd/system/etcd.service
[Unit]
Description=etcd

[Service]
Type=notify
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --initial-advertise-peer-urls http://${NODE_IP}:2380 \\
  --listen-peer-urls http://${NODE_IP}:2380 \\
  --advertise-client-urls http://${NODE_IP}:2379 \\
  --listen-client-urls http://${NODE_IP}:2379,http://127.0.0.1:2379 \\
  --initial-cluster-token etcd-cluster-1 \\
  --initial-cluster etcd1=http://${ETCD1_IP}:2380,etcd2=http://${ETCD2_IP}:2380,etcd3=http://${ETCD3_IP}:2380 \\
  --initial-cluster-state new
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now etcd

echo "all done"
