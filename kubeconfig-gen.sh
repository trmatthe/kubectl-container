#!/bin/sh
# build a kubeconfig using the service account token projected by k8s

API=https://kubernetes.default.svc
TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
CERT=/run/secrets/kubernetes.io/serviceaccount/ca.crt

kubectl config set-cluster k8s --server=$API --embed-certs=true --certificate-authority=$CERT
kubectl config set-credentials k8s-sa --token=$TOKEN
kubectl config set-context k8s --cluster k8s --user k8s-sa
kubectl config use-context k8s

kubectl config view --raw

# this will fail until the pod.spec gets the non-default serviceaccount
kubectl get pods -A
sleep 3600          # I know this is bad, but it's useful whilst iterating
