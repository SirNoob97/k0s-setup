#!/bin/env bash

[ -z "$(kubectl version --short)" ] && echo "Kubectl cannot establish a connection to the cluster"

# check the version
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace=metallb-system metallb bitnami/metallb -f ./metallb-values.yaml
