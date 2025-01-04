#!/bin/bash

# Variables
PROJECT_NAME="elk-stack-project"
NAMESPACE="argocd"
CHART_PATH="kubernetes/argocd-apps"
VALUES_FILE="$CHART_PATH/values.yaml"

# Ensure ArgoCD namespace exists
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Add the Argo Helm repo
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Update Helm dependencies
cd $CHART_PATH
helm dependency update
helm dependency build

# Deploy the Helm chart
helm upgrade --install ${PROJECT_NAME}-apps . --namespace $NAMESPACE --values $VALUES_FILE
