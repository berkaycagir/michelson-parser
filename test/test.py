#!/usr/bin/python3

import os, subprocess, ast, sys

errors = []

for file in os.listdir("test"):
    print("• Testing file {}... ".format(file), end="")
    content = subprocess.run(['cat', "test/" + file], check=True, capture_output=True)
    execution = subprocess.run(["nearley-test", "grammar_l.js", "-q"], input=content.stdout, capture_output=True)
    if execution.returncode != 0:
        errors.append(file)
        print("execution resulted in error. ✖ stderr below:")
        print(execution.stderr.decode("utf-8"))
    elif len(ast.literal_eval(execution.stdout.decode("utf-8"))) == 0 or len(ast.literal_eval(execution.stdout.decode("utf-8"))) > 1:
        errors.append(file)
        print("execution resulted in multiple parsings. ✖ Results below:")
        print(execution.stdout.decode("utf-8"))
    elif len(ast.literal_eval(execution.stdout.decode("utf-8"))) == 1:
        print("all good. ✔")
    else:
        errors.append(file)
        print("unknown error with this file. ✖")
    print()

if len(errors) > 0:
    print("Problematic files:")
    print(errors)
    sys.exit(1)
else:
    sys.exit()
