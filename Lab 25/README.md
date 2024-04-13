# Instruction

## Using Dynamic Local Persistent Volumes

This uses a volume from the node specified via a node affinity.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a dynamic persistent volume claim

`kubectl create -f yaml/persistent_volume_claim.yml`

### Create a storage class

`kubectl create -f yaml/storage_class.yml`

### Provision the deployment

`kubectl create -f yaml/deployment.yml`

### Confirm if the persistent volume has been dynamically provisioned

```bash
kubectl get persistentvolume                                                                                                     
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-56c47d38-f494-4ccd-8c79-b9ffded6d578   4Gi        RWO            Delete           Bound    default/myapp-pvc   ebs-storage    <unset>                          15s
```

### Locate the mounted directory and create a file

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
touch new_file.txt
```

### Delete the deployment and recreate it

```bash
kubectl delete -f yaml/deployment.yml
kubectl create -f yaml/deployment.yml
```

### Locate the mounted directory and see if the file still exist

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
ls
```

And yes, it exists.

### Clean UP

```bash
kubectl delete -f yaml
terraform destroy -auto-approve
```
