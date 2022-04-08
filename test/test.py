#!/usr/bin/python3

import os, subprocess, sys, re, json

multiples = []
errors = []

for file in sorted(os.listdir("test")):
    if not file.endswith(".tz"):
        continue
    print("• Testing file {}... ".format(file), end="")
    content = subprocess.run(['cat', "test/" + file], check=True, capture_output=True)
    execution = subprocess.run(["nearley-test", "grammar.cjs", "-q"], input=content.stdout, capture_output=True)
    if execution.returncode != 0:
        errors.append(file)
        print("execution resulted in error. ✖ stderr below:")
        print(execution.stderr.decode("utf-8"))
    elif execution.stdout.decode("utf-8").count('\n') == 3 and re.split('\n', execution.stdout.decode("utf-8"))[1].endswith("more characters"):
        print("all good. ✔")
    elif execution.stdout.decode("utf-8").count('\n') > 3:
        multiples.append(file)
        print("execution resulted in multiple parsings. ✖ Results below:")
        print(execution.stdout.decode("utf-8"))
    elif json.loads(execution.stdout.decode('utf-8')[5:-4]):
        print("all good. ✔")
    else:
        errors.append(file)
        print("unknown error with this file. ✖")
    print()

if len(errors) > 0 or len(multiples) > 0:
    print("Errors:")
    print(sorted(errors))
    print()
    print("Multiple parsings:")
    print(sorted(multiples))
    sys.exit(len(errors))
else:
    sys.exit()
