CLUSTER_NAME ?= argocd

# Don't echo target content
.SILENT:

# Export variables into child process
.EXPORT_ALL_VARIABLES:

all: create_cluster add_helm_repos install_cert_manager install_nginx install_argocd ## Run setup end to end
.PHONY: all

# Add all make build files
include builds/*.mk

clean: _remove_cluster ## Remove resources created
.PHONY: clean
