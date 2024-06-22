create_cluster: ## Create a kind cluster
	kind create cluster --name '$(CLUSTER_NAME)' --config "$$PWD/configs/cluster/argocd.yaml" \
	&& kubectl taint nodes -l tier=cd tier=cd:NoSchedule
.PHONY: create_cluster

recreate_cluster: _remove_cluster create_cluster ## Recreate the kind cluster
.PHONY: recreate_cluster

_remove_cluster:
	kind delete cluster --name '$(CLUSTER_NAME)'
.PHONY: _remove_cluster
