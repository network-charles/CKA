# Instruction

## Service Accounts

Pods use a specific default (optional) ServiceAccount to authenticate with the API server, and every namespace has at least one default ServiceAccount.

> Inside a pod, the ServiceAccount is mounted as a Secrets object volume.

It can be launched as the following:

1. Volume projection
2. ImagePullSecrets
3. By a new token generated via a Secrets object and attached to an existing ServiceAccount.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm Nodes are Up

`kubectl get nodes`

### View the default service account

``` bash
kubectl get serviceaccounts

NAME      SECRETS    AGE
default   1          1d
```

### Create a service account and a deployment

```bash
kubectl apply -f yaml/
kubectl get sa

NAME       SECRETS   AGE
default    0         14d
svc-acct   0         20m
```

### Exec into the pod and try a `kubectl` command

```bash
kubectl exec -it <pod-name> -- /bin/bash

#/ kubectl get pod

Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "default"
```

### Create a role and a rolebinding that attaches to the service account

```bash
kubectl create role pod-reader --verb=get --verb=list --resource=pod 

OR

kubectl apply -f yaml/role.yml

kubectl create rolebinding read-pods --role=sa --serviceaccount=default:svc-acct

OR

kubectl apply -f yaml/role_binding.yml
```

### Try to get a pod using kubectl from inside the pod

```bash
kubectl exec -it <pod-name> -- /bin/bash

kubectl get pod

NAME                                  READY   STATUS    RESTARTS   AGE
kubectl-deployment-7479cdb9c9-hpzfd   1/1     Running   0          2m19s
```

### Clean UP

```bash
kubectl delete -f yaml/

terraform destroy -auto-approve
```
