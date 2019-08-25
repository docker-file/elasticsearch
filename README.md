# Elastic Search

X-Pack free configuration of Elastic Search for Cloud deployments


## Key features

* Off-the-shelf container configuration for AWS ECS/EKS and local development
* X-Pack free, see https://github.com/elastic/elasticsearch-docker/issues/36
* AWS Security Group based discovery


## Getting started

The latest version of the container is available at docker hub.

```bash
docker run -it \
  -p 9200:9200 \
  fogfish/elasticsearch
```

The default nano deployment
```bash
docker run -it \
  -p 9200:9200 \
  --memory 348m \
  --memory-swappiness 0 \
  fogfish/elasticsearch
```

The default version of container is tuned for nano deployments, using only 128MB of RAM, use `ES_JAVA_OPTS` environment variable to override default settings

```bash
docker run -it \
  -p 9200:9200 \
  -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
  fogfish/elasticsearch
```

Use `AWS_REGION` environment variable to enable AWS specific configurations such as node discovery, etc

```bash
docker run -it \
  -p 9200:9200 \
  -e "AWS_REGION=eu-west-1" \
  fogfish/elasticsearch
```
