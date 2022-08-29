# Set Annotations

Goal: set annotations to Chaos Mesh only resources

Result: **passed**, see [.result](.result)

Command: `kpt fn source . | kpt fn sink .result | kpt fn render .result`

## Desired Improvement#1

There are a lot of different CRDs in ChaosMesh and ChaosMesh team continue to add new, and I would prefer to
apply annotations to `group=chaos-mesh.org`

AR: `group` is not supported in `selectors`

```
mutators:
- image: gcr.io/kpt-fn/set-annotations:v0.1.4
selectors:
- kind: PodChaos
- kind: NetworkChaos
configPath: set-annotation-local-config-true.yaml
```

## Desired Improvement#2

All configuration annotations should be possible to remove from on-the-fly before including into another file

```
annotations:
    config.kubernetes.io/local-config: "true"
```