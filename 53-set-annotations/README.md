# Set Annotations

Goal: set annotations to Chaos Mesh only resources

Result: **passed**

## Desired Improvement

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


