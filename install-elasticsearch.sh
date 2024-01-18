#!/bin/sh

helm repo add elastic https://helm.elastic.co
helm upgrade --install -f values-elasticsearch.yaml -n elastic --create-namespace elasticsearch elastic/elasticsearch

## install elastic operator crds
#helm install elastic-operator-crds elastic/eck-operator-crds --version 2.6.1
## install elastic operator restricted to manage dataplatform namespace
#helm upgrade --install -n elastic elastic-operator elastic/eck-operator --version 2.6.1 \
#  --set=installCRDs=false \
#  --set=managedNamespaces='{airflow}' \
#  --set=createClusterScopedResources=false \
#  --set=webhook.enabled=false \
#  --set=config.validateStorageClass=false

## install elstic
#kubectl apply -f elastic.yaml
