ARG ELASTIC_VSN=latest

FROM docker.elastic.co/elasticsearch/elasticsearch:$ELASTIC_VSN

RUN set -e \
   && rm -rf modules/x-pack-* \
   && rm -rf modules/aggs-matrix-stats \
   && rm -rf modules/ingest-common \
   && rm -rf modules/lang-expression \
   && rm -rf modules/lang-groovy \
   && rm -rf modules/lang-mustache \
   && rm -rf modules/percolator \
   && rm -rf modules/transport-netty3 \
   && elasticsearch-plugin install --batch discovery-ec2

ENV  ES_JAVA_OPTS "-Xms128m -Xmx128m"
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY config/elasticsearch_on_aws.yml /usr/share/elasticsearch/config/elasticsearch_on_aws.yml
COPY config/jvm.options /usr/share/elasticsearch/config/jvm.options
COPY elastic.sh /bin/elastic.sh

USER root
ENTRYPOINT "elastic.sh"
