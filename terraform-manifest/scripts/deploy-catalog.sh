#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Project root is: $ROOT_DIR"

# echo "========================================="
# echo "Deploying AWS Secret Manager..."
# echo "========================================="
# terraform -chdir="$ROOT_DIR/terraform-manifest/aws-secret-manager" apply -auto-approve

# echo "========================================="
# echo "Deploying RDS..."
# echo "========================================="
# terraform -chdir="$ROOT_DIR/terraform-manifest/eks-rds" apply -auto-approve

echo "========================================="
echo "Deploying Catalog Workload..."
echo "========================================="
kubectl apply -n catalog -f "$ROOT_DIR/kubernetes-manifest/catalog-workload-docs/catalog-k8-rds-usage/"

echo "========================================="
echo "Deployment Complete"
echo "========================================="

echo
echo "Verifying deployment..."
kubectl get all -n catalog