##
## container identity
IID ?= fogfish
APP ?= elasticsearch
VSN ?= 6.4.1

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
	docker tag ${IID}/${APP}:${VSN} ${IID}/${APP}:latest 

publish:
	docker push ${IID}/${APP}:${VSN}
	docker push ${IID}/${APP}:latest

##
## 
run:
	docker run -it ${IFLAGS} ${IID}/${APP}:${VSN}

##
##
debug:
	docker run -it ${IFLAGS} ${IID}/${APP}:${VSN} bash

