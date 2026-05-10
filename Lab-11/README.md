# Instruction

## Labels, Node Selectors & Affinity, Pod Affinity and Anti-Affinity

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Manually Label the Nodes

```bash
kubectl label nodes <node_name> az=eu-west-2a
kubectl label nodes <node_name> az=eu-west-2b
```

### Confirm that the node has the label

`kubectl get nodes --show-labels | grep -i az=`

### Deploy a pod that will be assigned to that node using node selector

`kubectl create -f yaml/node_selector_pod.yml`

### Confirm that the pod is scheduled to the node with label `az=eu-west-2a`

`kubectl get pod -o wide`

If no nodes are labelled with `az=eu-west-2a` or `az=eu-west-2b` the scheduled pod will be stuck in a pending state.

### CleanUp1

`kubectl delete -f yaml/node_selector_pod.yml`

## Node Affinity (required)

The existing applied node labels configuration will be used.

### Deploy a pod that will be assigned to `eu-west-2a` labelled node using node affinity

`kubectl create -f yaml/node_affinity_pod_req.yml`

The condition `requiredDuringSchedulingIgnoredDuringExecution` will be used, as this is a strict requirement.

### Confirm that the pod is running on the right node

```bash
kubectl get nodes --show-labels

NAME    READY   STATUS    RESTARTS   AGE   IP              NODE                                         NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          10s   192.168.1.153 ->ip-192-168-1-55.eu-west-2.compute.internal<- <none>           <none>

kubectl get pods --output=wide

NAME    READY   STATUS    RESTARTS   AGE   IP              NODE                                         NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          44s   192.168.1.153 ->ip-192-168-1-55.eu-west-2.compute.internal<- <none>           <none>

```

### Clean Up 2

`kubectl delete -f yaml/node_affinity_pod_req.yml`

## Node Affinity (preferred)

The existing applied node labels configuration will be used.

### Deploy a pod that will be assigned to `eu-west-2c` labeled node using node affinity

`kubectl create -f node_affinity_pod_pref.yml`

Notice that since no node is labelled `eu-west-2c` the scheduler still tries to schedule the pod to some other node

```bash
kubectl get pod

NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          11s
```

## Inter pod affinity

Pods can be scheduled to nodes based on the labels of Pods already running on that node, instead of the node labels. Pods are attracted to pods, not nodes.

### Delete the existing node labels

Only the key is used to delete the label key-value pair.
`kubectl label nodes <node_name> az-`

### Deploy a new pod

This pod has a label that will match incoming pods. It will also scheduled to any node in the `eu-west-2` region via the `topology.kubernetes.io/region=eu-west-2` key value pair label. The label is available on EKS nodes on default.

`kubectl create -f yaml/pod.yml`

### Confrm that the pod is running

```bash
kubectl get pod

NAME     READY   STATUS    RESTARTS   AGE
nginx1   1/1     Running   0          2s
```

### Deploy another new pod

All nodes in the cluster must have the same node label, specified via the `topologyKey`

This new pod will be scheduled to a node in the region if any existing pod has the label `region=eu-west-2`.
Since a pod already exists in the region, this pod will be deployed successfully.

`kubectl create -f yaml/inter_pod_affinity_pod.yml`

### Confirm that the pod is running

```bash
kubectl get pod

NAME     READY   STATUS    RESTARTS   AGE
nginx1   1/1     Running   0          4m41s
nginx2   1/1     Running   0          10s
```

From the above output, the pod is running successfully along with the initial pod.

### Delete all pods

```bash
kubectl delete -f yaml/pod.yml
kubectl delete -f yaml/inter_pod_affinity_pod.yml
```

### Try to deploy only the pod with inter-pod affinity

`kubectl create -f yaml/inter_pod_affinity_pod.yml`

Notice that the pod is stuck in a pending state because no pod with the label `region=eu-west-2` exists in the cluster.

```bash
NAME     READY   STATUS    RESTARTS   AGE
nginx2   0/1     Pending   0          41s
```

> You can configure `preferredDuringSchedulingIgnoredDuringExecution` if you want. It will make the pod successfuly run even if you never deployedthe inital pod.

### CleanUp3

`kubectl delete -f yaml/inter_pod_affinity_pod.yml`

## Anti affinity

The anti-affinity rule specifies that the scheduler should try to avoid scheduling the Pod on a node if that node belongs to a specific zone where other Pods have been labeled

### Deploy a new pod again

This pod has a label that will match incoming pods. It is also scheduled to any node in the `eu-west-2` region via the `topology.kubernetes.io/region=eu-west-2a` key-value pair.

`kubectl create -f yaml/pod.yml`

### Deploy another new pod `nginx3` again

`kubectl create -f yaml/anti_affinity_pod.yml`

Notice that the pod `nginx3` is stuck in a pending state because a pod with the label `region=eu-west-2` exists in the cluster.

```bash
kubectl get pod 

NAME     READY   STATUS    RESTARTS   AGE    
nginx1   1/1     Running   0          1m7s  
nginx3   0/1     Pending   0          11s 
```

> You can configure `preferredDuringSchedulingIgnoredDuringExecution` if you want. It will make the pod successfuly run regardless.

### Clean UP

```bash
kubectl delete -f yaml/anti_affinity_pod.yml
kubectl delete -f yaml/pod.yml
terraform destroy -auto-approve
```
