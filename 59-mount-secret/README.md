# Mount Secret

1. Generate secret from current kubectl
```bash
# current kubeconfig
kubectl config view --minify --raw > unsealed-kubeconfig.yaml
# replace 0.0.0.0
sed -i 's/0.0.0.0/kubernetes.default.svc/; s/6443/443/' unsealed-kubeconfig.yaml
# create secret
kubectl create secret generic kubeconfig-example --output=yaml --dry-run=client \
--from-file=kubeconfig=unsealed-kubeconfig.yaml \
| tee secret.yaml
# remove kubeconfig from local filesystem
rm -f unsealed-kubeconfig.yaml

```
2. Apply
```
kpt live init && kpt live apply
```
3. Check
```
kubectl logs example
```
4. Destroy
```
kpt live destroy
```

### useful commands
1. Generate pod manifest
```bash
kubectl run example --image=busybox --restart=Never --dry-run=client --output=yaml -- sh -c "env && cat /etc/resolv.conf && wget -S https://kubernetes.default.svc:443" | tee pod-test.yaml
```
2. Testing
```bash
kubectl run example --image=busybox --restart=Never -it --rm -- sh -c "wget -S --timeout=5--no-check-certificate https://kubernetes.default.svc:443"
kubectl run example --image=bitnami/kubectl --restart=Never -it --rm -- get pods
```