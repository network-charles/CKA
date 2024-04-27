# Instruction

## User Authorization using Roles and Role Bindings

## Initialize Kubernetes Cluster

`sudo kubeadm init`

1. Set up the client on the master node.
2. Use the join config and token to add the worker nodes to the cluster.

## Reinstall Cilium on the Master Node

The CNI plugin doesn't seem to install successfully until the cluster is up. So re-install Cilium.
`cilium install --version 1.15.0`

## View Cilium Pods

`kubectl get pods --all-namespaces`

### Confirm Nodes are Up

`kubectl get nodes`

### Generate a key and a certificate signing request (CSR) for the user

```bash
openssl genrsa -out user_1.key 2048

openssl req -new \
-key user_1.key \
-out user_1.csr \
-subj "/CN=user1/O=devops"
```

### Sign the CSR using a certificate authority (CA)

First, generate a token key from the user's CSR file:

`cat user_1.csr | base64 | tr -d '\n'`

Copy the token and paste it in the `spec.request` part of the kubernetes CSR manifest file.

Use the Kubernetes CSR manifest file to sign the CSR

`kubectl apply -f yaml/csr.yml`

Get the list of CSRs:

`kubectl get csr`

Approve the CSR:

`kubectl certificate approve user1`

Export the issued certificate from the CertificateSigningRequest:

`kubectl get csr user1 -o jsonpath='{.status.certificate}'| base64 -d > user_1.crt`

### Add the user to kubeconfig

First, you need to add new credentials:
`kubectl config set-credentials user1 --client-key=user_1.key --client-certificate=user_1.crt --embed-certs=true`

Then, you need to add the context:
`kubectl config set-context user1 --cluster=kubernetes --user=user1 --namespace=new`

View all the contexts

`kubectl config get-contexts`

To test it, change the context to user-1:

`kubectl config use-context user1`

### Attempt an action

Try to view all running pods

```bash
kubectl get pods

Error from server (Forbidden): pods is forbidden: User "user1" cannot list resource "pods" in API group "" in the namespace "default"
```

Notice that it fails because no role and a get pod policy are assigned to this user.

### Switch to the kubernetes admin context

`kubectl config use-context kubernetes-admin@kubernetes`

### Create a Role within a namespace (default)

Roles contain permissions that can be assigned.

`kubectl -f apply yaml/role.yml`

OR

`kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods`

### Create a Role Binding within a namespace (default)

Role binding grants the permission defined in the role.

`kubectl -f apply yaml/role_binding.yml`

OR

`kubectl create rolebinding read-pods --role=pod-reader --user=user1`

### Switch the context to user1 and try to get pods

```bash
kubectl config use-context user1

kubectl get pods

No resources found in new namespace.
```

It works.

### Try to get a deployment

```bash
kubectl get deployment

Error from server (Forbidden): deployments.apps is forbidden: User "user1" cannot list resource "deployments" in API group "apps" in the namespace "default"
```

### Clean UP

Switch back to the admin context and delete the resource:

```bash
kubectl config use-context kubernetes-admin@kubernetes

kubectl delete -f yaml/

terraform destroy -auto-approve
```
