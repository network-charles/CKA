# Instruction

## Initialize Kubernetes Cluster

`sudo kubeadm init`

Do other necessary configs like setting up the client on the master node, and using the join config and token to add the worker nodes to the cluster.

## Reinstall Cilium on the Master Node

The CNI plugin don't seem to install successfuly until the cluster is up. So re-install Cilium.
`cilium install --version 1.15.0`

## View Cilium Pods

`kubectl get pods --all-namespaces`

## Confirm Nodes are Up

`kubectl get nodes`
