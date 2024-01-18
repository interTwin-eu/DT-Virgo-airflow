#!/bin/sh

helm repo add fluent https://fluent.github.io/helm-charts

helm upgrade --install -f values-fluentbit.yaml fluent-bit fluent/fluent-bit --version 0.22.0 --namespace elastic
