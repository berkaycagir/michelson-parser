#!/usr/bin/python3

import os, subprocess, ast, sys

exit_code = []

for file in os.listdir("test"):
    print("• Testing file {}... ".format(file), end="")
    content = subprocess.run(['cat', "test/" + file], check=True, capture_output=True)
    execution = subprocess.run(["nearley-test", "grammar_l.js", "-q"], input=content.stdout, capture_output=True)
    exit_code.append(execution.returncode)
    if execution.returncode != 0:
        print("execution resulted in error. ✖ stderr below:")
        print(execution.stderr.decode("utf-8"))
    elif len(ast.literal_eval(execution.stdout.decode("utf-8"))) == 0 or len(ast.literal_eval(execution.stdout.decode("utf-8"))) > 1:
        print("execution resulted in multiple parsings. ✖ Results below:")
        print(execution.stdout.decode("utf-8"))
    elif len(ast.literal_eval(execution.stdout.decode("utf-8"))) == 1:
        print("all good. ✔")
    else:
        print("unknown error with this file. ✖")
    print()

if all(v == 0 for v in exit_code):
    sys.exit()
else:
    sys.exit(1)
