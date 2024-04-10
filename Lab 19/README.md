# Instruction

## Config Maps

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Deploy a config-map and a pod

The config-map is injected into the pod via an enviromental variable.

```bash
kubectl create -f yaml/config_map.yml
OR
kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
```

### Deploy a pod

`kubectl create -f yaml/pod.yml`

### Check logs to see the output of the config

`kubectl logs my-pod | grep key`

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
