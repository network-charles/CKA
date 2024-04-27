# Instruction

## Private Image Repository

### Access the EKS cluster CLI

`aws eks update-kubeconfig --name eks`

### Confirm Nodes are Up

`kubectl get nodes`

### Create a simple docker file

```dockerfile
# Use the official Python base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Create and write the Python script directly in the Dockerfile
RUN echo 'print("Hello Docker Hub Repo")' > hello.py

# Run the Python script when the container launches
CMD ["python", "hello.py"]
```

### Build, tag, and push the image to your private repo

```bash
# build image
docker image build -t k8s_lab .

# confirm build
docker images

REPOSITORY   TAG        IMAGE ID       CREATED         SIZE
k8s_lab      latest     c318e6175446   4 seconds ago   126MB
python       3.9-slim   a8260aeae86e   5 weeks ago     126MB

# log into your dockerhub account
docker login

# tag the image with your username/repo_name:version
docker tag k8s_lab:latest charlesniklaus/k8s_lab:latest

# push the image to your repo
docker push charlesniklaus/k8s_lab:latest
```

### Create a Secret based on existing credentials

```bash
kubectl create secret generic my-registry \
--from-file=.dockerconfigjson=/root/.docker/config.json \
--type=kubernetes.io/dockerconfigjson
```

### Create a Secret by providing credentials on the command line

```bash
kubectl create secret docker-registry my-registry \
--docker-server=https://index.docker.io/v1/ \
--docker-username=<username> \
--docker-password=<password> \
--docker-email=<email>
```

### Create deployment and check logs

`kubectl apply -f yaml/deployment.yml`

The "imagePullSecrets" field points to Secrets in the same namespace. It helps provide the kubelet with credentials from a Secret containing a Docker registry password. This allows the kubelet to fetch private images for your Pod.

Check logs to see the python output

```bash
kubectl logs pods/<pod-name>

Hello Docker Hub Repo
```

### Clean UP

```bash
kubectl delete -f yaml/

terraform destroy -auto-approve
```
