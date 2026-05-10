# Instruction

## Secrets

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

### Deploy a pod

`kubectl create -f yaml/pod.yml`

### Check logs to see the output of the config

For the pod:
`kubectl logs my-pod`

The output:
`The database password is my_password`

### Alternatively, output the value of the encoded base64 text in JSON

`kubectl get secret db-secret -o json`

### Decode the base64 text

`echo 'bXlfcGFzc3dvcmQ=' | base64 --decode`

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```
