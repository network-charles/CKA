# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create new replicasets

`kubectl create -f yaml/replicaset.yml`

## Confirm the all pods in the replicaset are running

`kubectl get pod`

## Create a Cluster IP Service

`kubectl create -f yaml/service.yml`

OR

`kubectl create service clusterip NAME [--tcp=<port>:<targetPort>] [--dry-run=server|client|none]`

OR

`kubectl expose replicaset nginx-replicaset-1  --type=ClusterService  --name=nginx-service-nodeport  --target-port=80 --port=80`

## Clean Up

`terraform destroy -auto-approve`
