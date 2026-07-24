#!/bin/bash

set -e

AWS_REGION="${AWS_REGION:-ca-central-1}"
AWS_PROFILE="${AWS_PROFILE:-dev-admin}"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity \
  --profile "${AWS_PROFILE}" \
  --query Account \
  --output text)

aws ecr get-login-password \
  --region "${AWS_REGION}" \
  --profile "${AWS_PROFILE}" \
| helm registry login \
  --username AWS \
  --password-stdin \
  "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Logged into OCI registry successfully."