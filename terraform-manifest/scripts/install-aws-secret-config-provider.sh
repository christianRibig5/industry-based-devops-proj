#!/bin/bash
set -e

echo "=============================================================================="
echo "STEP-1: Verify installation status, pods, and resources created by csi driver:"
echo "==============================================================================="
helm status csi-secrets-store -n kube-system

echo
echo "=========================================================================================="
echo "STEP-2: Install the AWS Secrets Manager CSI Driver Provider in the kube-system namespace."
echo "=========================================================================================="

echo
echo "✅ --set secrets-store-csi-driver.install=false, is allowed because csi-driver already installed:"
echo
helm install secrets-provider-aws \
  aws-secrets-manager/secrets-store-csi-driver-provider-aws \
  --namespace kube-system \
  --set secrets-store-csi-driver.install=false

echo
echo "✅ List installed Helm Releases:"
helm list -n kube-system

echo
echo "✅ Inspect the AWS provider Helm release::"
helm status secrets-provider-aws -n kube-system

echo
echo "✅ ASCP installation was suceesfull and works properly!"