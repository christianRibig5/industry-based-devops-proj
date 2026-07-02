#!/bin/bash
set -e

CLUSTER_NAME="retail-dev-eksjalexsol"
AWS_REGION="ca-central-1"

NAMESPACE="kube-system"
SERVICE_ACCOUNT_NAME="aws-load-balancer-controller-sa"
CHART_VERSION="1.13.3"

echo "Updating kubeconfig..."
aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME"

echo "Getting VPC ID from EKS cluster..."
VPC_ID=$(aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query "cluster.resourcesVpcConfig.vpcId" \
  --output text)

if [ -z "$VPC_ID" ] || [ "$VPC_ID" = "None" ]; then
  echo "ERROR: Could not get VPC ID for cluster $CLUSTER_NAME"
  exit 1
fi

echo "VPC ID found: $VPC_ID"

echo "Checking service account..."
kubectl get serviceaccount "$SERVICE_ACCOUNT_NAME" -n "$NAMESPACE"

echo "Adding/updating Helm repo..."
helm repo add eks https://aws.github.io/eks-charts || true
helm repo update eks

echo "Installing/upgrading AWS Load Balancer Controller..."
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace "$NAMESPACE" \
  --version "$CHART_VERSION" \
  --set clusterName="$CLUSTER_NAME" \
  --set region="$AWS_REGION" \
  --set vpcId="$VPC_ID" \
  --set serviceAccount.create=false \
  --set serviceAccount.name="$SERVICE_ACCOUNT_NAME"

echo "Waiting for rollout..."
kubectl rollout status deployment/aws-load-balancer-controller -n "$NAMESPACE"

echo "Checking controller pods..."
kubectl get pods -n "$NAMESPACE" -l app.kubernetes.io/name=aws-load-balancer-controller

echo "Checking controller deployment..."
kubectl get deployment aws-load-balancer-controller -n "$NAMESPACE"

echo "AWS Load Balancer Controller installation complete."