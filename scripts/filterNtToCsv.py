#!/usr/bin/env python
import sys
import RDF
import csv

parser = RDF.NTriplesParser()
csvwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

print "id\tcomment_en"
for line in sys.stdin:
    if line.startswith("#"):
        #skip comments
        continue

    for statement in parser.parse_string_as_stream(line, "http://localhost/"):
        if statement.subject.is_resource():
            subjectString = statement.subject.uri.__unicode__()
        if statement.predicate.is_resource():
            predicateString = statement.predicate.uri.__unicode__()
        if statement.object.is_literal():
            objectString = statement.object.literal[0].encode('utf-8')

        csvwriter.writerow([subjectString, objectString])
