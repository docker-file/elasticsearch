USR ?= app
APP ?= elasticsearch
VSN ?= latest

FLAGS = \
	-p 9200:9200


all:
	docker build -t ${USR}/${APP}:${VSN} .

run:
	docker run -it ${FLAGS} ${USR}/${APP}:${VSN}


##
## docker run -d -p 9200:9200 -p 9300:9300 -v <data-dir>:/data dockerfile/elasticsearch /elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml