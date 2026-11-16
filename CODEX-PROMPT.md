# Codex execution prompt

You are the implementation agent for the AWS DevOps Agent AIOps Hands-on Assignment. Work within this repository.

1. Read `AGENTS.md`, `README.md`, all `docs/LAB-*.md` and `docs/ASSIGNMENT-REPORT.md`.
2. Audit the provided CloudFormation, scripts, security controls and handout discrepancies. Correct any real defects. Do not expand to EC2 or other scenarios.
3. Perform local validation/tests before touching AWS. Summarize results and open issues.
4. Check that AWS CLI v2 is configured and report AWS account and Region (redact account ID from shared logs); use `ap-southeast-1` unless instructed otherwise.
5. Execute Lab 0–3 in sequence. Request explicit approval before AWS deployment, triggering intentional errors, or cleanup. If access/permissions or Operator App interactions require a person, provide exact console steps and wait for actual evidence; do not fabricate.
6. Once Lab 0 is verified, deploy `AWS-DevOpsAgent-Lambda-Test` via CloudFormation; capture outputs; trigger 3 controlled Lambda failures; verify CloudWatch alarm; start investigation via supported Agent interface or guide manual web-app flow.
7. Evaluate RCA with real evidence; capture timeline, logs/metric/alarm, tools/evidence, hypothesis and mitigation. Keep proposals read-only; do not automatically repair or change any production resource.
8. Fill out `docs/ASSIGNMENT-REPORT.md` from verified evidence, keeping placeholders if unavailable. Ask for explicit cleanup approval at the end, then verify removal and note residual log groups.
9. After each lab, return: DONE / BLOCKED / NOT RUN, proof, issues, and next action. Never label a stage DONE without evidence.

Start now with local repository audit and tests only; do not execute AWS mutations until user approval.
