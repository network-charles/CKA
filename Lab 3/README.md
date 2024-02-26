# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create a pod

`kubectl apply -f yaml/pod.yml`
OR
`kubectl create pod nginx --image=nginx:alpine`

## Confirm that the pod has been created

`kubectl get pod`

## Create a replicaset to manage the pod so it restarts if it fails or gets deleted

`kubectl apply -f yaml/replicaset.yml`
OR
`kubectl create replicaset nginx-replicaset --replicas=3`

## Confirm the replicaset is up and running

`kubectl get replicaset`

## Delete the existing single pod

`kubectl delete pod nginx`

## Confirm that the pod has been recreated

`kubectl get pod`

## Scale the replicaset by adding 1 using kubectl

`kubectl scale replicaset nginx-replicaset --replicas=2`

## Scale the replicaset by adding 1 and editing the startup replicaset file and reapplying it. Replicaset is now 2

`vi replicaset.yml`
`kubectl delete replicasets nginx-replicaset`
`kubectl create -f replicaset.yml`

## Scale the replicaset by adding 1 and editing the startup replicaset file and reapplying it. Replicaset is now 3

`kubectl edit replicaset nginx-replicaset`

## Delete the replicaset resource

`kubectl delete replicaset nginx-replicaset`

## Edit the replicaset file to use a wrong image name 'ngginx`

`vi yaml/replicaset.yml`

## Create the new replicaset

`kubectl apply -f yaml/replicaset`

## Confirm that the pod has been created wrongly | check pod `status`

`kubectl get pod`

## Edit the running file of the replicaset with the correct image

`kubectl edit replicaset nginx-replicaset`

## Delete the existing pods so new pods are created with the correct images

`kubectl delete pod <pod_name>`

## Confirm that the pods have been recreated | check pod `status`

`kubectl get pod`

## Clean Up

`kubectl delete replicaset nginx-replicaset`

`terraform destroy -auto-approve`
