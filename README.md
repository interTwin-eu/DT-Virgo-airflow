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

- check installation with helm
```
helm ls -n airflow
```
```
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
airflow airflow         1               2024-10-08 11:38:46.134326 +0200 CEST   deployed        airflow-1.14.0  2.9.2 
```
- check pods are running
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
- check pvc
```
k get pvc -n airflow
```
```
NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-airflow-postgresql-0   Bound    pvc-f85ffcc3-0ecb-4132-b3f3-7a561d08957e   8Gi        RWO            longhorn       4h12m
logs-airflow-triggerer-0    Bound    pvc-38b2590c-c20b-48e4-b95e-39ae3d82adc8   100Gi      RWO            longhorn       4h12m
```


## ELK Installation

- check installation with helm
```
helm ls -n elastic
```
```
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
elasticsearch   elastic         1               2024-10-08 11:14:49.910223 +0200 CEST   deployed        elasticsearch-8.5.1     8.5.1      
fluent-bit      elastic         1               2024-10-08 11:55:25.825629 +0200 CEST   deployed        fluent-bit-0.22.0       2.0.8      
kibana          elastic         1               2024-07-17 15:38:14.115739 +0200 CEST   deployed        kibana-8.5.1            8.5.1      
```
- check pods are running
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
- check pvc
```
k get pvc -n elastic
```
```
NAME                                          STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
elasticsearch-master-elasticsearch-master-1   Bound    pvc-ce229a6f-576d-4220-8f4c-3d73fbfa660f   30Gi       RWO            longhorn       4h38m
elasticsearch-master-elasticsearch-master-0   Bound    pvc-38544109-58cf-4033-8e83-d4c378944bd0   30Gi       RWO            longhorn       4h38m
elasticsearch-master-elasticsearch-master-2   Bound    pvc-3b08436d-7035-439a-80c1-604c8ecdf1fc   30Gi       RWO            longhorn       4h38m
```
