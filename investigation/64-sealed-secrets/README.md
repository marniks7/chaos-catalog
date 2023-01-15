# Sealed Secrets

https://github.com/bitnami-labs/sealed-secrets

1. Install server and client tools
2. Generate unsealed secret
```
echo -n bar | kubectl create secret generic mysecret --dry-run=client --from-file=foo=/dev/stdin -o yaml > unsealedsecret.yaml
```
2. Generate sealed secret
`kubeseal -o yaml <unsealedsecret.yaml > secret.yaml`
3. Apply to server
`kubectl apply -f secret.yaml`