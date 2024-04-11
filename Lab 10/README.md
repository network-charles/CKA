# Instruction

## Initialize Kubernetes Cluster

`sudo kubeadm init`

Do other necessary configs like setting up the client, and using the join config and token to add the worker nodes to the cluster.

## Reinstall Cilium

The CNI plugin don't seem to install successfuly until the cluster is up. So re-install Cilium.
`cilium install --version 1.15.0`

## View Cilium Pods

`kubectl get pods --all-namespaces`

## Confirm Nodes are Up

```bash
kubectl get nodes

NAME               STATUS   ROLES           AGE   VERSION
ip-192-168-1-186   Ready    control-plane   46m   v1.29.2
ip-192-168-2-114   Ready    <none>          45m   v1.29.2
ip-192-168-3-104   Ready    <none>          45m   v1.29.2
```

## Taint all Nodes so they can reject pods

```bash
kubectl taint nodes <node_name> key1=value1:NoSchedule

kubectl taint nodes <node_name> key1=value1:NoSchedule
```

Confirm that the node has been tainted

```bash
kubectl describe node <node_name> | grep -i taint

kubectl describe node <node_name> | grep -i taint
```

## Create a pod and observe the status

```bash
kubectl create -f yaml/pod.yml

kubectl get pods

NAME    READY   STATUS    RESTARTS   AGE
nginx   0/1     Pending   0          11s
```

The pod is stuck in a pending state because it has been rejected by nodes.

## Add a toleration the pod so that it can be scheduled to a node

Append the below inside a pod spec.

```bash
tolerations:
    - key: "key1"
      operator: "Equal"
      value: "value1"
      effect: "NoSchedule"

kubectl create -f yaml/tolerated_pod.yml
```

Confirm that the pod is in a running state

```bash
kubectl get pod

NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          68s
```

## Clean Up

```bash
kubectl delete -f yaml/
terraform destroy -auto-approve
```
