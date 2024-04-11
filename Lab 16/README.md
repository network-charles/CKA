# Instruction

## Metric Server

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Apply the metric server config from the repo

`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`

### View the metric of nodes in the cluster

`kubectl top node <node_name>`

If an error displays saying `Metrics API not available` do the following.

Check APIs
`kubectl get apiservices.apiregistration.k8s.io`
Observe that there is an error here

```bash
NAME                                   SERVICE                      AVAILABLE                  AGE
v1beta1.metrics.k8s.io                 kube-system/metrics-server   False (MissingEndpoints)   2s
```

### Troubleshoot

Edit the running deployment manifest.
`kubectl edit deploy metrics-server --namespace kube-system`
Add `--kubelet-insecure-tls=true` to the container argument `args` list.

### Create a pod that uses the custom scheduler

`kubectl create -f yaml/pod.yml`

Check that the pod is running using `kubectl get pod`

### View the metric used by the pod

`kubectl top pod nginx`

### Clean UP

```bash
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl delete -f yaml

terraform destroy -auto-approve
```
