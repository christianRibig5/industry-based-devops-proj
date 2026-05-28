#!/bin/bash
set -e

echo
echo "============================================="
echo "STEP-1:Destroy Pod Identity Agent"
echo "============================================="
cd pod-identity-agent
terraform init -reconfigure
terraform plan -destroy
terraform destroy -auto-approve

echo
echo "🧹 Cleaning up local Terraform cache..."
rm -rf .terraform .terraform.lock.hcl


echo
echo "========================================"
echo "STEP-2: Destroy Associted Bucket"
echo "========================================"
cd ../devops-apps-s3-bucket
terraform init -reconfigure
terraform plan -destroy
terraform destroy -auto-approve

echo
echo "🧹 Cleaning up local Terraform cache..."
rm -rf .terraform .terraform.lock.hcl

echo
echo "✅ Pod ID Agent, and apps S3 bucket destroyed and cleaned up successfully!"