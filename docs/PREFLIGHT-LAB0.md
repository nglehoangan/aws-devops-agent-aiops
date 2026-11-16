# Preflight and Lab 0 - 2026-11-15

## Preflight: BLOCKED
- Existing offline validation: 7 tests passed in the preceding local phase; not repeated.
- AWS CLI: aws-cli/2.31.25 Python/3.13.9 Windows/11 exe/AMD64.
- Available CLI profile: default. AWS_PROFILE is unset.
- Configured default Region: ap-southeast-2.
- Target for this assignment and the STS request: ap-southeast-1 (explicit override; persistent configuration unchanged).
- AWS_REGION and AWS_DEFAULT_REGION: unset.
- EXPECTED_AWS_ACCOUNT_ID: unset.
- Live command: aws sts get-caller-identity --region ap-southeast-1 --output json --no-cli-pager.
- Live result: InvalidClientTokenId; the security token included in the request is invalid.
- Account: UNVERIFIED; no account identifier recorded.
- Full preflight/template validation: BLOCKED by invalid credentials and unresolved Bash python3 prerequisite. No CloudFormation API request attempted.
- No deployments, incident invocations, cleanup, or other AWS mutations performed.

## Lab 0: BLOCKED
No evidence of an Agent Space or Operator Web App was available. The connected companion page snapshot was empty.

Resolution:
1. Refresh the approved temporary credentials or authenticate through IAM Identity Center. Do not send credentials in chat.
2. Select the authorized CLI profile and target ap-southeast-1 explicitly.
3. Verify the STS account privately against the Agent Space primary account and set EXPECTED_AWS_ACCOUNT_ID locally.
4. Verify the existing Agent Space status and Operator access in the AWS Console. If absent, creation requires explicit approval.
5. Provide redacted READY/status and authenticated web-app evidence with UTC capture time.
6. Stop at Gate L0 for user approval; do not begin Lab 1.

Console guide source:
https://docs.aws.amazon.com/devopsagent/latest/userguide/getting-started-with-aws-devops-agent-creating-an-agent-space.html

Lab 1: NOT RUN. Lab 2: NOT RUN. Lab 3: NOT RUN. Cleanup: NOT RUN.
