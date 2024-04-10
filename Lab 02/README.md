# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create a pod

`kubectl apply -f yaml/`
OR
`kubectl run nginx --image nginx:alpine`

## Confirm that the pod is up and running

`kubectl get pod`

## CleanUp

`kubectl delete pod nginx`
`terraform destroy -auto-approve`
