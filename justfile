default:
  @just --list

create-namespace:
  kubectl apply -f infra/logging-ns.yaml

create-elasticsearch:
  kubectl apply infra/elasticsearch.yaml

get:
  kubectl get all -n logging
