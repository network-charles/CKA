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

The IP addresses are dynamically generated.

## Crash the kube-scheduler

```bash
sudo nano /etc/kubernetes/manifests/kube-scheduler.yaml

Rename the below part 'scheduler.conf' to 'scheduler.confx`
- --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
- --authorization-kubeconfig=/etc/kubernetes/scheduler.conf

Confirm that the schduler has crashed 
kubectl get pod --namespace kube-system
```

## Spin up a new pod that uses the default scheduler

`kubectl create -f yaml/no_automatic_scheduler_pod.yml`

Confirm that the pod is stuck at pending state, and also that it is not assigned to a node

```bash
kubectl get pod --output wide

NAME              READY   STATUS    RESTARTS   AGE     IP           NODE               NOMINATED NODE   READINESS GATES
nginx-automatic   0/1     Pending   0          2m59s   <none>       <none>             <none>           <none>
```

## Spin up a new pod and manually schedule it to a node

`kubectl create -f manual_scheduler_pod.yml`

Confirm that the pod is in a running state, and also that it is assigned a node named `ip-192-168-2-114`

```bash
kubectl get pod --output wide`

NAME              READY   STATUS    RESTARTS   AGE     IP           NODE               NOMINATED NODE   READINESS GATES
nginx-manual      1/1     Running   0          12s     10.0.2.198   ip-192-168-2-114   <none>           <none>
```

## Use a Binding to schedule a pod to a node

We will be targeting the pod tagged `name: nginx-automatic`.
The pod will be schedule to the second node `ip-192-168-3-104`

```bash
kubectl create -f pod_node_binding.yml
kubectl get pod --output wide`

NAME              READY   STATUS    RESTARTS   AGE   IP           NODE               NOMINATED NODE   READINESS GATES
nginx-automatic   1/1     Running   0          18m   10.0.1.82    ip-192-168-3-104   <none>           <none>
```

## Clean Up

```bash
kubectl delete -f yaml/
terraform destroy -auto-approve
```
