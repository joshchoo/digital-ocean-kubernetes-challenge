default:
  @just --list

deploy-digital-ocean:
  kubectl apply -f infra/elasticsearch.yaml,infra/fluentd.yaml,infra/kibana.yaml,counter.yaml


# Scripts for local development:

enable-ingress:
  minikube addons enable ingress

create-namespace:
  kubectl apply -f infra/logging-ns.yaml

start-elasticsearch:
  kubectl apply -f infra/volumes.yaml,infra/elasticsearch.yaml,infra/ingress.yaml

start-fluentd:
  kubectl apply -f infra/fluentd.yaml

start-kibana:
  kubectl apply -f infra/kibana.yaml

restart-kibana:
  just start-kibana
  kubectl rollout restart deployment kibana -n logging

get:
  kubectl get all -n logging

exec-elasticsearch:
  kubectl exec -it elasticsearch-cluster-0 -n logging -- bash

ssh:
  minikube ssh

check:
  curl kube.xyz

check-state:
  curl "kube.xyz/_cluster/state?pretty"

port-forward:
  # Forwards from localhost:9200
  kubectl port-forward elasticsearch-cluster-0 9200:9200 -n logging

rollout:
  just start-elasticsearch
  kubectl rollout restart elasticsearch

rollout-status:
  kubectl rollout status sts/elasticsearch-cluster -n logging