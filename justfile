default:
  @just --list

enable-ingress:
  minikube addons enable ingress

create-namespace:
  kubectl apply -f infra/logging-ns.yaml

start-elasticsearch:
  kubectl apply -f infra/elasticsearch.yaml,infra/ingress.yaml

get:
  kubectl get all -n logging

exec-elasticsearch:
  kubectl exec -it elasticsearch-cluster-0 -n logging -- bash

ssh:
  minikube ssh

check:
  curl kube.xyz