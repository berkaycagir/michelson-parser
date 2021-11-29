#!/usr/bin/python3

import os, subprocess, ast

for file in os.listdir():
    print("• Testing file {}... ".format(file), end="")
    content = subprocess.run(['cat', file], check=True, capture_output=True)
    execution = subprocess.run(["nearley-test", "../grammar_l.js", "-q"], input=content.stdout, capture_output=True)
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
