# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Install the AWS load balancer controller

- Create OIDC
- Create required load balancer role and policies
- Create a kubernetes service account
- Use helm to install the load balancer controller

## Create new replicasets

`kubectl create -f yaml/replicaset.yml`

## Confirm the all pods in the replicaset are running

`kubectl get pod`

## Create a Load Balancer Service

`kubectl create -f yaml/service.yml`

OR

```zsh
kubectl expose replicaset nginx-replicaset-1 --port=80 \
        --name=load-balancer --type=LoadBalancer
```

## Confirm that the load balancer service has ben created

`kubectl get service`

Copy the dns name of the load balancer and paste it into your browser to access the nginx web server homepage.

## Clean Up

`kubectl -f delete yaml`

`terraform destroy -auto-approve`
