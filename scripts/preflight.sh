#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_tools
aws --version
check_identity
aws_cmd cloudformation validate-template --template-body "file://$ROOT/infra/AWS-DevOpsAgent-lambda-test.yaml" --output json >/dev/null
echo 'PASS: CloudFormation template valid, AWS identity available.'
echo 'MANUAL GATE: Verify DevOps Agent Space exists in this account/region and Operator Web App opens.'
