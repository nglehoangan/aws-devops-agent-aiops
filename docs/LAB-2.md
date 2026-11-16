# Lab 2 — Controlled incident trigger
1. Confirm only lab function/region/account are targeted.
2. `CONFIRM_TRIGGER=yes ./scripts/trigger.sh` triggers 3 intentional failures roughly 10 seconds apart.
3. Use `./scripts/validate.sh` to check ALARM; it may need a few minutes for metrics.
4. Record UTC incident timestamp in `evidence/incident-context.json`; capture the CloudWatch Alarm and Lambda logs.

**Gate L2**: 3 intentional exceptions + alarm ALARM + recorded UTC time. Do not confuse an HTTP/Lambda invocation StatusCode 200 with function execution success; inspect FunctionError.
