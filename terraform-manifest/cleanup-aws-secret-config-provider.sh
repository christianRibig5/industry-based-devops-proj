#!/bin/bash
set -e

echo "======================================"
echo "STEP-1: Uninstall AWS Secrets Provider (ASCP)"
echo "======================================"

helm uninstall secrets-provider-aws -n kube-system 2>/dev/null || true

echo
echo "======================================"
echo "STEP-2: Delete leftover ASCP resources if any"
echo "======================================"

kubectl delete deployment,daemonset,pods \
  -n kube-system \
  -l app.kubernetes.io/name=secrets-store-csi-driver-provider-aws \
  --ignore-not-found=true 2>/dev/null || true

echo
echo "======================================"
echo "STEP-3: Verify cleanup"
echo "======================================"

helm list -n kube-system

kubectl get pods -n kube-system | grep -i "provider\|aws" || \
echo "No ASCP provider pods found."

echo
echo "✅ AWS Secrets Config Provider (ASCP) cleanup completed."