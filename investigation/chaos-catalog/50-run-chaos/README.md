k3d kubeconfig merge target -d

kubectl config view --minify --raw > unsealed-kubeconfig.yaml

kubectl create secret generic kubeconfig-example --output=yaml --dry-run=client \
--from-file=kubeconfig=unsealed-kubeconfig.yaml \
| tee unsealed-secret.yaml