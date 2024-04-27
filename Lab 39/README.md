# Instruction

## Security Contexts

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm Nodes are Up

`kubectl get nodes`

### Create a deployment

`kubectl apply -f yaml/`

In the configuration file, runAsUser sets the user ID to 1000 for all processes in the Pod's Containers, while runAsGroup sets the group ID to 3000.

All processes, folder and files will be restricted access to the user or group.
Only folders by a mounted volume is accessible. But if you change the user to `root` by specifying 0, every other thing works.

To restrict this securityContext to only one container in the pod, specify `spec.containers.securityContext` instead.

### Clean UP

```bash
kubectl delete -f yaml/

terraform destroy -auto-approve
```
