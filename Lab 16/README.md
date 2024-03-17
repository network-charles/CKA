# Instruction

## Static Pods

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create the custom scheduler

`kubectl create -f my-scheduler.yml`

### Confirm that the scheduler pod is up

`kubectl get pod -n kube-system`

### Create a pod that uses the custom scheduler

`kubectl create -f pod.yml

Check that the pod is running using `kubectl get pod`

### Clean UP

```bash
kubectl delete -f yaml
terraform destroy -auto-approve
```
