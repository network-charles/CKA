# Instruction

## Upgrading/Downgrading a Cluster

We will be downgrading from v1.29.3 to v1.29.2

## Initialize Kubernetes Cluster

`sudo kubeadm init`

1. Set up the client on the master node.
2. Use the join config and token to add the worker nodes to the cluster.

## Reinstall Cilium on the Master Node

The CNI plugin don't seem to install successfuly until the cluster is up. So re-install Cilium.
`cilium install --version 1.15.0`

## View Cilium Pods

`kubectl get pods --all-namespaces`

### Confirm Nodes are Up

`kubectl get nodes`

### Upgrade the master node

On the control plane node:

Use any text editor you prefer to open the file that defines the Kubernetes apt repository.

`nano /etc/apt/sources.list.d/kubernetes.list`

Update the version in the URL to the next available minor release i.e v1.29.
If the version is available ignore this step.

After making changes, save the file and exit from your text editor. Proceed with the next instruction.

```bash
# Update the apt cache
apt update && \
# Show the list of available patches you can upgrade to.
apt-cache madison kubeadm
```

#### Upgrade kubeadm tool

Based on the version information displayed by apt-cache madison, it indicates that for Kubernetes version 1.29.2, the available package version is 1.29.2-1.1. Therefore, to install kubeadm for Kubernetes v1.29.2, use the following command:

```bash
sudo apt-mark unhold kubeadm && \
sudo apt-get upgrade && apt-get install kubeadm=1.29.2-1.1 --allow-downgrades && \
sudo apt-mark hold kubeadm
```

#### Verify the versions

`kubeadm version`

#### Upgrade the cluster

Run the following command to upgrade the Kubernetes cluster.

#### Choose a version to upgrade the cluster to

List the available target version the cluster can be upgraded to.

`kubeadm upgrade plan`

The version of the cluster is completely different from the version of kubeadm. There is no need to install an experimental version of the cluster.

`kubeadm upgrade apply v1.29.2`

Note that the above steps can take a few minutes to complete.

#### Confirm the version of the cluster

```bash
kubeadm upgrade plan | grep Cluster

[upgrade/versions] Cluster version: v1.29.2
```

#### Drain the node

`kubectl drain <node_name> --ignore-daemonsets`

#### Upgrade the version of kubelet and kubectl in the control plane node and restart Kubelet

```bash
sudo apt-mark unhold kubelet kubectl && \
apt-get install kubelet=1.29.2-* kubectl=1.29.2-* && \
systemctl daemon-reload && \
systemctl restart kubelet
```

Also, mark the node as schedulable.

`kubectl uncordon <node_name>`

#### Verify that the control plane node has been upgraded

```bash
kubectl get nodes

NAME           STATUS   ROLES           AGE     VERSION
controlplane   Ready    control-plane   3d18h   v1.29.1
node01         Ready    <none>          3d18h   v1.29.0
```

### Upgrade worker nodes

1. SSH into each worker node

2. Repeat this step - [upgrade kubeadm](#upgrade-kubeadm-tool)

#### Upgrade the local kubelet configuration

`sudo kubeadm upgrade node`

Exit the ssh session.

Repeat this step from the control plane terminal - [Drain the node](#drain-the-node).

#### Upgrade the version of kubelet and kubectl in the worker node and restart Kubelet

SSH into the worker node and execute the below.

```bash
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install --allow-downgrades kubelet=1.29.2-* kubectl=1.29.2-* && \
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

Exit the ssh session.
From the control plane node, mark the node as schedulable.

`kubectl uncordon <node_name>`

#### Verify that the worker node has been upgraded

```bash
kubectl get nodes

NAME           STATUS   ROLES           AGE     VERSION
ip-192-168-1-92    Ready    control-plane   22m   v1.29.2
ip-192-168-2-238   Ready    <none>          21m   v1.29.2
ip-192-168-3-150   Ready    <none>          21m   v1.29.2
```

### Clean UP

`terraform destroy -auto-approve`
