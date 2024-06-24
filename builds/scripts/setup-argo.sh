#!/usr/bin/env sh
# shellcheck shell=bash
set -euo pipefail

echo "Get Argo CD admin password"
ARGO_ADMIN_PASSWORD="$(kubectl get secrets -n argocd argocd-initial-admin-secret --template '{{ .data.password | base64decode }}')"

echo "Login to argocd through CLI"
argocd login argocd.dev.local:8443 --name argocd-demo --grpc-web --insecure --username "admin" --password "$ARGO_ADMIN_PASSWORD"

echo "Add Github repository credential"
echo "Github username: "
read -r GITHUB_USERNAME
echo "Github token: "
read -sr GITHUB_TOKEN
echo "Processing..."
argocd repocreds add https://github.com/bjss --username "$GITHUB_USERNAME" --password "$GITHUB_TOKEN"

echo "Add Github repository"
argocd repo add 'https://github.com/bjss/lunch-and-learn-argocd-playground.git'

echo "Add projects"
for proj in argo-demo kargo-demo; do
  argocd proj create "$proj" -f "$PWD/configs/argocd/${proj}/project.yaml"
  argocd appset create "$PWD/configs/argocd/${proj}/application-set.yaml"
done
