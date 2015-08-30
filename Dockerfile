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
FROM sys/java:latest

##
##
ENV   VSN   1.6.0

##
## config
WORKDIR /usr/local

RUN curl -k -L -O \
   https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${VSN}.tar.gz
RUN tar -xvzf elasticsearch-${VSN}.tar.gz
RUN ln -s elasticsearch-${VSN} elasticsearch
RUN rm elasticsearch-${VSN}.tar.gz


VOLUME ["/mnt/vol1"]


ADD elasticsearch.yml /usr/local/elasticsearch/config/elasticsearch.yml

##
##
EXPOSE 9200
EXPOSE 9300

##
##
CMD "/usr/local/elasticsearch/bin/elasticsearch"
