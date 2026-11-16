from pathlib import Path
import unittest
ROOT = Path(__file__).resolve().parents[1]

class ProjectTests(unittest.TestCase):
    def test_required_files(self):
        for file in ['AGENTS.md','CODEX-PROMPT.md','README.md','infra/AWS-DevOpsAgent-lambda-test.yaml','scripts/preflight.sh','scripts/deploy.sh','scripts/trigger.sh','scripts/validate.sh','scripts/cleanup.sh','docs/ASSIGNMENT-REPORT.md']:
            self.assertTrue((ROOT / file).is_file(), file)
    def test_template_contains_expected_resources(self):
        template = (ROOT / 'infra/AWS-DevOpsAgent-lambda-test.yaml').read_text()
        for text in ['AWS::IAM::Role','AWS::Lambda::Function','AWS::CloudWatch::Alarm','AWS-DevOpsAgent-test-lambda','AWS-DevOpsAgent-Lambda-Error-Test','raise Exception','TreatMissingData: notBreaching']:
            self.assertIn(text, template)
    def test_mutating_scripts_guarded(self):
        for name, flag in [('deploy.sh','CONFIRM_DEPLOY'),('trigger.sh','CONFIRM_TRIGGER'),('cleanup.sh','CONFIRM_CLEANUP')]:
            self.assertIn(flag, (ROOT / 'scripts' / name).read_text())

if __name__ == '__main__':
    unittest.main()
