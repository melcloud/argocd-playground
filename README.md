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
make install_cert_manager
make install_nginx
make install_argocd
make install_argo_rollouts
```

In addition to install Argo CD, it needs to be configured to create application automatically. It requires:
- A credential to connect to github
- A repositories contains manifest
- ApplicationSet to generate Application

This can be done by using `make argo_setup`. The script will ask for your github username and personal access token (scoped).

### Kargo
> The setup in this repository is not secure!! It hard-coded the password hash.
Kargo is an high level abstraction on top of Argo CD which can be used to promote artifacts through multiple stages.

To install Kargo, run `make install_kargo` and `make kargo_setup`.

### Create everything end to end
Run `make all` to create every components end to end

### Clean up
Run `make clean` to clean resources

### See all available commands
Run `make help`

## URLs
| Components      | URL                           |
|-----------------|-------------------------------|
| Argo CD         | https://argocd.dev.local:8443 |
| Kargo           | https://kargo.dev.local:8443  |
| Demo APP DEV    | https://dev.app.local:8443    |
| Demo APP UAT    | https://uat.app.local:8443    |
| Demo APP PROD   | https://prod.app.local:8443   |
