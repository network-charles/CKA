# Instruction

## Mounting a secret to a deployment as a volume

This uses a volume from the node specified via a node affinity.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Optionally Encode the Password

`echo -n 'my_password' | base64`

Add the Base64 encoded value to the data portion of the secrets object.

### Deploy a Kubernetes secret object

The value of the secrets is injected into the pod via an environmental variable. Other methods exist, see [K8s Secrets](https://kubernetes.io/docs/concepts/configuration/secret/#using-a-secret).

```bash
kubectl create -f yaml/secrets.yml
OR
kubectl create secret generic db-secret --from-literal=DB_PASSWORD='my_password'
```

### Provision a deployment

`kubectl create -f yaml/deployment.yml`

### Access one of the pod to confirm the config is mounted in the file path

```bash
kubectl exec -it <pod_name> -- sh
cd /mnt
ls
```

And yes, a file exists.

`DB_PASSWORD`

### Clean UP

```bash
kubectl delete -f yaml
terraform destroy -auto-approve
```
