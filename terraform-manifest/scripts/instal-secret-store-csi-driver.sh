#!/bin/bash
set -e

echo "=========================================="
echo "STEP-1: Add and update Helm repositories"
echo "=========================================="

helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts || true
helm repo update

echo
echo "=========================================="
echo "STEP-2: Install/Upgrade Secrets Store CSI Driver"
echo "=========================================="

helm upgrade --install csi-secrets-store \
  secrets-store-csi-driver/secrets-store-csi-driver \
  --namespace kube-system \
  --set syncSecret.enabled=true \
  --set enableSecretRotation=true \
  --set 'tokenRequests[0].audience=pods.eks.amazonaws.com' \
  --set 'tokenRequests[0].expirationSeconds=3600'

echo
echo "=========================================="
echo "STEP-3: Verify Helm releases"
echo "=========================================="

helm list --all-namespaces
helm list -n kube-system
helm status csi-secrets-store -n kube-system

echo
echo "=========================================="
echo "STEP-4: Verify CSI Driver pods"
echo "=========================================="

kubectl get pods -n kube-system
kubectl get pods -n kube-system -l app=secrets-store-csi-driver

echo
echo "=========================================="
echo "STEP-5: Verify tokenRequests for EKS Pod Identity"
echo "=========================================="

kubectl get csidriver secrets-store.csi.k8s.io -o yaml | grep -A5 tokenRequests

echo
echo "=========================================="
echo "Secrets Store CSI Driver installation complete"
echo "Expected token audience: pods.eks.amazonaws.com"
echo "=========================================="