#!/bin/bash
set -e

CLUSTER_NAME="retail-dev-eksjalexsol"
AWS_REGION="ca-central-1"
NAMESPACE="kube-system"
RELEASE_NAME="aws-load-balancer-controller"
SERVICE_ACCOUNT_NAME="aws-load-balancer-controller"

aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME"

echo "Uninstalling AWS Load Balancer Controller Helm release..."
helm uninstall "$RELEASE_NAME" -n "$NAMESPACE" || true

echo "Deleting leftover controller deployment if any..."
kubectl delete deployment "$RELEASE_NAME" -n "$NAMESPACE" --ignore-not-found=true

echo "Deleting service account only if Terraform is NOT managing it..."
# If Terraform created the service account, keep this commented.
# kubectl delete serviceaccount "$SERVICE_ACCOUNT_NAME" -n "$NAMESPACE" --ignore-not-found=true

echo "Checking remaining controller resources..."
kubectl get pods -n "$NAMESPACE" -l app.kubernetes.io/name=aws-load-balancer-controller || true
kubectl get deployment "$RELEASE_NAME" -n "$NAMESPACE" || true
kubectl get serviceaccount "$SERVICE_ACCOUNT_NAME" -n "$NAMESPACE" || true

echo "Cleanup complete."