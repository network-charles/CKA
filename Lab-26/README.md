# Instruction

## Using Static EBS Persistent Volumes

This example focuses on using a `selector`. If you want to use `volumeName` it's more direct, no need to label the persistent volume.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a static persistent volume

`kubectl create -f yaml/selector/persistent_volume.yml`

### Label the persistent volume (optional)

If you prefer, you can remove the `labels` in the manifest file and label it directly.

`kubectl label persistentvolume cluster-pv type=ebs-storage`

### Create a static persistent volume claim (selector)

`kubectl create -f yaml/selector/persistent_volume_claim.yml`

### Confirm if the PVC and PV have been bounded

```bash
kubectl get persistentvolumeclaim

NAME        STATUS   VOLUME       CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
myapp-pvc   Bound    cluster-pv   4Gi        RWO                           <unset>                 6s
```

Yes, it has, `STATUS = Bound`.

### Provision the deployment

`kubectl apply -f yaml/selector/deployment.yml`

### Locate the mounted directory and create a file

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
touch new_file.txt
```

### View the mounted volume on the node

```bash
# view your available disk devices and their mount points.
lsblk

NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0  20G  0 part /
└─nvme0n1p128 259:2    0   1M  0 part 
nvme1n1       259:3    0   8G  0 disk /var/lib/kubelet/pods/6e04e7b0-5a38-4e62-b583-e8892045541d/volumes/kubernetes.io~csi/cluster-pv/

# The attached volume is /nvme1n1
# list the directory
ls /var/lib/kubelet/pods/6e04e7b0-5a38-4e62-b583-e8892045541d/volumes/kubernetes.io~csi/cluster-pv/

mount  vol_data.json

# list the mount directory
ls /var/lib/kubelet/pods/6e04e7b0-5a38-4e62-b583-e8892045541d/volumes/kubernetes.io~csi/cluster-pv/mount

lost+found  new_file.txt
```

Now you see that the file created in the pod exists

### Delete the deployment and recreate it

```bash
kubectl delete -f yaml/selector/deployment.yml
kubectl apply -f yaml/selector/deployment.yml
```

### Locate the mounted directory and see if the file still exists

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
ls

lost+found    new_file.txt 
```

And yes, it exists.

### Clean UP

```bash
kubectl delete -f yaml/selector/
terraform destroy -auto-approve
```
