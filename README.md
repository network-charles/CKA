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

### Core Concepts

1. [Lab 1: Deploy a Kubernetes Cluster on AWS EC2 and attach a Cilium CNI](#lab-1)
2. [Lab 2: Deploy a single pod to an EKS cluster](#lab-2)
3. [Lab 3: Deploy a single pod to an EKS cluster, and then scale the pod using a ReplicaSet for high availability](#lab-3)
4. [Lab 4: Deploy 2 Namespaces and set a Resource Quota in them](#lab-4)
5. [Lab 5: Deploy a Replicaset and expose it using a Nodeport Service](#lab-5)
6. [Lab 6: Deploy a Replicaset and expose it using a ClusterIP Service](#lab-6)
7. [Lab 7: Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod](#lab-7)
8. [Lab 8: Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer](#lab-8)

### Scheduling

9. [Lab 9: Manually Schedule a Pod to a Node](#lab-9)
10. [Lab 10: Taint Nodes and Add Tolerations to Pods](#lab-10)
11. [Lab 11: Label Nodes and add a NodeSelector to a Pod](#lab-11)
12. [Lab 12: Set CPU Resource Limit to a Namespace and Deploy a Pod that Requests more CPU and also changes the CPU Limit](#lab-12)
13. [Lab 13: Deploy a DaemonSet across 2 nodes, and scale it to 3](#lab-13)
14. [Lab 14: Deploy a StaticPod into a Control Plane Node](#lab-14)
15. [Lab 15: Deploy a Custom Scheduler and a Pod that Uses It](#lab-15)

### Logging & Monitoring

16. [Lab 16: Deploy a Metric Server and View the Metrics of Resources](#lab-16)

### Application Lifecycle Management

17. [Lab 17: Deploy a Deployment with 3 Replicas, then install a new version of the image using the Rolling Update strategy](#lab-17)
18. [Lab 18: Use Command & Argument to Execute an Instruction in the Shell of a Pod](#lab-18)
19. [Lab 19: Use a ConfigMap to Dynamically Pass Configs to a Container in a Pod via its Environmental Variables](#lab-19)
20. [Lab 20: Attach a Secrets onject to a Pod](#lab-20)
21. [Lab 21: Configure a multi-container Pod and send each log to a file](#lab-21)
22. [Lab 22: Configure init-container Pods and which uses two services](#lab-22)

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

### Deploy 2 Namespaces and set a Resource Quota in them

![Lab 4](./Images/Lab%204.png)

## Lab 5

### Deploy a Replicaset and expose it using a Nodeport Service

![Lab 5](./Images/Lab%205.png)

## Lab 6

### Deploy a Replicaset and expose it using a ClusterIP Service

![Lab 6](./Images/Lab%206.png)

## Lab 7

### Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod

![Lab 7](./Images/Lab%207.png)

## Lab 8

### Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer

![Lab 8](./Images/Lab%208.png)

## Lab 9

### Manually Schedule a Pod to a Node

![Lab 9](./Images/Lab%209.png)

## Lab 10

### Taint Nodes and Add Tolerations to Pods

![Lab 10](./Images/Lab%2010.png)

## Lab 11

### Label Nodes and add a NodeSelector to a Pod

![Lab 11](./Images/Lab%2011.png)

## Lab 12

### Set CPU Resource Limit to a Namespace and Deploy acPod that Requests more CPU and also changes the CPU Limit

![Lab 12](./Images/Lab%2012.png)

## Lab 13

### Deploy a DaemonSet across 2 nodes, and scale it to 3

![Lab 13](./Images/Lab%2013.png)

## Lab 14

### Deploy a StaticPod into a Control Plane Node

![Lab 14](./Images/Lab%2014.png)

## Lab 15

### Deploy a Custom Scheduler and a Pod that Uses It

![Lab 15](./Images/Lab%2015.png)

## Lab 16

### Deploy a Deployment with 3 Replicas, then install a new version of the image using the Rolling Update strategy

![Lab 16](./Images/Lab%2016.png)

## Lab 17

### Deploy a Metric Server and View the Metrics of Resources

![Lab 17](./Images/Lab%2017.png)

## Lab 18

### Use Command & Argument to Execute an Instruction in the Shell of a Pod

![Lab 18](./Images/Lab%2018.png)

## Lab 19

### Use a ConfigMap to Dynamically Pass Configs to a Container in a Pod via its Environmental Variables

![Lab 19](./Images/Lab%2019.png)

## Lab 20

### Attach a Secrets onject to a Pod

![Lab 20](./Images/Lab%2020.png)

## Lab 21

### Configure a multi-container Pod and send each log to a file

![Lab 21](./Images/Lab%2021.png)

## Lab 22

### Configure init-container Pods and which uses two services

![Lab 22](./Images/Lab%2022.png)
