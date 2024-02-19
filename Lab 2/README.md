## Access the EKS cluster CLI
`aws eks update-kubeconfig --name eks`

# Confirm that Nodes are Up
`kubectl get nodes`

# Create a pod
`kubectl apply -f yaml/`

# Confirm that the pod is up and running
`kubectl get pod`