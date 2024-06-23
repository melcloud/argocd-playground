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

### Setup Argo CD
To install Argo CD with https, followings are required:
- **cert-manager**: issue self-signed certificate
- **nginx ingress controller**: create routes and expose argo CD service based on ingress definition
- **Argo CD helm chart**: install Argo CD
All above steps are packaged into different make commands:
```bash
make add_helm_repos
make install_cert_manager
make install_nginx
make install_argocd
```

### Create everything end to end
Run `make all` to create every components end to end

### Clean up
Run `make clean` to clean resources

### See all available commands
Run `make help`

## URLs
| Components | URL |
|------------|-----|
| Argo CD    | https://argocd.dev.local:8443 |
