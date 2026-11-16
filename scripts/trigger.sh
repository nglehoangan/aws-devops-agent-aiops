#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_tools
check_identity
if [[ "${CONFIRM_TRIGGER:-}" != 'yes' ]]; then
  echo 'Trigger blocked. Set CONFIRM_TRIGGER=yes after confirming lab-only function.' >&2; exit 2
fi
mkdir -p "$ROOT/evidence"
incident_time="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
account_id="$(aws_cmd sts get-caller-identity --query Account --output text)"
printf '{"incident_time_utc":"%s","account_id":"%s","region":"%s","function_name":"%s","alarm_name":"%s","purpose":"intentional lab errors"}\n' "$incident_time" "$account_id" "$REGION" "$FUNCTION" "$ALARM" > "$ROOT/evidence/incident-context.json"
for n in 1 2 3; do
  payload="$(python3 -c 'import json,datetime;print(json.dumps({"test":"AWS DevOps Agent validation","timestamp":datetime.datetime.now(datetime.timezone.utc).isoformat()}))')"
  tmp="$(mktemp)"
  echo "Invocation $n / 3: intentional failure expected"
  aws_cmd lambda invoke --function-name "$FUNCTION" --cli-binary-format raw-in-base64-out --payload "$payload" --query '{StatusCode:StatusCode,FunctionError:FunctionError}' --output json "$tmp" > "$ROOT/evidence/invocation-$n-metadata.json"
  cp "$tmp" "$ROOT/evidence/invocation-$n-response.json"
  python3 - "$tmp" "$ROOT/evidence/invocation-$n-metadata.json" <<'PY'
import json,sys
with open(sys.argv[2],encoding='utf-8') as f: metadata=json.load(f)
if metadata.get('StatusCode') != 200 or metadata.get('FunctionError') != 'Unhandled':
    raise SystemExit('FAIL: Lambda invocation metadata did not confirm an unhandled exception')
with open(sys.argv[1],encoding='utf-8') as f: data=json.load(f)
if data.get('errorType') != 'Exception' or not str(data.get('errorMessage','')).startswith('AWS DevOpsAgent Test Error:'):
    raise SystemExit('FAIL: Unexpected Lambda response; stop and investigate')
print('PASS: confirmed intentional test exception')
PY
  rm -f "$tmp"
  if [[ "$n" -lt 3 ]]; then sleep 10; fi
done
echo 'PASS: 3 intentional exceptions invoked. Wait for CloudWatch alarm evaluation.'
echo 'Incident context written to evidence/incident-context.json; redact account IDs before submitting publicly.'
