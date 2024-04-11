# Instruction

## Using resource quota

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### View the current namespaces in the cluster

`kubectl get namespace`

### View all namespaces in the cluster

`kubectl get --all-namespace`

### Create new namespaces

`kubectl create -f yaml/namespace.yml`

### Confirm the new namespaces in the cluster

`kubectl get namespace`

### Create a resource quota for these namespaces

The quota limits how many pods can be created per namespace
`kubectl create -f yaml/resource_quota.yml`

### View the quotas

`kubectl get quota --namespace dev-1`
`kubectl get quota --namespace dev-2`

OR

Check the namespace info to view quotas alocated to it.
`kubectl describe namespace dev-1`
`kubectl describe namespace dev-2`

### Create new replicasets

`kubectl create -f yaml/replicaset.yml`

### View state of the replicasets

`kubectl get replicaset --namespace dev-1`
Notice that in this namespace, only 1 pod is in the ready state due to the resource quota set in the namespace.
| NAME                | DESIRED | CURRENT | READY | AGE   |
|---------------------|---------|---------|-------|-------|
| nginx-replicaset-1  | 2       | 1       | 1     | 3m53s |

`kubectl get replicaset --namespace dev-2`
The same thing applies to the replicaset in the second namespace.
| NAME                | DESIRED | CURRENT | READY | AGE   |
|---------------------|---------|---------|-------|-------|
| nginx-replicaset-2  | 2       | 1       | 1     | 4m41s |

### Clean Up

`kubectl delete rs nginx-replicaset-1 --namespace dev-1`
`kubectl delete rs nginx-replicaset-2 --namespace dev-2`

`kubectl delete quota compute-quota-1 --namespace dev-1`
`kubectl delete quota compute-quota-2 --namespace dev-2`

`kubectl delete namespace dev-1`
`kubectl delete namespace dev-2`

`terraform destroy -auto-approve`
