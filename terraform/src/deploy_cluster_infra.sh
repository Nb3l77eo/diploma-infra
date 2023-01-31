#!/bin/bash
set -euo pipefail

# Prepare kubectl
echo "...Prepare kubectl..."
export PATH=/home/$(whoami)/yandex-cloud/bin:$PATH
export HELM_INSTALL_DIR=/home/$(whoami)/yandex-cloud/bin
sudo sh -c 'kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null'
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash


yc config set cloud-id $(cat /tmp/YC_cloud_id)
yc config set folder-id $(cat /tmp/YC_folder_id)
yc managed-kubernetes cluster get-credentials $(cat /tmp/k8s-id) --internal


# Install helm
echo "...Install helm..."
curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 /tmp/get_helm.sh
/tmp/get_helm.sh

# Kube-prometheus-stack
echo "...Kube-prometheus-stack..."
kubectl create namespace monitoring
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install stable --namespace monitoring -f ~/cluster_infra/terraform/conf/monitoring.yml prometheus-community/kube-prometheus-stack 

# Jenkins 
echo "...Jenkins..."
kubectl create namespace jenkins
helm repo add jenkins https://charts.jenkins.io
helm install jenkins --namespace jenkins -f ~/cluster_infra/terraform/conf/jenkins.yml jenkins/jenkins
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:default
