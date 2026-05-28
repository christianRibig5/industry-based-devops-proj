#!/bin/bash
set -e

echo "======================================"
echo "STEP-1: Verifying Helm Repositories"
echo "======================================"
helm repo list

echo
echo "========================================="
echo "STEP-2: install secrets store csi driver"
echo "========================================="
helm install csi-secrets-store \
  secrets-store-csi-driver/secrets-store-csi-driver \
  --namespace kube-system

echo
echo "✅ List all Helm releases across namespaces :"
helm list --all-namespaces

echo
echo "✅ List releases in only in kube-system namespaces :"
helm list -n kube-system

echo
echo "✅ Verify installation status, pods, and resources created by the release:"
helm status csi-secrets-store -n kube-system

echo
echo "✅ Verify pods:"
kubectl get pods -n kube-system
kubectl get pods -n kube-system -l app=secrets-store-csi-driver

echo
echo "✅ CSI driver installation was suceesfull and works properly!"