#!/usr/bin/env python

# a simple filter that prepends line numbers
import sys
import re

triplePattern = '<(.*)> <(.*)> "(.*)"'
tripleMatcher = re.compile(triplePattern)

def replaceGL(string):
    return string.replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;")

# this reads in one line at a time from stdin
print "<add>"
for line in sys.stdin:
    if line.startswith("#"):
        #skip comments
        continue

    matched = tripleMatcher.match(line)
    print "<doc>"
    print '<field name="id">' + replaceGL(matched.groups()[0]) + '</field>'
    print '<field name="comment_en">' + replaceGL(matched.groups()[2]) + '</field>'
    print "</doc>"

print "</add>"
