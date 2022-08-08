#!/bin/sh
# Build a kubeconfig using the service account token projected by k8s
# Once complete the container will sleep infinite unless passed
#  additional command parameters

set -e -u 
 
API=https://kubernetes.default.svc
TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
CERT=/run/secrets/kubernetes.io/serviceaccount/ca.crt

kubectl config set-cluster k8s --server="$API" --embed-certs=true --certificate-authority="$CERT"
kubectl config set-credentials k8s-sa --token="$TOKEN"
kubectl config set-context k8s --cluster k8s --user k8s-sa
kubectl config use-context k8s

kubectl config view --raw

# Did our ENTRYPOINT get anything appended via CMD
# We shift once to knock off our dummy CMD [""]

shift

if [ "$#" -gt 0 ]
then
  echo "TODO we have parameters, so handle the chained command"
else
  echo "Entering into infinite sleep at $(date)"
  sleep infinite
fi
