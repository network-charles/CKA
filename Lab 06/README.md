# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create new replicasets

`kubectl create -f yaml/replicaset.yml`

## Confirm the all pods in the replicaset are running

`kubectl get pod`

## Create a Cluster IP Service

`kubectl create -f yaml/service.yml`

OR

`kubectl create service clusterip NAME [--tcp=<port>:<targetPort>] [--dry-run=server|client|none]`

OR

`kubectl expose replicaset nginx-replicaset-1  --type=ClusterIP --name=nginx-service-cluster-ip  --target-port=80 --port=80`

### SSH into the node and curl the service IP address

```bash
curl <service-IP>

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

## Clean Up

`terraform destroy -auto-approve`
