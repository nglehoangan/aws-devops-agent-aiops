# Lab 1 — CloudFormation Lambda test environment
1. `./scripts/preflight.sh`; verify target account against Agent Space primary cloud account.
2. `CONFIRM_DEPLOY=yes ./scripts/deploy.sh` after human approval.
3. Verify CloudFormation `AWS-DevOpsAgent-Lambda-Test` is CREATE_COMPLETE, function `AWS-DevOpsAgent-test-lambda`, alarm `AWS-DevOpsAgent-Lambda-Error-Test`.
4. Capture stack status, Lambda configuration, alarm configuration.

**Gate L1**: stack complete, function exists, alarm exists. The handout's EC2 stack name is a copy/paste error; do not create an EC2 instance.
