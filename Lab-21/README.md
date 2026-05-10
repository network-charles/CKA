# Instruction

## Multi-container deployment and logs

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a multi-container deployment

This comprises of an nginx and fluentd container.

`kubectl create -f deployment.yml`

### Send the logs of both containers to a file

In a multi-container deploymemt the logs select only one container at a time, so a flag `--all-containers=true` to output all containers need to be used.

`kubectl logs deployment/multi-container-deployment --all-containers=true > logs.txt`

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
