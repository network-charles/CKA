# Instruction

## Using Commands & Arguments

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Deploy a pod that has its command and argument set

`kubectl apply -f yaml`

### View the output of the command via the logs

Since pods are not meant to run for long, this pod will stop after executing the command successfuly.

`kubectl logs ubuntu`

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
