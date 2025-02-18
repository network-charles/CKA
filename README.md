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

1. [Lab 01: Deploy a Kubernetes Cluster on AWS EC2 and attach a Cilium CNI](#lab-01)
2. [Lab 02: Deploy a single pod to an EKS cluster](#lab-02)
3. [Lab 03: Deploy a single pod to an EKS cluster, and then scale the pod using a ReplicaSet for high availability](#lab-03)
4. [Lab 04: Deploy 2 Namespaces and set a Resource Quota in them](#lab-04)
5. [Lab 05: Deploy a Replicaset and expose it using a Nodeport Service](#lab-05)
6. [Lab 06: Deploy a Replicaset and expose it using a ClusterIP Service](#lab-06)
7. [Lab 07: Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod](#lab-07)
8. [Lab 08: Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer](#lab-08)

### Scheduling

9. [Lab 09: Manually Schedule a Pod to a Node](#lab-09)
10. [Lab 10: Taint Nodes and Add Tolerations to Pods](#lab-10)
11. [Lab 11: Labels, Node Selectors & Affinity, Pod Affinity and Anti-Affinity](#lab-11)
12. [Lab 12: Set CPU Resource Limit to a Namespace and Deploy a Pod that Requests more CPU and also changes the CPU Limit](#lab-12)
13. [Lab 13: Deploy a DaemonSet across 2 nodes, and scale it to 3](#lab-13)
14. [Lab 14: Deploy a StaticPod into a Control Plane Node](#lab-14)
15. [Lab 15: Deploy a Custom Scheduler and a Pod that Uses It](#lab-15)

### Logging & Monitoring

16. [Lab 16: Deploy a Deployment with 3 Replicas, then install a new version of the image using the Rolling Update strategy](#lab-16)

### Application Lifecycle Management

17. [Lab 17: Deploy a Metric Server and View the Metrics of Resources](#lab-17)
18. [Lab 18: Use Command & Argument to Execute an Instruction in the Shell of a Pod](#lab-18)
19. [Lab 19: Use a ConfigMap to Dynamically Pass Configs to a Container in a Pod via its Environmental Variables](#lab-19)
20. [Lab 20: Attach a Secrets object to a Pod](#lab-20)
21. [Lab 21: Configure a multi-container Pod and send each log to a file](#lab-21)
22. [Lab 22: Configure init-container Pods which uses two services](#lab-22)

### Storage

23. [Lab 23a: Configure a deployment and use a hostPath volume type](#lab-23a)
24. [Lab 23b: Configure a deployment and use a hostPath volume type with a persistent volume and persistent volume claim](#lab-23b)
25. [Lab 24: Configure a deployment and use a static local volume type with a persistent volume and persistent volume claim](#lab-28)
26. [Lab 25: Configure a deployment and use a dynamic EBS volume type with a persistent volume, persistent volume claim](#lab-25)
27. [Lab 26: Configure a deployment and use a static EBS volume type with a persistent volume, persistent volume claim](#lab-26)
28. [Lab 27: Configure a deployment and use a dynamic NFS volume type with a persistent volume and persistent volume claim](#lab-27)
29. [Lab 28: Configure a deployment and use a dynamic local volume type with a persistent volume, persistent volume claim, and a snapshot](#lab-28)

#### Storage for Application Lifecycle Management

30. [Lab 29: Mounting a config map to a deployment as a volume](#lab-29)
31. [Lab 30: Mounting secrets to a deployment as a volume](#lab-30)

#### Cluster Maintenance

32. [Lab 31: Performing OS patches on a node](#lab-31)
33. [Lab 32: Upgrading/Downgrading a cluster](#lab-32)
34. [Lab 33: Backup & Restore an ETCD Cluster using a Volume](#lab-33)

#### Security

35. [Lab 34: User Authentication using Certificates and kubeconfig](#lab-34)
36. [Lab 35: User Authorization using Roles and Role Bindings](#lab-35)
37. [Lab 36: User Authorization using Cluster Roles and Cluster Role Bindings](#lab-36)
38. [Lab 37: Service Accounts](#lab-37)
39. [Lab 38: Private Image Repository](#lab-38)
40. [Lab 39: Security Contexts](#lab-39)
41. [Lab 40: Network Policies](#lab-40)

#### High Availability

42. [Lab 41: Multi-Cluster](#lab-41)

## Lab 01

### Deploy a Kubernetes Cluster on AWS EC2 and attach a Cilium CNI

![Lab 01](./Images/Lab%2001.png)

## Lab 02

### Deploy a single pod to an EKS cluster

![Lab 02](./Images/Lab%2002.png)

## Lab 03

### Deploy a single pod to an EKS cluster, and then scale the pod using a ReplicaSet for high availability

![Lab 03](./Images/Lab%2003.png)

## Lab 04

### Deploy 2 Namespaces and set a Resource Quota in them

![Lab 04](./Images/Lab%2004.png)

## Lab 05

### Deploy a Replicaset and expose it using a Nodeport Service

![Lab 05](./Images/Lab%2005.png)

## Lab 06

### Deploy a Replicaset and expose it using a ClusterIP Service

![Lab 06](./Images/Lab%2006.png)

## Lab 07

### Deploy a Replicaset and an ExternalName service. Access the service via its metadata name from inside each pod

![Lab 07](./Images/Lab%2007.png)

## Lab 08

### Deploy a Replicaset and a LoadBalancer service. Use an AWS Load Balancer

![Lab 08](./Images/Lab%2008.png)

## Lab 09

### Manually Schedule a Pod to a Node

![Lab 09](./Images/Lab%2009.png)

## Lab 10

### Taint Nodes and Add Tolerations to Pods

![Lab 10](./Images/Lab%2010.png)

## Lab 11

### Labels, Node Selectors & Affinity, Pod Affinity and Anti-Affinity

![Lab 11](./Images/Lab%2011.png)

## Lab 12

### Set CPU Resource Limit to a Namespace and Deploy a Pod that Requests more CPU and also changes the CPU Limit

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

### Attach a Secrets object to a Pod

![Lab 20](./Images/Lab%2020.png)

## Lab 21

### Configure a multi-container Pod and send each log to a file

![Lab 21](./Images/Lab%2021.png)

## Lab 22

### Configure init-container Pods which uses two services

![Lab 22](./Images/Lab%2022.png)

## Lab 23a

### Configure a deployment and use a hostPath volume type

![Lab 23a](./Images/Lab%2023a.png)

## Lab 23b

### Configure a deployment and use a hostPath volume type with a persistent volume and persistent volume claim

![Lab 23b](./Images/Lab%2023b.png)

## Lab 24

### Configure a deployment and use a static local volume type with a persistent volume and persistent volume claim

![Lab 24](./Images/Lab%2024.png)

## Lab 25

### Configure a deployment and use a dynamic EBS volume type with a persistent volume and persistent volume claim

![Lab 25](./Images/Lab%2025.png)

## Lab 26

### Configure a deployment and use a static EBS volume type with a persistent volume and persistent volume claim

![Lab 26](./Images/Lab%2026.png)

## Lab 27 -- in progress

## Lab 28

### Configure a deployment and use a dynamic local volume type with a persistent volume, persistent volume claim and a snapshot

![Lab 28](./Images/Lab%2028.png)

## Lab 29

### Mounting a config map to a deployment as a volume

![Lab 29](./Images/Lab%2029.png)

## Lab 30

### Mounting secrets to a deployment as a volume

![Lab 30](./Images/Lab%2030.png)

## Lab 31

### Performing OS patches on a node

![Lab 31](./Images/Lab%2031.png)

## Lab 32

### Upgrading/Downgrading a Cluster

![Lab 32](./Images/Lab%2032.png)

## Lab 33

### Backup & Restore an ETCD Cluster using a Volume

![Lab 33](./Images/Lab%2033.png)

## Lab 34

### User Authentication using Certificates and kubeconfig

![Lab 34](./Images/Lab%2034.png)

## Lab 35

### User Authorization using Roles and Role Bindings

![Lab 35](./Images/Lab%2035.png)

## Lab 36

### User Authorization using Cluster Roles and Cluster Role Bindings

![Lab 36](./Images/Lab%2036.png)

## Lab 37

### Service Accounts

![Lab 37](./Images/Lab%2037.png)

## Lab 38

### Private Image Repository

![Lab 38](./Images/Lab%2038.png)

## Lab 39

### Security Contexts

![Lab 39](./Images/Lab%2039.png)

## Lab 40

### Network Policies

![Lab 40](./Images/Lab%2040.png)

## Lab 41

### Multi-Cluster

![Lab 41](./Images/Lab%2041.png)
