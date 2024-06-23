add_helm_repos: ## Add required helm repositories
	helm repo add jetstack https://charts.jetstack.io
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update
.PHONY: add_helm_repos

install_cert_manager: ## Install or upgrade cert-manager
	helm upgrade cert-manager jetstack/cert-manager \
		-i --namespace cert-manager --create-namespace \
		-f "$$PWD/configs/helm/cert-manager/values.yaml"
		--wait
	kubectl apply -f "$$PWD/configs/cert-manager/ca.yaml"
.PHONY: install_cert_manager

install_nginx: ## Install or upgrade Nginx ingress controller
	helm upgrade nignx ingress-nginx/ingress-nginx \
		-i --namespace nginx --create-namespace \
		-f "$$PWD/configs/helm/nginx/values.yaml" \
		--wait
.PHONY: install_nginx

install_argocd: ## Install or upgrade Argo CD
	helm upgrade argo-playground argo/argo-cd \
		-i --atomic --namespace argocd --create-namespace \
		-f "$$PWD/configs/helm/argocd/values.yaml"
.PHONY: install_argocd
