# Lab 3 — AWS DevOps Agent Investigation
Open Operator Web App, locate incident response, start an investigation with incident context from `evidence/incident-context.json`.

**Investigation details (paste)**:
> Investigate the Lambda error-rate spike associated with alarm AWS-DevOpsAgent-Lambda-Error-Test. Determine the most likely root cause using the available operational evidence. Identify the affected resource, incident timeline, supporting evidence, and recommended next steps. Do not assume the cause without evidence.

Starting point: `AWS-DevOpsAgent-Lambda-Error-Test` alarm, `AWS-DevOpsAgent-test-lambda` function. Set UTC incident time, verified account ID, and region. Inspect investigation summary, timeline, evidence/tool steps, RCA and mitigation plan. Clearly separate observed facts from inferred cause. Do not claim successful RCA merely because the example Lambda is known to fail.

**Gate L3**: Review root-cause statement against Lambda log exceptions, metric/alarm events, affected resource and timeline; save evidence and proposal. Manual review is mandatory. Do not apply mitigations automatically.
