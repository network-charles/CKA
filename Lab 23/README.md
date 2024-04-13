# Instruction

## Using hostPath Persistent Volumes

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a Container and a volume directly without a persistent volume claim

`kubectl create -f no_pvc/deployment.yml`

#### Locate the mounted directory and create a file

The path `/root` on the node is what is mounted.

```bash
kubectl exec -it <pod-name> -- sh
cd mnt/myapp-volume/
touch new_file.txt
```

Depending on the node the pod was scheduled to, you can ssh into that node and check the file path to confirm that the file was created by the pod.

### Create a Container and a volume directly via a persistent volume claim

`kubectl create -f via_pvc/`

Then redo [this step](#locate-the-mounted-directory-and-create-a-file) 

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
