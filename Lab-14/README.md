# Instruction

## Static Pods

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### SSH into the node to deploy the Static pod

Use the terraform output `node1` or `node2`

Go to `/etc/kubernetes/manifests` folder. Copy the `yaml/staticpod.yml` file to it. No need to manually deploy it using `kubectl`. The `kubelet` service will create it.

Check that the pod is running using `kubectl get pod` or `crictl ps`

The node name is appended to the pod name as a suffix.

### Clean UP

```bash
kubectl delete -f /etc/kubernetes/manifests/pod.yml
terraform destroy -auto-approve
```
