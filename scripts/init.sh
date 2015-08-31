#!/bin/bash

SOLR_VERSION="5.3.0"

#fetch solr 5.3.0 only if not fetched already
if [ ! -d "solr" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  wget http://apache.osuosl.org/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz
  tar -xvf solr-$SOLR_VERSION.tgz
  rm solr-$SOLR_VERSION.tgz
  mv solr-$SOLR_VERSION solr
fi

if [ ! -d "dbpedia" ]; then
  mkdir data/
  wget http://downloads.dbpedia.org/2015-04/core-i18n/en/short-abstracts_en.nt.bz2
  mv short-abstracts_en.nt.bz2 data/
  bunzip2 data/short-abstracts_en.nt.bz2
fi
