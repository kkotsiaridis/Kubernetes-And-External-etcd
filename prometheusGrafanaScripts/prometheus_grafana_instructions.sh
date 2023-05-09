#############Install Prometheus

sudo hostname PrometheusGrafana
sudo useradd --system --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz
tar -xvf prometheus-2.32.1.linux-amd64.tar.gz
sudo mkdir -p /data /etc/prometheus
cd prometheus-2.32.1.linux-amd64
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/

nano prometheus.yml

- job_name: "etcd-external"
    scrape_interval: 5s
    metrics_path: /metrics
    static_configs:
      - targets: ["10.64.93.231:2379", "10.64.93.232:2379","10.64.93.233:2379"] 

#-targets: ["<etcd1 eth1 ip>:2379", "<etcd1 eth2 ip>:2379","<etcd1 eth3 ip>:2379"] 

sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
cd
rm -rf prometheus*
prometheus --version

sudo nano /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target

sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus

############# Install Grafana

sudo apt-get install -y apt-transport-https software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get -y install grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl status grafana-server


############# Get Access to Grafana from your PC
# 1) Enable  VPN uth
# 2) Find your PC's allocated ip address in VPN uth with cmd
# 3) In prometheus node run:
#   a) dhclient eth1
#   b) route add -net 10.64.44.0/23 gw 10.64.92.1  //your VPN uth network
# 4)If needed disable some options from your host PC
#         (for windows:Setting-->Update&Security-->Firewall-->AdvancedSettings-->PropertiesForWindowsDefenderFirewall
#          -->PublicProfile-->SecureNetworkConnections-->RemoveTickFrom VPN uth)






