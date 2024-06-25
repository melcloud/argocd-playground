#!/usr/bin/env sh
# shellcheck shell=bash
set -euo pipefail

KARGO_PROJECT="kargo-demo"

echo "Login to Kargo through CLI"
kargo login https://kargo.dev.local:8443 --admin --insecure-skip-tls-verify

if ! kargo get project "$KARGO_PROJECT"; then
  echo "Create Kargo project"
  kargo create project "$KARGO_PROJECT"
fi

if ! kargo get credentials --project "$KARGO_PROJECT" bjss-git; then
  echo "Add Github repository credential"
  echo "Github username: "
  read -r GITHUB_USERNAME
  echo "Github token: "
  read -sr GITHUB_TOKEN
  echo "Processing..."
  kargo create credentials \
    --project "$KARGO_PROJECT" bjss-git \
    --git --repo-url '^https://github.com/bjss/.+$' \
    --regex \
    --username "$GITHUB_USERNAME" \
    --password "$GITHUB_TOKEN"
fi

echo "Create Kargo warehouse for Nginx image"
cat <<-EOF | kargo apply -f -
apiVersion: kargo.akuity.io/v1alpha1
kind: Warehouse
metadata:
  name: "nginx-image"
  namespace: "$KARGO_PROJECT"
spec:
  subscriptions:
  - image:
      repoURL: nginx
      semverConstraint: ^1.26.0
      discoveryLimit: 5
EOF

echo "Create Kargo stages"
cat <<-EOF | kargo create -f -
apiVersion: kargo.akuity.io/v1alpha1
kind: Stage
metadata:
  name: dev
  namespace: "$KARGO_PROJECT"
spec:
  subscriptions:
    warehouse: nginx-image
  promotionMechanisms:
    gitRepoUpdates:
    - repoURL: 'https://github.com/bjss/lunch-and-learn-argocd-playground.git'
      readBranch: kargo-demo
      writeBranch: "kargo/stages/dev"
      kustomize:
        images:
        - image: nginx
          path: apps/stages/dev
    argoCDAppUpdates:
    - appName: kargo-demo-dev
      appNamespace: argocd
---
apiVersion: kargo.akuity.io/v1alpha1
kind: Stage
metadata:
  name: uat
  namespace: "$KARGO_PROJECT"
spec:
  subscriptions:
    upstreamStages:
    - name: dev
  promotionMechanisms:
    gitRepoUpdates:
    - repoURL: 'https://github.com/bjss/lunch-and-learn-argocd-playground.git'
      readBranch: kargo-demo
      writeBranch: "kargo/stages/uat"
      kustomize:
        images:
        - image: nginx
          path: apps/stages/uat
    argoCDAppUpdates:
    - appName: kargo-demo-uat
      appNamespace: argocd
---
apiVersion: kargo.akuity.io/v1alpha1
kind: Stage
metadata:
  name: prod
  namespace: "$KARGO_PROJECT"
spec:
  subscriptions:
    upstreamStages:
    - name: uat
  promotionMechanisms:
    gitRepoUpdates:
    - repoURL: 'https://github.com/bjss/lunch-and-learn-argocd-playground.git'
      readBranch: kargo-demo
      writeBranch: "kargo/stages/prod"
      kustomize:
        images:
        - image: nginx
          path: apps/stages/prod
    argoCDAppUpdates:
    - appName: kargo-demo-prod
      appNamespace: argocd
EOF
