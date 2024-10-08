# airflow-install

Install Airflow on InterTwin demo K8s cluster.

Based on this [blog post](https://medium.com/@dulshanr12/airflow-log-integration-with-fluent-bit-elk-stack-kubernetes-f2afa3a6ff00).

Airflow logs -> fluent bit -> Logstash -> ElasticSearch -> Kibana/Airflow
- Fluent Bit agents are deployed in every node (DaemonSet).
- Fluent Bit agents are able to access all pods logs from the ephemeral storage of the Nodes
- Airflow components output the logs in JSON format to standard out including airflow worker logs
- Fluent Bit agents collect these logs and send to Logstash
- Logstash receives the logs and forward it to Elasticsearch cluster with an index after power transformations if necessary.
- Kibana dashboard can then be used to search and analyze the logs.
- Airflow will try to fetch DAG log data from Elasticsearch(ES) when user tries to view the DAGS’s task logs on the airflow web-UI.

[Architecture](architecture.webp)

## Airflow installation

```bash
k get pods -n airflow
```
```
NAME                                 READY   STATUS    RESTARTS        AGE
airflow-statsd-7ffbfb6c8b-mbcbz      1/1     Running   0               3h41m
airflow-postgresql-0                 1/1     Running   0               3h41m
airflow-triggerer-0                  3/3     Running   0               3h41m
airflow-scheduler-546b8c465-5525p    3/3     Running   0               3h41m
airflow-webserver-57b45c57d7-5pqj6   1/1     Running   1 (3h39m ago)   3h41m
```

## ELK Installation

```
 k get pods -n elastic
```
```
NAME                             READY   STATUS    RESTARTS      AGE
kibana-kibana-749869bc5c-pw5vw   1/1     Running   1 (82d ago)   82d
elasticsearch-master-1           1/1     Running   0             4h7m
elasticsearch-master-0           1/1     Running   0             4h7m
elasticsearch-master-2           1/1     Running   0             4h7m
logstash-6f96c794fc-6jn86        1/1     Running   0             3h28m
fluent-bit-lfwcf                 0/1     Running   0             3h27m
fluent-bit-69wd8                 0/1     Running   0             3h27m
fluent-bit-64dzq                 0/1     Running   0             3h27m
fluent-bit-sxzmv                 0/1     Running   0             3h27m
fluent-bit-djtjj                 0/1     Running   0             3h27m
fluent-bit-g5sql                 0/1     Running   0             3h27m
fluent-bit-vbhxm                 0/1     Running   0             3h27m
```

