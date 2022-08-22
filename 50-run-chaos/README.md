
kubectl config view --minify --raw > kubeconfig.yaml

kubectl create secret generic kubeconfig-target-cluster --output=yaml --dry-run=client \
--from-file=kubeconfig=kubeconfig.yaml \
| tee kubeconfig-target-cluster.yaml