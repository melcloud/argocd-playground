argo_get_admin_password: ## Print admin password of Argo CD
	kubectl get secrets -n argocd argocd-initial-admin-secret --template '{{ .data.password | base64decode }}{{"\n"}}'
.PHONY: argo_get_admin_password
