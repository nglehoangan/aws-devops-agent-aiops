#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGION="${AWS_REGION:-ap-southeast-1}"
PROFILE="${AWS_PROFILE:-}"
STACK="AWS-DevOpsAgent-Lambda-Test"
FUNCTION="AWS-DevOpsAgent-test-lambda"
ALARM="AWS-DevOpsAgent-Lambda-Error-Test"
aws_cmd() {
  if [[ -n "$PROFILE" ]]; then command aws --profile "$PROFILE" --region "$REGION" "$@";
  else command aws --region "$REGION" "$@"; fi
}
require_tools() {
  command -v aws >/dev/null || { echo 'ERROR: AWS CLI v2 is required' >&2; exit 1; }
  [[ "$(command aws --version 2>&1)" == aws-cli/2.* ]] || { echo 'ERROR: AWS CLI v2 is required' >&2; exit 1; }
  command -v python3 >/dev/null || { echo 'ERROR: Python 3 is required' >&2; exit 1; }
}
check_identity() {
  local acct
  acct="$(aws_cmd sts get-caller-identity --query Account --output text)"
  [[ -n "$acct" && "$acct" != "None" ]] || { echo 'AWS identity unavailable' >&2; exit 1; }
  echo "AWS account: [REDACTED] | Region: $REGION"
  [[ "${EXPECTED_AWS_ACCOUNT_ID:-}" =~ ^[0-9]{12}$ ]] || {
    echo 'ERROR: Set EXPECTED_AWS_ACCOUNT_ID to the verified Agent Space primary account before proceeding.' >&2; exit 1;
  }
  if [[ -n "${EXPECTED_AWS_ACCOUNT_ID:-}" && "$acct" != "$EXPECTED_AWS_ACCOUNT_ID" ]]; then
    echo "ERROR: Account mismatch with EXPECTED_AWS_ACCOUNT_ID" >&2; exit 1
  fi
}
