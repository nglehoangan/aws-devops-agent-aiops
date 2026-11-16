# AWS DevOps Agent — AIOps Hands-on Assignment

**Scope:** Four connected labs: Agent Space → Lambda stack → intentional Lambda error/alarm → evidence-backed AI incident investigation. Singapore (`ap-southeast-1`) is the default Region. This repository is a Codex-ready assignment starter; **no AWS resources are created just by downloading it**.

## Prerequisites
- Authorized training AWS account with AWS DevOps Agent, IAM/CloudFormation/Lambda/CloudWatch access.
- AWS CLI v2 with AWS SSO/IAM Identity Center or an approved profile; Python 3 locally. Bash shell (macOS/Linux/WSL/Git Bash).
- Verify account, permissions, cost/usage, and data residency policy. Singapore Agent Space may use global inference routing; check your organizational data handling requirements.
- Available AWS account and selected region must be the Agent Space's primary cloud account for this test.

## Quick start (human and Codex)
```bash
# Unzip project, cd into it
aws configure sso               # or use your preconfigured approved profile
export AWS_PROFILE=your-profile # optional
export AWS_REGION=ap-southeast-1
export EXPECTED_AWS_ACCOUNT_ID=123456789012 # required: verified Agent Space primary account; never commit this
./scripts/preflight.sh
```

Read `AGENTS.md`, then paste `CODEX-PROMPT.md` into Codex. Codex starts with local audit only.

### After Lab 0 is verified and each approval is given
```bash
CONFIRM_DEPLOY=yes ./scripts/deploy.sh
CONFIRM_TRIGGER=yes ./scripts/trigger.sh
./scripts/validate.sh
# Investigate using AWS DevOps Agent Operator App; complete docs/ASSIGNMENT-REPORT.md
CONFIRM_CLEANUP=DELETE-AWS-DevOpsAgent-Lambda-Test ./scripts/cleanup.sh
```

Commands above are examples, **not authorization to execute them without confirming the target account first**. Note the intentional Lambda exceptions and CloudWatch alarm are expected, not deployment defects. Alarm evaluation can be delayed and can return to OK after errors stop.

## Repository map
- `AGENTS.md` — Codex rules and phased gates
- `CODEX-PROMPT.md` — paste-ready Codex prompt
- `infra/AWS-DevOpsAgent-lambda-test.yaml` — IAM execution role, Lambda test function, CloudWatch alarm
- `scripts/preflight.sh` — identity + CloudFormation template validation
- `scripts/deploy.sh` — guarded stack deploy
- `scripts/trigger.sh` — exactly 3 controlled failures and timestamp
- `scripts/validate.sh` — stack/function/alarm checks
- `scripts/cleanup.sh` — guarded CloudFormation deletion
- `docs/LAB-0.md` ... `LAB-3.md` — guided acceptance gates
- `docs/ASSIGNMENT-REPORT.md` — assignment report skeleton
- `evidence/` — local evidence, gitignored

## Handout reconciliation
Lab 1 of the supplied handout includes instructions for an **EC2** YAML filename/stack despite describing a Lambda test. The corrected Lambda stack name is `AWS-DevOpsAgent-Lambda-Test`, consistent with AWS's official Lambda test procedure. The original example's globally fixed role/function/alarm names can cause clashes; this project avoids a fixed IAM role name but retains Lambda/alarm names to match the assignment, and must be deployed to an isolated lab account.

## Limits
Agent Space provisioning and the Operator Web App require AWS account authorization and sometimes manual UI operations. This starter **does not assert** a live Agent Space or successful investigation. Cleanup of the CloudFormation stack may not remove automatically generated CloudWatch log groups; review and remove them separately when authorized. Pricing and features may vary—monitor AWS billing.

## Official sources
- https://docs.aws.amazon.com/devopsagent/latest/userguide/getting-started-with-aws-devops-agent.html
- https://docs.aws.amazon.com/devopsagent/latest/userguide/getting-started-with-aws-devops-agent-creating-a-test-environment.html
- https://docs.aws.amazon.com/devopsagent/latest/userguide/about-aws-devops-agent-supported-regions.html

## Local validation
Run `py -3 -B -m unittest discover -s tests -v` on Windows, or `python3 -B -m unittest discover -s tests -v` elsewhere. Shell checks require Git Bash or Bash. These offline checks never call AWS. See [the local audit](docs/LOCAL-AUDIT.md) for results and unresolved prerequisites.
