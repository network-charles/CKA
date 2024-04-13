# Instruction

## Using Dynamic Local Persistent Volumes

This uses a volume from the node specified via a node affinity.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Apply the required [Custom Resource Definition (CRD)](https://github.com/kubernetes-csi/external-snapshotter/tree/master/client/config/crd)

A Custom Resource Definition (CRD) is an extension of the Kubernetes application programming interface (API).

```bash
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml

kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml

kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
```

### Apply the [Snapshot Controller](https://github.com/kubernetes-csi/external-snapshotter/tree/master/deploy/kubernetes/snapshot-controller)

```bash
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/kustomization.yaml

kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml

kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml
```

### Create a dynamic persistent volume claim

`kubectl create -f yaml/persistent_volume_claim.yml`

### Create a storage class

`kubectl create -f yaml/storage_class.yml`

### Create a snapshot class

`kubectl create -f yaml/snapshot_class.yml`

### Provision the deployment

A new file has already been created using the argument variable in the deployment manifest.

`kubectl create -f yaml/deployment.yml`

### Create a snapshot

`kubectl create -f yaml/snapshot.yml`

### Confirm if the persistent volume has been dynamically provisioned

```bash
kubectl get persistentvolume                                                                                                     
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-56c47d38-f494-4ccd-8c79-b9ffded6d578   4Gi        RWO            Delete           Bound    default/myapp-pvc   ebs-storage    <unset>                          15s
```

### Confirm if the snapshot and snapshot-content has been dynamically provisioned

```bash
kubectl get volumesnapshot
                                                                                              
NAME           READYTOUSE   SOURCEPVC   SOURCESNAPSHOTCONTENT   RESTORESIZE   SNAPSHOTCLASS   SNAPSHOTCONTENT                                    CREATIONTIME   AGE
new-snapshot   true         myapp-pvc                           4Gi           ebs-vsc         snapcontent-74160888-d667-49cd-8154-0850eed34635   61s            99s


kubectl get volumesnapshotcontent

NAME                                               READYTOUSE   RESTORESIZE   DELETIONPOLICY   DRIVER            VOLUMESNAPSHOTCLASS   VOLUMESNAPSHOT   VOLUMESNAPSHOTNAMESPACE   AGE
snapcontent-74160888-d667-49cd-8154-0850eed34635   false        4294967296    Delete           ebs.csi.aws.com   ebs-vsc               new-snapshot     default                   15s
```

### Clean UP

```bash
kubectl delete -f yaml
terraform destroy -auto-approve
```
