default:
	bash ./scripts/init.sh

convert:
	rm data/short-abstracts_en.csv
	echo "id,comment_en" >> data/short-abstracts_en.csv
	cat data/short-abstracts_en.nt | scripts/filterNtToCsv-regex.py >> data/short-abstracts_en.csv

benchmark-convert:
	echo "Benchmarking python filter: 10000 lines/triples (Slow)"
	echo "id,comment_en" >> data/short-abstracts_en.csv
	head -10000 data/short-abstracts_en.nt | time scripts/filterNtToCsv.py 1> data/short-abstracts_en-10000.csv 2> pythonFilter.bench
	rm data/short-abstracts_en-10000.csv

	echo "Benchmarking string filter: 10000 lines/triples (Fast)"
	echo "id,comment_en" >> data/short-abstracts_en-10000.csv
	head -10000 data/short-abstracts_en.nt | time scripts/filterNtToCsv-regex.py 1> data/short-abstracts_en-10000.csv 2> pythonFilter-regex.bench
	rm data/short-abstracts_en-10000.csv

run-solr: remove-dbpedia-core
	solr/bin/solr start
	solr/bin/solr create_core -c dbpedia-abstracts-solr -d solr/server/solr/configsets/basic_configs
	solr/bin/post -c dbpedia-abstracts-solr data/short-abstracts_en.csv

stop-solr:
	solr/bin/solr stop

remove-dbpedia-core:
	rm -rf solr/server/solr/dbpedia-abstracts-solr
