#!/bin/bash
set -e

echo "==============================="
echo "STEP-1: Create S3 for devops app using Terraform"
echo "==============================="
cd devops-apps-s3-bucket
terraform init 
terraform validate
terraform plan
terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-2: Create Pod Identity Agent for existin Cluster using Terraform"
echo "==============================="
cd ../pod-identity-agent
terraform init 
terraform validate
terraform plan
terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-3: Create Pod Identity Association for Pod Id Agent using Terraform"
echo "==============================="
cd ../pod-identity-association
terraform init 
terraform validate
terraform plan
terraform apply -auto-approve

echo
echo "✅ Pod Identity creation completed successfully!"