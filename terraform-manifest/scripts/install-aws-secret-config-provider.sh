#!/bin/bash
set -e

echo "=========================================="
echo "STEP-1: Verify Secrets Store CSI Driver"
echo "=========================================="

helm status csi-secrets-store -n kube-system

echo
echo "=========================================="
echo "STEP-2: Add and update AWS provider Helm repo"
echo "=========================================="

helm repo add aws-secrets-manager https://aws.github.io/secrets-store-csi-driver-provider-aws || true
helm repo update

echo
echo "=========================================="
echo "STEP-3: Install/Upgrade AWS Secrets Manager Provider"
echo "=========================================="

helm upgrade --install secrets-provider-aws \
  aws-secrets-manager/secrets-store-csi-driver-provider-aws \
  --namespace kube-system \
  --set secrets-store-csi-driver.install=false

echo
echo "=========================================="
echo "STEP-4: Verify installation"
echo "=========================================="

helm list -n kube-system
helm status secrets-provider-aws -n kube-system
kubectl get pods -n kube-system | grep -i "secrets-provider\|provider-aws\|secrets-store"

echo
echo "✅ AWS Secrets Manager Provider installation completed."