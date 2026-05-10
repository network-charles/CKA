# Instruction

## User Authentication using Certificates and kubeconfig

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

`cat user_1.csr | base64 | tr -d "\n"`

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

#### First, you need to add new credentials:

`kubectl config set-credentials user1 --client-key=user_1.key --client-certificate=user_1.crt --embed-certs=true`

OR

Go to `./kube/` and edit the file `config`, add the below to add the new user.

```yaml
users:
- name: user1
  user:
    client-certificate: ~/user_1.crt
    client-key: ~/user_1.key
```

#### Then, you need to add the context:

`kubectl config set-context user1 --cluster=kubernetes --user=user-1`

OR

Go to `./kube/` and edit the file `config`, add the below to add the new user.

```yaml
contexts:
- context:
    cluster: kubernetes
    user: user1
  name: user-1
```

#### View all the contexts

`kubectl config get-contexts`

OR

View the yaml output

```bash
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://172.30.1.2:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
- context:
    cluster: kubernetes
    user: user1
  name: user1
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
- name: user-1
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
```

#### To test it, change the context to user1:

`kubectl config use-context user1`

OR

Go to `./kube/` and edit the file `config`, add the below to add the new user.

```yaml
current-context: user1
```

### Attempt an action

Try to view all running pods

`kubectl get pods`

Notice that it fails because no role and a get pod policy are assigned to this user.

### Clean UP

Switch back to the admin context and delete the resource:

```bash
kubectl config use-context kubernetes-admin@kubernetes

kubectl delete -f yaml/

terraform destroy -auto-approve
```
