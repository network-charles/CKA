output "cluster_1_context" {
  value = "aws eks update-kubeconfig --name ${aws_eks_cluster.cluster_1.id} --region eu-west-1"
}

output "cluster_2_context" {
  value = "aws eks update-kubeconfig --name ${aws_eks_cluster.cluster_1.id} --region eu-west-2 "
}

# aws eks update-kubeconfig --name cluster_1 --region eu-west-1     
# NAME   READY   STATUS    RESTARTS   AGE   IP            NODE                                        
# c1     1/1     Running   0          12s   172.16.1.93   ip-172-16-1-102.eu-west-1.compute.internal   

# aws eks update-kubeconfig --name cluster_2
# NAME   READY   STATUS    RESTARTS   AGE   IP            NODE                                        
# c2     1/1     Running   0          9s    172.17.1.31   ip-172-17-1-97.eu-west-2.compute.internal   
