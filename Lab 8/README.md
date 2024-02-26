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

`kubectl create service externalname NAME --external-name my.nginx.com`

## Confirm that the external name service has ben created

`kubectl get service`

## Go into the container shell to execute a command

`kubectl exec -it <pod_name> -- /bin/sh`

## Do a nameserver lookup of the metadata name of the externalName service

`nslookup external-name`
It should point to the address specified in the service.

To access the service from a pod in another namespace
`nslookup external-name.svc.cluster.local`

## Clean Up

`kubectl -f delete yaml`

`terraform destroy -auto-approve`
