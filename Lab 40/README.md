# Instruction

## Network Policies

A default DENY policy.

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm Nodes are Up

`kubectl get nodes`

### Create a deployment

`kubectl apply -f yaml/deployment`

### Create a network policy that allows egress traffic to only `8.8.8.8/32`

`kubectl apply -f yaml/network_policy.yml`

### Try ping inside the pod

```bash
kubectl -it <pod-name -- sh

/ # ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=109 time=1.620 ms

64 bytes from 8.8.8.8: seq=1 ttl=109 time=1.734 ms
64 bytes from 8.8.8.8: seq=2 ttl=109 time=5.313 ms
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.620/2.889/5.313 ms


/ # ping 8.8.8.9
PING 8.8.8.9 (8.8.8.9): 56 data bytes

^C
--- 8.8.8.9 ping statistics ---
248 packets transmitted, 0 packets received, 100% packet loss
```

### Clean UP

```bash
kubectl delete -f yaml/

terraform destroy -auto-approve
```
