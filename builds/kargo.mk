kargo_setup: ## Setup Kargo project, warehouse, stages
	sh "$(CURDIR)/builds/scripts/setup-kargo.sh"
.PHONY: kargo_setup
