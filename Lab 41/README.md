# Instruction

## Multi-Cluster

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create new replicasets

`kubectl create -f yaml/replicaset.yml`

## Confirm the all pods in the replicaset are running

`kubectl get pod`

## Create new NodePort service

`kubectl create -f yaml/service.yml`

OR

`kubectl create service nodeport NAME [--tcp=port:targetPort]`

OR

`kubectl expose replicaset nginx-replicaset-1  --type=NodePort  --name=nginx-service-nodeport  --target-port=80 --port=30008`

## Confirm the new service in the cluster

`kubectl get service`

## Curl to the web server using the node-port detail

`curl <public_ip>:<port>`

## Clean Up

`kubectl delete -f yaml`

`terraform destroy -auto-approve`
