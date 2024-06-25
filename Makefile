CLUSTER_NAME ?= argocd

CERT_MANAGER_VERSION ?= 1.15.0
NGINX_INGRESS_VERSION ?= 4.10.1
ARGO_CD_VERSION ?= 7.2.1
ARGO_ROLLOUTS_VERSION ?= 2.36.1
KARGO_VERSION ?= 0.7.1

# Don't echo target content
.SILENT:

# Export variables into child process
.EXPORT_ALL_VARIABLES:

all: create_cluster install_cert_manager install_nginx install_argocd install_argo_rollouts install_kargo argo_setup ## Run setup end to end
.PHONY: all

# Add all make build files
include builds/*.mk

clean: _remove_cluster ## Remove resources created
.PHONY: clean
