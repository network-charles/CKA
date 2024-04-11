# Instruction

## Limit Range

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a resource limit in this default namespace

`kubectl create -f yaml/limit_range.yml`

### Confirm that the limit has the required values

`kubectl describe limitranges cpu-resource-constraint`

### Deploy a pod that is above the resource limit

`kubectl create -f yaml/pod_beyond_limit.yml.yml`

Notice an error `Invalid value: "700m": must be less than or equal to cpu limit of 500m`

### Deploy a pod with a new defined new resource limit

`kubectl create -f yaml/pod_with_new_limit.yml`

### Confirm that the pod is running on the right node

```bash
kubectl get pod

NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          4s
```

### Clean UP

```bash
kubectl delete -f yaml/
terraform destroy -auto-approve
```
