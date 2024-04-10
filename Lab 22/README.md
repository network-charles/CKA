# Instruction

## Using init-containers

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Create a multi-container pod

This comprises one container and two init-containers.
An init-container runs successfully before an actual container runs. If several init-container exists, they must run serially.

`kubectl create -f pod.yml`

`kubectl get pod myapp-pod`

Output:

```bash
NAME        READY     STATUS     RESTARTS   AGE
myapp-pod   0/1       Init:0/2   0          2m
```

The init containers will be waiting to discover Services named `mydb` and `myservice`.

### Create the services

`kubectl apply -f services.yaml`

Check the pod again to see if it is in a running state

`kubectl get pod myapp-pod`

Output:

```bash
NAME        READY     STATUS    RESTARTS   AGE
myapp-pod   1/1       Running   0          2m
```

### Clean UP

```bash
kubectl delete -f yaml

terraform destroy -auto-approve
```

See [init-containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/).
