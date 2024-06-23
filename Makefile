CLUSTER_NAME ?= argocd

CERT_MANAGER_VERSION ?= 1.15.0
NGINX_INGRESS_VERSION ?= 4.10.1
ARGO_CD_VERSION ?= 7.2.1

# Don't echo target content
.SILENT:

# Export variables into child process
.EXPORT_ALL_VARIABLES:

all: create_cluster add_helm_repos install_cert_manager install_nginx install_argocd install_argo_rollouts ## Run setup end to end
.PHONY: all

# Add all make build files
include builds/*.mk

clean: _remove_cluster ## Remove resources created
.PHONY: clean
