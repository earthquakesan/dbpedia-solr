#!/usr/bin/env python

# a simple filter that prepends line numbers
import sys
import re

triplePattern = '<(.*)> <(.*)> "(.*)"'
tripleMatcher = re.compile(triplePattern)

# this reads in one line at a time from stdin
for line in sys.stdin:
    if line.startswith("#"):
        #skip comments
        continue

    matched = tripleMatcher.match(line)
    print "%s, \"%s\"" % (matched.groups()[0], matched.groups()[2],)
