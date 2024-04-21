# Instruction

## Performing OS patches on a node

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm Nodes are Up

`kubectl get nodes`

### Create a fluentd daemonset

`kubectl apply -f yaml/daemonset.yml`

### Drain the second node so it's ready to go for maintenance

Since the pod is part of a **daemonset**, the flag has to be used. Regardless, the pod won't be deleted because the daemonset controller will replace it. The same thing applies to a **daemonset** and also a **replicaset**.
The node will also become unschedulable because of this.

`kubectl drain <node_name> --ignore-daemonsets`

To test that the node is now unschedulable, deploy a simple pod that uses the node label as a nodeSelector.

```bash
kubectl apply -f /yam/pod.yml

kubectl get pod unschedulable-pod   

NAME                READY   STATUS    RESTARTS   AGE
unschedulable-pod   0/1     Pending   0          22s
```

We can see that the pod is stuck in a pending state.

### Perform an OS update on the node

This package doesn't relate to this lab. You can do any form of package update you want.

`yum install nano -y`

### Make the node schedulable again

`kubectl uncordon <node_name>`

Now observe that the `unchedulable-pod` will now be successfully scheduled to the node.

```bash
kubectl get pod unschedulable-pod

NAME                READY   STATUS    RESTARTS   AGE
unschedulable-pod   1/1     Running   0          3m59s
```

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
