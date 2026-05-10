#!/bin/bash

####################################
# Install Docker
####################################

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
# tell my computer to trust the Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# A special door for Docker to come in. We call it a repository. It's like saying, "Hey Docker, you can come and play in our house!"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Open the Door for Docker: We're telling our computer where to find Docker. It's like giving directions to Docker's house.
sudo apt-get install containerd.io -y
sudo systemctl start containerd 

# create a default configuration file for containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"

# modify the config.toml file to locate the entry that sets "SystemdCgroup" to `false`, change its value to `true`. This is important because Kubernetes requires all its components, and the container runtime uses systemd for cgroups.
sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd.service


####################################
# Install K8s
####################################

sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
# tell my computer to trust the Kubernetes GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# We're telling our computer where to find Kubernetes. It's like giving it a superhero map.
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# We're telling our computer some rules to follow when playing with Kubernetes. It's like setting up the rules of a game.
## Set up ipv4 bridge on all nodes 
### Think of this as setting up special pathways for our superhero, Kubernetes. These pathways (bridges) help different parts of our computer talk to each other smoothly.
### overlay and br_netfilter: These are the names of the pathways we're creating. They're like building two special roads for our superhero to travel on.
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

### Now that we've drawn our pathways (overlay and br_netfilter), we're telling our computer to make them active. It's like flipping a switch to turn on the special roads we just built.
sudo modprobe overlay
sudo modprobe br_netfilter

## sysctl params required by setup, params persist across reboots
### net.bridge.bridge-nf-call-iptables = 1: We're telling our computer to be friendly with a tool called iptables. It's like saying, "Hey computer, make sure you're good friends with iptables because Kubernetes likes it that way."

### net.bridge.bridge-nf-call-ip6tables = 1: Similar to the previous line, but for a different tool called ip6tables. It's like telling our computer, "Be nice to ip6tables too, Kubernetes might need it."

### net.ipv4.ip_forward = 1: This line is like saying, "Hey computer, feel free to let information flow through you. It's okay to forward data." It's an important setting for networking, allowing our computer to efficiently handle data traffic.

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

## Apply sysctl params without reboot
### It's like telling our computer, "Hey, we made some changes in how you should handle things. You don't need to restart right now; just apply these changes immediately."
sudo sysctl --system

# Restart the kubelet service
sudo systemctl restart kubelet.service

# Install a Special Network Plugin (Ciium): We give our toys a cool tool to talk to each other, just like walkie-talkies.
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

# Install cilium cni 
cilium install --version 1.15.0