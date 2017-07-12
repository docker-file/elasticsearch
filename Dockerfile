##
##   Copyright (c) 2015, Dmitry Kolesnikov
##   All Rights Reserved.
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
FROM centos
MAINTAINER Dmitry Kolesnikov <dmkolesnikov@gmail.com>

##
##
ARG JAVA=
ARG ELASTICSEARCH=
ENV ROOT=/usr/local

##
## Install Java
RUN \
   yum update -y && \
   yum install -y java-${JAVA}-openjdk && \
   yum clean all   


##
## Install Elastic Search
RUN \
   cd / && \
   curl -k -L -O \
      https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH}.tar.gz

RUN \
   cd / && \
   tar -C ${ROOT} -xvzf elasticsearch-${ELASTICSEARCH}.tar.gz && \
   ln -s ${ROOT}/elasticsearch-${ELASTICSEARCH} ${ROOT}/elasticsearch && \
   rm elasticsearch-${ELASTICSEARCH}.tar.gz


VOLUME ["/mnt/vol1"]
ADD elasticsearch.yml ${ROOT}/elasticsearch/config/elasticsearch.yml

##
##
EXPOSE 9200
EXPOSE 9300

##
##
CMD ${ROOT}/elasticsearch/bin/elasticsearch

