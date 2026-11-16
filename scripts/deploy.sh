#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_tools
check_identity
if [[ "${CONFIRM_DEPLOY:-}" != 'yes' ]]; then
  echo 'Deployment blocked. Set CONFIRM_DEPLOY=yes after verifying account/region.' >&2; exit 2
fi
aws_cmd cloudformation deploy \
  --template-file "$ROOT/infra/AWS-DevOpsAgent-lambda-test.yaml" \
  --stack-name "$STACK" --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset
mkdir -p "$ROOT/evidence"
aws_cmd cloudformation describe-stacks --stack-name "$STACK" --query 'Stacks[0].{Status:StackStatus,Outputs:Outputs}' --output json > "$ROOT/evidence/stack-outputs.json"
echo 'Stack outputs saved privately to evidence/stack-outputs.json; redact before sharing.'
echo 'PASS: Check stack CREATE_COMPLETE or UPDATE_COMPLETE before triggering.'
