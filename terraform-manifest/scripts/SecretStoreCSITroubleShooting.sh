#!/bin/bash

# Secrets Store CSI + AWS Provider + Pod Identity Troubleshooting Playbook
# Run line by line or run as a script.

NAMESPACE="catalog"
APP_NAME="catalog"
SERVICE_NAME="catalog-service"
SPC_NAME="catalog-db-secrets"
SERVICE_ACCOUNT="catalog-mysql-sa"
CLUSTER_NAME="retail-dev-eksjalexsol"
SECRET_NAME="dev/mysql/secret"
REGION="ca-central-1"
IAM_ROLE_NAME="retail-dev-eksjalexsol-catalog-mysql-sa-role"
POLICY_ARN="arn:aws:iam::247332613204:policy/retail-dev-eksjalexsol-catalog-mysql-sa-policy"

# "STEP 1: Check pods"
kubectl get pods -n $NAMESPACE -o wide

# "STEP 2: Describe pod"
kubectl describe pod -n $NAMESPACE

# "STEP 3: Check namespace events"
kubectl get events -n $NAMESPACE --sort-by=.lastTimestamp

# "STEP 4: Check SecretProviderClass"
kubectl get secretproviderclass -A
kubectl get secretproviderclass $SPC_NAME -n $NAMESPACE -o yaml

# "STEP 5: Check AWS secret"
aws secretsmanager describe-secret \
  --secret-id $SECRET_NAME \
  --region $REGION

# "STEP 6: Check CSI driver tokenRequests"
kubectl get csidriver secrets-store.csi.k8s.io -o yaml | grep -A8 tokenRequests

# "STEP 7: Check CSI and AWS provider pods"
kubectl get pods -n kube-system | grep -i "secrets-store\|provider\|aws"

# "STEP 8: Check Helm releases"
helm list -n kube-system
helm status csi-secrets-store -n kube-system
helm status secrets-provider-aws -n kube-system

# "STEP 9: Check Pod Identity association"
aws eks list-pod-identity-associations \
  --cluster-name $CLUSTER_NAME \
  --output json

# "STEP 10: Check service account"
kubectl get sa $SERVICE_ACCOUNT -n $NAMESPACE -o yaml

# "STEP 11: Check deployment service account"
kubectl get deploy $APP_NAME -n $NAMESPACE -o yaml | grep -A3 serviceAccount

# "STEP 12: Check IAM role policy"
aws iam list-attached-role-policies \
  --role-name $IAM_ROLE_NAME

aws iam get-policy-version \
  --policy-arn $POLICY_ARN \
  --version-id v1

# "STEP 13: Check CSI driver logs"
kubectl logs -n kube-system \
  -l app.kubernetes.io/name=secrets-store-csi-driver \
  --tail=100

# "STEP 14: Check AWS provider logs"
kubectl logs -n kube-system \
  -l app.kubernetes.io/name=secrets-store-csi-driver-provider-aws \
  --tail=100

# "STEP 15: Restart catalog pod"
kubectl delete pod -n $NAMESPACE --all

# "STEP 16: Watch pod"
kubectl get pods -n $NAMESPACE -w

# "STEP 17: Verify mounted secrets"
kubectl exec -it -n $NAMESPACE deploy/$APP_NAME -- ls /mnt/secrets-store

# "STEP 18: Check application logs"
kubectl logs -n $NAMESPACE -l app.kubernetes.io/name=$APP_NAME

# "STEP 19: Port forward app"
kubectl port-forward svc/$SERVICE_NAME -n $NAMESPACE 9090:8080