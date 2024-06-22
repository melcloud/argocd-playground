CLUSTER_NAME ?= argocd

# Don't echo target content
.SILENT:

# Export variables into child process
.EXPORT_ALL_VARIABLES:

# Add all make build files
include builds/*.mk

all: create_cluster ## Run setup end to end
.PHONY: all

clean: _remove_cluster ## Remove resources created
.PHONY: clean
