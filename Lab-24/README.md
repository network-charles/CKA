# Instruction

## Using Static Persistent Volumes

This uses a volume from the node specified via a node affinity.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a static local persistent volume

The defined storage size available 
`kubectl create -f persistent_volume.yml`

### Create a static local persistent volume claim

`kubectl create -f persistent_volume_claim.yml`

### Provision the deployment

`kubectl create -f deployment.yml`

### Locate the mounted directory and create a file

The path `/root` on the node is what is mounted.

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
touch new_file.txt
```

Depending on the node the pod was scheduled to, you can ssh into that node and check the file path to confirm that the file was created by the pod.

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```