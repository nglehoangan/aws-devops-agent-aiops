#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_tools
check_identity
if [[ "${CONFIRM_CLEANUP:-}" != "DELETE-$STACK" ]]; then
  echo "Cleanup blocked. Set CONFIRM_CLEANUP=DELETE-$STACK to delete this lab stack." >&2; exit 2
fi
aws_cmd cloudformation delete-stack --stack-name "$STACK"
aws_cmd cloudformation wait stack-delete-complete --stack-name "$STACK"
echo 'PASS: CloudFormation stack deleted.'
echo 'MANUAL: Check for residual CloudWatch log group and delete it if created, and review Agent Space cleanup.'
