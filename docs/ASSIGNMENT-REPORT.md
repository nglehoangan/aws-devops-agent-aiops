# AIOps Assignment Report — AWS DevOps Agent

## Environment
- Student:
- AWS region: Target ap-southeast-1; configured CLI default ap-southeast-2.
- Account (redacted): UNVERIFIED - STS InvalidClientTokenId.
- Agent Space:
- Lab date (UTC):

## Lab 0 — Foundation
- Status: BLOCKED
- Agent Space/operator app verification: Not verified; CLI authentication failed and no console evidence available.
- Screenshot/evidence: [Preflight and Lab 0 record](PREFLIGHT-LAB0.md)

## Lab 1 — Deployment
- Status: NOT RUN
- CloudFormation status:
- Lambda name:
- CloudWatch alarm name:
- Screenshot/evidence:

## Lab 2 — Incident
- Status: NOT RUN
- Trigger UTC timestamp:
- Lambda intentional failure evidence:
- Alarm state and timestamp:
- Screenshot/evidence:

## Lab 3 — Investigation
- Status: NOT RUN
- Investigation identifier:
- Investigation timeline:
- Observed supporting evidence:
- Root-cause conclusion (with evidence):
- Mitigation recommendations:
- Limitations / uncertainty:
- Screenshot/evidence:

## AIOps Analysis
- OBSERVE: alarm and metric evidence
- INVESTIGATE: plan and tool/evidence trail
- REASON: tested hypotheses vs observed root cause
- GOVERN: least privilege and explicit approvals
- PROVE: validation and reproducible evidence

## Cleanup
- Stack deleted (with date and evidence):
- CloudWatch Logs residual resources reviewed:
- Agent Space deletion/preservation decision:

## Final acceptance
- [ ] Lab 0 verified
- [ ] Lab 1 verified
- [ ] Lab 2 verified
- [ ] Lab 3 reviewed
- [ ] Cleanup confirmed
- [ ] No sensitive values in public deliverable

## Local audit ? 2026-11-15
- Status: DONE (local audit and available offline checks only).
- Evidence: [LOCAL-AUDIT.md](LOCAL-AUDIT.md); `py -3 -B -m unittest discover -s tests -v` passed 7 tests.
- AWS CLI installed: v2.31.25; credentials/account/Agent Space have not been verified.
- Intended Region: ap-southeast-1; no live Region/account confirmation performed.
- AWS API calls/mutations this session: none.
- Full CloudFormation validation: NOT RUN; no CloudFormation-aware local validator installed.
- Open prerequisites: usable python3 in the Bash environment; private account match and Lab 0 evidence.
- Lab 0?3 remain NOT RUN. No alarm, deployment, RCA or cleanup success is asserted.

## Preflight and Lab 0 follow-up - 2026-11-15
- Preflight: BLOCKED by InvalidClientTokenId; Lab 0: BLOCKED awaiting authentication and real console evidence.
- Evidence: [PREFLIGHT-LAB0.md](PREFLIGHT-LAB0.md). Earlier local audit describes the prior local-only phase.
- Existing seven passing offline tests retained without repetition. No AWS mutations performed.
- Next gate: verify Agent Space and Operator App, then request approval before Lab 1.
