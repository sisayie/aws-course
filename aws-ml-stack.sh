#!/usr/bin/env bash

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

AWS_REGION="${AWS_REGION:-us-east-1}"
STACK_NAME="${STACK_NAME:-ml-stack}"

# GitHub raw URL to the CloudFormation template.
TEMPLATE_URL="${TEMPLATE_URL:-https://raw.githubusercontent.com/ORG/REPO/main/cloudformation/template.yaml}"

# Optional CloudFormation parameters.
PARAMETERS=(
  "ParameterKey=Environment,ParameterValue=dev"
  "ParameterKey=ProjectName,ParameterValue=my-project"
)

# -----------------------------------------------------------------------------
# Prerequisites
# -----------------------------------------------------------------------------

command -v aws >/dev/null 2>&1 || {
  echo "ERROR: AWS CLI is not installed."
  exit 1
}

command -v curl >/dev/null 2>&1 || {
  echo "ERROR: curl is not installed."
  exit 1
}

# Verify AWS credentials.
aws sts get-caller-identity --region "$AWS_REGION" >/dev/null

echo "AWS account:"
aws sts get-caller-identity \
  --query 'Account' \
  --output text

echo "Region: $AWS_REGION"
echo "Stack:  $STACK_NAME"
echo

# -----------------------------------------------------------------------------
# Download template
# -----------------------------------------------------------------------------

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

TEMPLATE_FILE="$TEMP_DIR/template.yaml"

echo "Downloading CloudFormation template..."
curl --fail --location --silent --show-error \
  "$TEMPLATE_URL" \
  --output "$TEMPLATE_FILE"

# -----------------------------------------------------------------------------
# Validate template
# -----------------------------------------------------------------------------

echo "Validating CloudFormation template..."

aws cloudformation validate-template \
  --template-body "file://$TEMPLATE_FILE" \
  --region "$AWS_REGION" \
  >/dev/null

echo "Template validation successful."
echo

# -----------------------------------------------------------------------------
# Deploy stack
# -----------------------------------------------------------------------------

echo "Deploying CloudFormation stack..."

aws cloudformation deploy \
  --template-file "$TEMPLATE_FILE" \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION" \
  --parameter-overrides "${PARAMETERS[@]}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-fail-on-empty-changeset

echo
echo "CloudFormation deployment completed."

# -----------------------------------------------------------------------------
# Show stack outputs
# -----------------------------------------------------------------------------

echo
echo "Stack outputs:"

aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION" \
  --query 'Stacks[0].Outputs' \
  --output table
