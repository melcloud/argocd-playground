install_cert_manager: ## Install or upgrade cert-manager
	helm upgrade cert-manager https://charts.jetstack.io/cert-manager \
		-i --namespace cert-manager --create-namespace \
		-f "$$PWD/configs/helm/cert-manager/values.yaml" \
		--version '$(CERT_MANAGER_VERSION)' \
		--wait
	kubectl apply -f "$$PWD/configs/cert-manager/ca.yaml"
.PHONY: install_cert_manager

install_nginx: ## Install or upgrade Nginx ingress controller
	helm upgrade nginx https://kubernetes.github.io/ingress-nginx/ingress-nginx \
		-i --namespace nginx --create-namespace \
		-f "$$PWD/configs/helm/nginx/values.yaml" \
		--version '$(NGINX_INGRESS_VERSION)' \
		--wait
.PHONY: install_nginx

install_argocd: ## Install or upgrade Argo CD
	helm upgrade argo-playground https://argoproj.github.io/argo-helm/argo-cd \
		-i --atomic --namespace argocd --create-namespace \
		-f "$$PWD/configs/helm/argocd/values.yaml" \
		--version '$(ARGO_CD_VERSION)'
.PHONY: install_argocd

install_argo_rollouts: ## Install or upgrade Argo Rollouts
	helm upgrade argo-rollouts https://argoproj.github.io/argo-helm/argo-rollouts \
		-i --namespace argo-rollouts --create-namespace \
		-f "$$PWD/configs/helm/argo-rollouts/values.yaml" \
		--version '$(ARGO_ROLLOUTS_VERSION)' \
		--wait
.PHONY: install_argo_rollouts

install_kargo: ## Install or upgrade Kargo
	helm upgrade kargo oci://ghcr.io/akuity/kargo-charts/kargo \
		-i --namespace kargo --create-namespace \
		-f "$$PWD/configs/helm/kargo/values.yaml" \
		--set api.adminAccount.passwordHash='$$2a$$10$$Zrhhie4vLz5ygtVSaif6o.qN36jgs6vjtMBdM6yrU1FOeiAAMMxOm' \
		--set api.adminAccount.tokenSigningKey="$$(openssl rand -base64 29 | tr -d '=+/')" \
		--version '$(KARGO_VERSION)' \
		--wait
.PHONY: install_kargo
