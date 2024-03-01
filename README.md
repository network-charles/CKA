# CKA

Use the below to set and initialize your backend config variables
`terraform init -backend-config=backend.conf`

## For example
>
>backend.conf

```text
bucket = "bucket-name"
key = "object-name"
region = "eu-west-2"
dynamodb_table = "table-name"
```

## Table of Contents

1. [Lab 1: Deploy a Kubernetes Cluster on AWS EC2 and attach a Cilium CNI](#lab-1)
2. [Lab 2: Deploy a single pod to an EKS cluster](#lab-2)
3. [Lab 3: Deploy a single pod to an EKS cluster, and then scale the pod using a ReplicaSet for high availability](#lab-3)
4. [Lab 4: Deploy a Deployment with 3 Replicas, then install a new versions of the image using the Rolling Update strategy](#lab-4)
5. [Lab 5: Deploy 2 Namespaces and set a Resource Quota in them](#lab-5)
6. [Lab 6: Deploy a Replicaset and expose it using a Nodeport Service](#lab-6)
7. [Lab 7: Deploy a Replicaset and expose it using a ClusterIP Service](#lab-7)
8. [Lab 8: Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod](#lab-8)
9. [Lab 9: Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer](#lab-9)
10. [Lab 10: Manually Schedule a Pod to a Node](#lab-10)
11. [Lab 11: Taint Nodes and Add Tolerations to Pods](#lab-11)
12. [Lab 12: Label Nodes and add a NodeSelector to a Pod](#lab-12)
13. [Lab 13: Set CPU Resource Limit to a Namespace and Deploy acPod that Requests more CPU and also changes the CPU Limit](#lab-13)

## Lab 1

### Deploy a Kubernetes Cluster on AWS EC2 and attach a Cilium CNI

![Lab 1](./Images/Lab%201.png)

## Lab 2

### Deploy a single pod to an EKS cluster

![Lab 2](./Images/Lab%202.png)

## Lab 3

### Deploy a single pod to an EKS cluster, and then scale the pod using a ReplicaSet for high availability

![Lab 3](./Images/Lab%203.png)

## Lab 4

### Deploy a Deployment with 3 Replicas, then install a new versions of the image using the Rolling Update strategy

![Lab 4](./Images/Lab%204.png)

## Lab 5

### Deploy 2 Namespaces and set a Resource Quota in them

![Lab 5](./Images/Lab%205.png)

## Lab 6

### Deploy a Replicaset and expose it using a Nodeport Service

![Lab 6](./Images/Lab%206.png)

## Lab 7

### Deploy a Replicaset and expose it using a ClusterIP Service

![Lab 7](./Images/Lab%207.png)

## Lab 8

### Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod

![Lab 8](./Images/Lab%208.png)

## Lab 9

### Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer

![Lab 9](./Images/Lab%209.png)

## Lab 10

### Manually Schedule a Pod to a Node

![Lab 10](./Images/Lab%2010.png)

## Lab 11

### Taint Nodes and Add Tolerations to Pods

![Lab 11](./Images/Lab%2011.png)

## Lab 12

### Label Nodes and add a NodeSelector to a Pod

![Lab 12](./Images/Lab%2012.png)

## Lab 13

### Set CPU Resource Limit to a Namespace and Deploy acPod that Requests more CPU and also changes the CPU Limit

![Lab 13](./Images/Lab%2013.png)
