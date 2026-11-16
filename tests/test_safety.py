import contextlib
import io
import os
from pathlib import Path
import shutil
import subprocess
import sys
import textwrap
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
BASH = shutil.which("bash")
if os.name == "nt":
    candidate = Path("C:/Program Files/Git/bin/bash.exe")
    BASH = str(candidate) if candidate.exists() else None

class SafetyTests(unittest.TestCase):
    @unittest.skipUnless(BASH, "Bash unavailable")
    def test_all_scripts_parse(self):
        for script in (ROOT / "scripts").glob("*.sh"):
            result = subprocess.run([BASH, "-n", script.as_posix()], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)

    @unittest.skipUnless(BASH, "Bash unavailable")
    def test_identity_guard_offline(self):
        # aws_cmd is replaced before check_identity: no AWS command is executed.
        for expected, ok in [("", False), ("bad", False), ("000000000001", False), ("000000000000", True)]:
            env = dict(os.environ, EXPECTED_AWS_ACCOUNT_ID=expected)
            result = subprocess.run(
                [BASH, "-c", 'source scripts/common.sh; aws_cmd() { echo 000000000000; }; check_identity'],
                cwd=ROOT, env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode == 0, ok, result.stderr)
            self.assertNotIn("000000000000", result.stdout)

    def test_inline_lambda_raises_lab_exception(self):
        template = (ROOT / "infra/AWS-DevOpsAgent-lambda-test.yaml").read_text()
        code = textwrap.dedent(template.split("ZipFile: |\n", 1)[1].split("      Description:", 1)[0])
        scope = {}
        exec(compile(code, "inline-lambda", "exec"), scope)
        with contextlib.redirect_stdout(io.StringIO()):
            for _ in range(3):
                with self.assertRaisesRegex(Exception, "^AWS DevOpsAgent Test Error:"):
                    scope["lambda_handler"]({"test": "offline"}, None)

    def test_invocation_validator_rejects_false_success(self):
        script = (ROOT / "scripts/trigger.sh").read_text()
        validator = script.split("<<'PY'\n", 1)[1].split("\nPY", 1)[0]
        response = '{"errorType":"Exception","errorMessage":"AWS DevOpsAgent Test Error: offline"}'
        for metadata, body, ok in [
            ('{"StatusCode":200,"FunctionError":"Unhandled"}', response, True),
            ('{"StatusCode":200}', response, False),
            ('{"StatusCode":202,"FunctionError":"Unhandled"}', response, False),
            ('{"StatusCode":200,"FunctionError":"Unhandled"}', '{"errorType":"RuntimeError"}', False),
        ]:
            def fake_open(name, **kwargs):
                return io.StringIO(metadata if name == "metadata" else body)
            with patch.object(sys, "argv", ["validator", "response", "metadata"]), patch("builtins.open", fake_open), contextlib.redirect_stdout(io.StringIO()):
                if ok:
                    exec(compile(validator, "invocation-validator", "exec"), {})
                else:
                    with self.assertRaises(SystemExit):
                        exec(compile(validator, "invocation-validator", "exec"), {})

if __name__ == "__main__":
    unittest.main()
