#!/bin/sh

helm repo add apache-airflow https://airflow.apache.org
helm upgrade --install airflow apache-airflow/airflow -f values-airflow.yaml --namespace airflow --create-namespace
