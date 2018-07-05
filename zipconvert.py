#!/usr/local/bin/python3

import sys, io, re, ast

with open(sys.argv[1], "r") as file:
    content = file.read()

content = ast.literal_eval(content)

with open(sys.argv[1], "wb") as file:
    file.write(content)
