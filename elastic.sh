#!/bin/bash

##
swapoff -a

##
mkdir -p /mnt/vol1/data
mkdir -p /mnt/vol1/logs

echo "==> set permission /mnt/vol1/data"
chown -R elasticsearch:elasticsearch /mnt/vol1/data

echo "==> set permission /mnt/vol1/logs"
chown -R elasticsearch:elasticsearch /mnt/vol1/logs

##
## enable AWS specific configuration
## https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html
if [ ! -z "$AWS_REGION" ];
then

   ## merge AWS specific settings
   cat /usr/share/elasticsearch/config/elasticsearch_on_aws.yml >> /usr/share/elasticsearch/config/elasticsearch.yml

   # In order not to make cross compute environment clusters we want to make sure it will restrict nodes
   # to poll using security group of current compute environment
   SG=$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC/security-group-ids | head -1)
   sed -i "$ a discovery.ec2.groups: ${SG}" /usr/share/elasticsearch/config/elasticsearch.yml

   sed -i "$ a discovery.ec2.endpoint: ec2.${AWS_REGION}.amazonaws.com"  /usr/share/elasticsearch/config/elasticsearch.yml
fi

su elasticsearch -c "/usr/share/elasticsearch/bin/elasticsearch"