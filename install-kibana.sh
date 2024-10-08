#!/bin/sh
helm repo add elastic https://helm.elastic.co
helm upgrade --install -n elastic kibana elastic/kibana
