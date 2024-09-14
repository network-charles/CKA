# Deploy a Replicaset and expose it using a Nodeport Service

# Create cluster
`kind create cluster --config cluster.yaml`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create new replicasets

`kubectl apply -f replicaset.yml`

## Confirm the all pods in the replicaset are running

`kubectl get pod`

## Create new NodePort service

`kubectl apply -f service.yml`

OR

`kubectl create service nodeport NAME [--tcp=port:targetPort]`

OR

`kubectl expose replicaset nginx-replicaset-1  --type=NodePort  --name=nginx-service-nodeport  --target-port=80 --port=30008`

## Confirm the new service in the cluster

`kubectl get service`

## Curl to the web server using the node-port detail

`curl <public_ip>:<port>`

## Clean Up

`kind delete cluster`
