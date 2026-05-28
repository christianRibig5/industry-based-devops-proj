#!/bin/bash
set -e

echo "======================================"
echo "STEP-1: Uninstall Secrets Store CSI Driver"
echo "======================================"

helm uninstall csi-secrets-store -n kube-system 2>/dev/null || true

echo
echo "======================================"
echo "STEP-2: Delete leftover CSI resources if any"
echo "======================================"

kubectl delete daemonset,secretsstorecsidriver,secretsproviderclass,secretsproviderclasspodstatus \
  -n kube-system \
  -l app=secrets-store-csi-driver \
  --ignore-not-found=true 2>/dev/null || true

kubectl delete pods -n kube-system \
  -l app=secrets-store-csi-driver \
  --ignore-not-found=true 2>/dev/null || true

echo
echo "======================================"
echo "STEP-3: Verify cleanup"
echo "======================================"

helm list -n kube-system
kubectl get pods -n kube-system | grep -i "secrets-store\|csi" || echo "No Secrets Store CSI Driver pods found."

echo
echo "✅ Secrets Store CSI Driver cleanup completed."