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
ARG JAVA=1.8.0
ARG ELASTICSEARCH=1.7.0
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
      https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH}.tar.gz

RUN \
   cd / && \
   tar -C ${ROOT} -xvzf elasticsearch-${ELASTICSEARCH}.tar.gz && \
   ln -s ${ROOT}/elasticsearch-${ELASTICSEARCH} ${ROOT}/elasticsearch && \
   rm elasticsearch-${ELASTICSEARCH}.tar.gz

##
## Install Elastic Search plug-ins
RUN ${ROOT}/elasticsearch/bin/plugin install cloud-aws
RUN ${ROOT}/elasticsearch/bin/plugin install discovery-multicast
RUN ${ROOT}/elasticsearch/bin/plugin install mobz/elasticsearch-head
RUN ${ROOT}/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ
RUN ${ROOT}/elasticsearch/bin/plugin install karmi/elasticsearch-paramedic


VOLUME ["/mnt/vol1"]
ADD elasticsearch.yml ${ROOT}/elasticsearch/config/elasticsearch.yml

##
##
EXPOSE 9200
EXPOSE 9300

##
##
CMD ${ROOT}/elasticsearch/bin/elasticsearch -Des.insecure.allow.root=true
