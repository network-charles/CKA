# Instruction

## Daemonsets

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm that Nodes are Up

`kubectl get nodes`

### Deploy the Daemonset

Daemon set can be deployed into both the master and worker nodes when an EKS cluster is not used.

`kubectl apply -f yaml/`

### Confirm that the daemonset is running

```bash
kubectl get daemonset fluentd-elasticsearch -namespace kube-system

NAME                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd-elasticsearch   2         2         2       2            2           <none>          43s
```

There are currently 2 available `fluentd-elasticsearch` pods running. One in each worker node
No one is running in the master node because AWS restricts access to the master node on EKS. But if you use EC2s and `kubeadm`
to create your cluster, the daemonset will be able to deploy into the master-node by adding tolerations to the pod.

### Add a new node and observe the daemonset increase by one

Modify `compute.tf` and increase the scaling_config block from 2 to 3.

```tf
scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }
```

View the daemonset again.

```bash
kubectl get daemonset fluentd-elasticsearch -namespace kube-system

NAME                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd-elasticsearch   3         3         3       3            3           <none>          4m3s
```

### Clean UP

```bash
kubectl delete -f yaml/
terraform destroy -auto-approve
```
