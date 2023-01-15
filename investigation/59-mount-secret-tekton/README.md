# Mount Secret inside Tekton TaskRun

Goal: generate secret from file and mount to `Tekton` `TaskRun`

Note: do NOT commit your secret if it is from real environment

Result: It works :)

1. Generate secret from current kubectl
```bash
# current kubeconfig
kubectl config view --minify --raw > unsealed-kubeconfig.yaml
# replace 0.0.0.0
sed -i 's/0.0.0.0/kubernetes.default.svc/; s/6443/443/' unsealed-kubeconfig.yaml
# create secret
kubectl create secret generic kubeconfig-example --output=yaml --dry-run=client \
--from-file=kubeconfig=unsealed-kubeconfig.yaml \
| tee unsealed-secret.yaml
# remove kubeconfig from local filesystem
rm -f unsealed-kubeconfig.yaml
```
2. Apply
```
kpt live init && kpt live apply
```
3. Check
```
kubectl logs get-pods-pod
```
4. Destroy
```
kpt live destroy
```