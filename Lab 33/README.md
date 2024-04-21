# Instruction

## Backup & Restore an ETCD Cluster using a Volume

We will be patching v1.29.3 to v1.29.3

## Initialize Kubernetes Cluster

`sudo kubeadm init`

1. Set up the client on the master node.
2. Use the join config and token to add the worker nodes to the cluster.

## Reinstall Cilium on the Master Node

The CNI plugin doesn't seem to install successfully until the cluster is up. So re-install Cilium.
`cilium install --version 1.15.0`

## View Cilium Pods

`kubectl get pods --all-namespaces`

### Confirm Nodes are Up

`kubectl get nodes`

### Spin up a pre-backup pod

`k run before-backup --image=nginx:alpine`

### Build a snapshot

```bash
ETCDCTL_API=3 etcdctl --endpoints 127.0.0.1:2379 snapshot save snapshot.db \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
--cacert=/etc/kubernetes/pki/etcd/ca.crt
```

### Verify that the snapshot exists

```bash
ETCDCTL_API=3 etcdctl --write-out=table snapshot status snapshot.db

+----------+----------+------------+------------+
|   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE |
+----------+----------+------------+------------+
| f83b5f1f |     4363 |       1534 |     6.7 MB |
+----------+----------+------------+------------+
```

### Delete the pre-backup pod

`kubectl delete pod pre-backup --force=true`

### Create a post-backup pod 

`kubectl run post-backup --image=nginx:alpine`

### Restore the snapshot

```bash
# Delete the previous etcd files
rm -rf /var/lib/etcd

ETCDCTL_API=3 etcdctl --endpoints 127.0.0.1:2379 --data-dir /var/lib/etcd snapshot restore snapshot.db \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
--cacert=/etc/kubernetes/pki/etcd/ca.crt
```

Notice how it recovers the `pre-backup` pod and the `post-backup` pod no longer exists.

```bash
kubectl get pod

NAME        READY   STATUS    RESTARTS   AGE
pre-backup   1/1     Running   0          35m
```

### Clean UP

`terraform destroy -auto-approve`
