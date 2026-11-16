# Codex project instructions
You are implementing an AWS DevOps Agent AIOps assignment based on the original handout and the four lab runbooks in `docs/`.

## Mission
Deliver reproducible Lab 0–3 outcomes and a truthful evidence-backed report, not a simulated success. Read `README.md`, each lab runbook, and `docs/ASSIGNMENT-REPORT.md` before acting.

## Constraints
- Target AWS `ap-southeast-1` by default. Confirm account identity and match the primary cloud account of the Agent Space.
- No production systems, no arbitrary workloads, no EC2 stack. Lambda failures are intentional and allowed only for `AWS-DevOpsAgent-test-lambda`.
- Never ask the user to paste AWS access keys. Use preconfigured AWS CLI profiles, IAM Identity Center or temporary credentials.
- Do not deploy or trigger without explicit user approval; execute cleanup only after explicit confirmation.
- Never claim that Agent Space, alarm, RCA, or other external state is verified without live evidence.
- Do not include AWS secrets, sensitive IDs or confidential handout text in commits or reports.
- Use least privilege where feasible; don't grant broad policies just to bypass access errors. No auto remediation.
- Keep the original lab's purpose and names; fix documented typo referencing EC2 in Lab 1.
- Use safe incremental changes and validate before proceeding to the next lab.

## Execution phases
1. Local test: inspect CloudFormation template and shell scripts, run static tests, report findings.
2. Lab 0 gate: verify existing Agent Space or guide interactive creation and operator app verification.
3. Lab 1 gate: preflight, ask for deploy approval, deploy stack, verify outputs.
4. Lab 2 gate: ask for trigger approval, invoke 3 times, verify ALARM, record UTC evidence.
5. Lab 3 gate: guide/run supported AWS investigation path, capture factual evidence, review RCA and mitigation without applying it.
6. Report and clean up: collect screenshots/evidence paths, request deletion approval, clean stack and residual logs if separately approved.

## Output per phase
State: COMPLETED / BLOCKED / NOT RUN; proof; actual AWS identifiers redacted; exact next step; blocker resolution; never invent evidence.
