# 1. Check pod status
kubectl get pods -n catalog -o wide

# 2. Describe the stuck pod
kubectl describe pod <pod-name> -n catalog

# 3. Read the Events section carefully
# Most important part is always at the bottom under Events.

# 4. Check recent namespace events
kubectl get events -n catalog --sort-by=.lastTimestamp

# 5. Check service account used by pod
kubectl get pod <pod-name> -n catalog -o jsonpath='{.spec.serviceAccountName}'
echo

# 6. Check service account exists
kubectl get sa -n catalog

# 7. Check SecretProviderClass exists in same namespace
kubectl get secretproviderclass -A
kubectl get secretproviderclass catalog-db-secrets -n catalog -o yaml

# 8. Check CSI driver exists
kubectl get csidriver

# 9. Check CSI driver tokenRequests for EKS Pod Identity
kubectl get csidriver secrets-store.csi.k8s.io -o yaml | grep -A5 tokenRequests

# Expected:
# audience: pods.eks.amazonaws.com

# 10. Check CSI driver and AWS provider pods
kubectl get pods -n kube-system | grep -i "secrets-store\|provider\|aws"

# 11. Check Helm releases
helm list -n kube-system

# 12. Check Pod Identity association
aws eks list-pod-identity-associations \
  --cluster-name retail-dev-eksjalexsol \
  --output json

# 13. Check IAM policy attached to Pod Identity role
aws iam list-attached-role-policies \
  --role-name retail-dev-eksjalexsol-catalog-mysql-sa-role

# 14. Inspect IAM policy document
aws iam get-policy-version \
  --policy-arn arn:aws:iam::247332613204:policy/retail-dev-eksjalexsol-catalog-mysql-sa-policy \
  --version-id v1

# 15. Confirm secret exists
aws secretsmanager describe-secret \
  --secret-id dev/mysql/secret \
  --region ca-central-1

# 16. Restart pod after fixes
kubectl delete pod -n catalog --all

# 17. Watch pod become Running
kubectl get pods -n catalog -w