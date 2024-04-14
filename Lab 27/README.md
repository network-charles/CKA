# Instruction

## Mounting a config map to a deployment as a volume

This uses a volume from the node specified via a node affinity.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Provision a config-map and a deployment

The config-map is injected into the pod via a volume.

```bash
kubectl create -f yaml/config_map.yml
```

### Provision a deployment

`kubectl create -f yaml/deployment.yml`

### Access one of the pod to confirm the config is mounted in the file path

```bash
kubectl exec -it <pod_name> -- sh
cd /mnt
ls
```

And yes, two files exist.

`key1  key2`

### Clean UP

```bash
kubectl delete -f yaml
terraform destroy -auto-approve
```
