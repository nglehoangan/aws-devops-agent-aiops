# Local audit ? 2026-11-15

Status: DONE for the local audit and available offline checks. AWS readiness is unverified.

## Verified local evidence
- Read AGENTS.md, README.md, all four lab runbooks and ASSIGNMENT-REPORT.md.
- AWS CLI executable reports aws-cli/2.31.25; installation only, not authentication.
- Python 3.13 is available through the Windows py launcher. The python/python3 Windows shortcuts fail.
- Git Bash is available at C:/Program Files/Git/bin/bash.exe. The default Windows bash launcher has no WSL distribution.
- Command: py -3 -B -m unittest discover -s tests -v
- Result: 7 tests passed, including syntax checks for every shell script, offline account mismatch/missing-account cases, local Lambda handler exceptions, and rejection of invalid invocation responses.
- The local Lambda test executes Python in-process. It is not evidence of AWS invocations.
- git status reports that this directory is not a Git repository; no commit or Git diff verification is available.

## Corrections
- Require a 12-digit EXPECTED_AWS_ACCOUNT_ID and compare against STS identity.
- Redact account ID from normal identity output and enforce AWS CLI v2.
- Replace the broad managed execution policy with logging permissions for the named test function.
- Require Active Lambda state and presence of the expected alarm in validation.
- Persist stack outputs and each invocation's metadata/response in the private evidence directory.
- Check invocation StatusCode and FunctionError as well as the expected exception body.
- Existing EC2 typo correction is consistent across README and Lab 1; no EC2 resources added.

## Limits and open issues
- Original confidential handout was not present. Reconciliation is limited to the repository's description.
- No CloudFormation-aware parser/linter was installed; full CloudFormation validation remains NOT RUN. Shell syntax and inline Python checks do not validate AWS resource semantics or IAM authorization.
- No AWS API calls were made. Account identity, credentials, selected profile, Agent Space, stack, alarm and investigation are unverified.
- Before scripts run, provide a working python3 on Git Bash PATH, or use an approved Bash environment with Python 3 and AWS CLI v2.
- Fixed Lambda/alarm names can collide; verify the isolated training account before deployment.
- Three deliberate exceptions remain the only permitted incident scenario. No automatic remediation was added.

## Lab gates
| Stage | State | Evidence / next action |
| --- | --- | --- |
| Lab 0 | NOT RUN | After the local-only phase, verify AWS identity privately, match the Agent Space primary account, and obtain READY/operator-app evidence. |
| Lab 1 | NOT RUN | Requires Lab 0 evidence, AWS template validation, and explicit deployment approval. |
| Lab 2 | NOT RUN | Requires verified stack and separate approval for three intentional failures. |
| Lab 3 | NOT RUN | Requires real alarm, logs and investigation evidence; review recommendations without applying them. |
| Cleanup | NOT RUN | No resources created in this session. Request deletion approval only after the lab work. |
