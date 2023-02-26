#!/bin/bash

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

if ! check_cmd "kind"; then
  echo "kind not found"
  exit 1
fi

if ! check_cmd "helm"; then
  echo "helm not found"
  exit 1
fi
if ! check_cmd "kubectl"; then
  echo "kubectl not found"
  exit 1
fi

set +e
# Kubernetes
# kind create cluster --name runner || true
# Kind with ingress support
# https://kind.sigs.k8s.io/docs/user/ingress/#create-cluster
cat <<EOF | kind create cluster --name runner --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  image: kindest/node:v1.23.13@sha256:ef453bb7c79f0e3caba88d2067d4196f427794086a7d0df8df4f019d5e336b61
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
set -e
kind export kubeconfig --name runner
# Chaos Mesh
# https://chaos-mesh.org/docs/production-installation-using-helm/
# https://github.com/chaos-mesh/chaos-mesh/tree/master/helm/chaos-mesh

# dashboard.service.type=ClusterIP otherwise it created NodePort by default
# replicaCount by default 3. save resources.
helm repo add chaos-mesh https://charts.chaos-mesh.org || true
#helm search repo chaos-mesh || true
# helm repo update
helm upgrade --install chaos-mesh chaos-mesh \
  --repo https://charts.chaos-mesh.org \
  --namespace chaos-mesh --create-namespace \
  --version 2.5.1 \
  --set controllerManager.replicaCount=1 \
  --set dashboard.service.type=ClusterIP

# Tekton Pipelines
# https://tekton.dev/docs/pipelines/install/
kubectl apply --filename https://github.com/tektoncd/pipeline/releases/download/v0.45.0/release.yaml
## Tekton Config
kubectl apply --filename runner/feature-flags.yaml
# Tekton Dashboard
# https://tekton.dev/docs/dashboard/install/
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v0.32.0/release-full.yaml
# Tekton Results
# https://github.com/tektoncd/results/blob/main/docs/install.md
kubectl create secret generic tekton-results-postgres --namespace="tekton-pipelines" --from-literal=POSTGRES_USER=postgres --from-literal=POSTGRES_PASSWORD=$(openssl rand -base64 20) || true
#apk add openssl
openssl req -x509 \
  -newkey rsa:4096 \
  -keyout key.pem \
  -out cert.pem \
  -days 365 \
  -nodes \
  -subj "/CN=tekton-results-api-service.tekton-pipelines.svc.cluster.local" \
  -addext "subjectAltName = DNS:tekton-results-api-service.tekton-pipelines.svc.cluster.local"
kubectl create secret tls -n tekton-pipelines tekton-results-tls \
  --cert=cert.pem \
  --key=key.pem || true
kubectl apply -f https://storage.googleapis.com/tekton-releases/results/previous/v0.3.0/release.yaml
# Keycloak
# https://artifacthub.io/packages/helm/bitnami/keycloak
helm upgrade --install keycloak keycloak \
  --repo https://charts.bitnami.com/bitnami \
  --namespace keycloak --create-namespace

# Ingress Controller
# https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/kind/deploy.yaml
# https://kubernetes.github.io/ingress-nginx/deploy/
#helm upgrade --install ingress-nginx ingress-nginx \
#  --repo https://kubernetes.github.io/ingress-nginx \
#  --namespace ingress-nginx --create-namespace

# App
kubectl apply -f runner/app-http-echo.yaml

# Wait for ingress controller
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# Ingress
CHAOS_MESH_INGRESS_YAML=$(
  cat <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: chaos-dashboard
  namespace: chaos-mesh
spec:
  rules:
    - host: chaos-mesh.127.0.0.1.nip.io
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: chaos-dashboard
                port:
                  number: 2333

EOF
)
echo "${CHAOS_MESH_INGRESS_YAML}" | kubectl apply -f -

TEKTON_INGRESS_YAML=$(
  cat <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tekton-dashboard
  namespace: tekton-pipelines
spec:
  rules:
    - host: tekton-dashboard.127.0.0.1.nip.io
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: tekton-dashboard
                port:
                  number: 9097
EOF
)
echo "${TEKTON_INGRESS_YAML}" | kubectl apply -f -

echo "Results"
echo "Chaos Mesh Dashboard: http://chaos-mesh.127.0.0.1.nip.io"
echo "Tekton Dashboard: http://tekton-dashboard.127.0.0.1.nip.io"
echo "Tekton Dashboard: kubectl port-forward -n tekton-pipelines service/tekton-dashboard 9097:9097"
echo "Tekton Dashboard: http://localhost:9097"