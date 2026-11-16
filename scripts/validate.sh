#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_tools
check_identity
status="$(aws_cmd cloudformation describe-stacks --stack-name "$STACK" --query 'Stacks[0].StackStatus' --output text)"
[[ "$status" == 'CREATE_COMPLETE' || "$status" == 'UPDATE_COMPLETE' ]] || { echo "FAIL: stack status $status"; exit 1; }
function_state="$(aws_cmd lambda get-function --function-name "$FUNCTION" --query 'Configuration.State' --output text)"
[[ "$function_state" == 'Active' ]] || { echo "FAIL: Lambda state $function_state"; exit 1; }
alarm_exists="$(aws_cmd cloudwatch describe-alarms --alarm-names "$ALARM" --query 'length(MetricAlarms)' --output text)"
[[ "$alarm_exists" == '1' ]] || { echo 'FAIL: Expected alarm missing'; exit 1; }
alarm_state="$(aws_cmd cloudwatch describe-alarms --alarm-names "$ALARM" --query 'MetricAlarms[0].StateValue' --output text)"
echo "CloudFormation=$status | CloudWatch Alarm=$alarm_state"
if [[ "$alarm_state" != 'ALARM' ]]; then echo 'PENDING: Alarm is not ALARM. Allow metric propagation; check logs and invocations.'; exit 2; fi
echo 'PASS: CloudFormation stack deployed and CloudWatch alarm is ALARM.'
echo 'MANUAL GATE: Review DevOps Agent investigation and independently confirm evidence-backed RCA.'
