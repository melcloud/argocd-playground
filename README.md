# Playground for argo CD
## Prerequisites
You need following to run this playground:
- docker / podman
- kind
- kubectl
- helm
Apart from helm, all these should come with docker desktop or podman desktop.

## Kubernetes cluster
This repository requires a kubernetes cluster to install Argo CD. Run `make create_cluster` to create the kind cluster.

## Clean up
Run `make clean` to clean resources

## See all available commands
Run `make help`
