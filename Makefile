default:
	bash ./scripts/init.sh

convert:
	rm data/short-abstracts_en.csv
	echo "id,comment_en" >> data/short-abstracts_en.csv
	head -10 data/short-abstracts_en.nt | scripts/filterNtToCsv.py >> data/short-abstracts_en.csv

run-solr: remove-dbpedia-core
	solr/bin/solr start
	solr/bin/solr create_core -c dbpedia-abstracts-solr -d solr/server/solr/configsets/basic_configs
	solr/bin/post -c dbpedia-abstracts-solr data/short-abstracts_en.csv

stop-solr:
	solr/bin/solr stop

remove-dbpedia-core:
	rm -rf solr/server/solr/dbpedia-abstracts-solr
