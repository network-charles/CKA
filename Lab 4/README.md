# Instruction

## Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

## Confirm that Nodes are Up

`kubectl get nodes`

## Create a deployemt

`kubectl apply -f yaml/`
OR
`kubectl create deployment nginx-deployment --image=nginx:1.25.3`
This is revision 1.

## Confirm that the deployent are up

`kubectl get deployment`

## Confirm the image version of one of the pods

`kubectl describe pod <pod_name> | grep Image`

## Scale the deployment (optional)

`kubectl scale deployment nginx-deployment --replicas=4`

## Upgrade the nginx image version to v1.25.4

`kubectl set image deployment nginx-deployment nginx=nginx:1.25.4`
OR
`kubectl edit deployment nginx-deployment`

This is revision 2 now.
Also, a new replicaset is created for this reviion.

## Check pod to see rolling update strategy in action

`kubectl get pod`

## Check rollout status

`kubectl rollout status deployment nginx-deployment`

## Check history of rolling update

`kubectl rollout history deployment nginx-deployment`

## Confirm the image version of one of the new pods

`kubectl describe pod <pod_name> | grep Image`

## Check Replicaset

`kubectl get replicaset`
Notice that another replicaset has been created for the new version of the image.
The replicaset

## Upgrade the image to a wrong one

`kubectl set image deployment nginx-deployment nginx=nginx:1.25.9`
This is revision 3 now.

## Confirm that the pod has been created wrongly | check pod `status`

`kubectl get pod`

## Rollback to the previous version v1.25.4 of the image

`kubectl rollout undo deployment nginx-deployment --to-revision=2`

## Clean Up

`kubectl delete deployment nginx-deployment` OR `kubectl delete -f deployment.yml`
`terraform destroy -auto-approve`
