argo_get_admin_password: ## Print admin password of Argo CD
	kubectl get secrets -n argocd argocd-initial-admin-secret --template '{{ .data.password | base64decode }}{{"\n"}}'
.PHONY: argo_get_admin_password

argo_setup: ## Setup Argo CD projects and applications
	sh "$(CURDIR)/builds/scripts/setup-argo.sh"
.PHONY: argo_setup
