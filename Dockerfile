ARG ELASTIC_VSN=latest

FROM docker.elastic.co/elasticsearch/elasticsearch:$ELASTIC_VSN

RUN set -e \
   && elasticsearch-plugin remove x-pack \
   && rm -rf modules/aggs-matrix-stats \
   && rm -rf modules/ingest-common \
   && rm -rf modules/lang-expression \
   && rm -rf modules/lang-groovy \
   && rm -rf modules/lang-mustache \
   && rm -rf modules/percolator \
   && rm -rf modules/transport-netty3

