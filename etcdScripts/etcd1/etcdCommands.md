ETCD commands with TLS encryption in etcd endpoints:
-------------

  ETCDCTL_API=3 etcdctl \
    --endpoints=https://172.16.16.221:2379,https://172.16.16.222:2379,https://172.16.16.223:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    member list -w=table


  ETCDCTL_API=3 etcdctl \
    --endpoints=https://172.16.16.221:2379,https://172.16.16.222:2379,https://172.16.16.223:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    endpoint status -w=table


  ETCDCTL_API=3 etcdctl \
    --endpoints=https://172.16.16.221:2379,https://172.16.16.222:2379,https://172.16.16.223:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    move-leader <leader>

  ETCDCTL_API=3 etcdctl \
    --endpoints=https://172.16.16.221:2379,https://172.16.16.222:2379,https://172.16.16.223:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem \
    get / --prefix --keys-only

  ETCDCTL_API=3 etcdctl \
  --endpoints=https://172.16.16.221:2379,https://172.16.16.222:2379,https://172.16.16.223:2379 \
  --cacert=/etc/etcd/pki/ca.pem \
  --cert=/etc/etcd/pki/etcd.pem \
  --key=/etc/etcd/pki/etcd-key.pem \
  del "" --from-key=true


ETCD commands without TLS encryption:
---------------
  ETCDCTL_API=3 etcdctl \
    --endpoints=https://10.64.93.202:2379,https://10.64.93.231:2379,https://172.16.16.90:2379 \
    del "" --from-key=true
