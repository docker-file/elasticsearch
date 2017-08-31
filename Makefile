##
## container identity
IID ?= fogfish
APP ?= elasticsearch
VSN ?= 5.5.2

##
## image build flags
DFLAGS = \
   --rm=true \
   --build-arg ELASTIC_VSN=${VSN}

##
## image run flags
IFLAGS = \
	-p 9200:9200

##
## build container
docker: Dockerfile
	docker build ${DFLAGS} -t ${IID}/${APP}:${VSN} . 

##
## 
run:
	docker run -it ${IFLAGS} ${IID}/${APP}:${VSN}

##
##
debug:
	docker run -it ${IFLAGS} ${IID}/${APP}:${VSN} bash

