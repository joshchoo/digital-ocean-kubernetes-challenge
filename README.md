## Requirements

- [just](https://github.com/casey/just)
- [minikube](https://minikube.sigs.k8s.io)

## Getting Started

### Enable Minikube Ingress

```sh
$ minikube addons enable ingress
```

### Create the `logging` Namespace

```sh
$ just create-namespace
```

### Start Elasticsearch

```sh
$ just start-elasticsearch
```

### Executing requests against Elasticsearch

Ensure that Ingress is running. Then make a request to `kube.xyz`:

```sh
$ curl kube.xyz
{
  "name" : "elasticsearch-cluster-0",
  "cluster_name" : "elasticsearch-cluster",
  "cluster_uuid" : "5f6Lf1P4TJCXPPsHrTUT1g",
  "version" : {
    "number" : "7.15.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "93d5a7f6192e8a1a12e154a2b81bf6fa7309da0c",
    "build_date" : "2021-11-04T14:04:42.515624022Z",
    "build_snapshot" : false,
    "lucene_version" : "8.9.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

---

Alternatively, we can make requests within the K8s cluster by exec-ing into a Pod first:

```sh
$ kubectl exec -it dnsutils -n logging -- bash
```

Then make requests against the Elasticsearch service:

```sh
# Target the service
$ curl elasticsearch-svc:9200
```

```sh
# Target a specific Pod by domain name
$ curl elasticsearch-cluster-0.elasticsearch-svc:9200
```

```sh
# Target a specific Pod by IP address
$ kubectl get pods -n logging -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
elasticsearch-cluster-0   1/1     Running   0          36m   172.17.0.2   minikube   <none>           <none>

$ curl 172.17.0.2:9200
```
