#!/bin/env bash

[ -z "$(kubectl version --short)" ] && echo "Kubectl cannot establish a connection to the cluster"

# check the version                                                 *****
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace=metallb-system metallb bitnami/metallb -f ./metallb-values.yaml

echo ""

helm repo add traefik https://helm.traefik.io/traefik
helm install --namespace=kube-system traefik traefik/traefik

echo -e "\n\tTraefik ingressroute example does not work at the version 10.1.1\n\tThis is because Traefik uses a self-signed certificate and is not accepted by browsers"

echo -e "\tUse port forwarding or configure traefik to use another type of certificate"
echo -e '\tkubectl --namespace=kube-system port-forward $(kubectl --namespace=kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000'
