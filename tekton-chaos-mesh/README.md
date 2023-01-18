# Tekton Chaos Mesh

Experimental task to apply [Chaos-Mesh](https://chaos-mesh.org/) experiment yaml from [Tekton](https://tekton.dev/) and
preserve valuable info about that.
In allows to integrate this task into pipelines

Variables returned:

1. `namespace` - where chaos pipeline returned
2. `type` - chaos mesh type, e.g. `podchaos.chaos-mesh.org`
3. `name` - experiment generate name

This allows to query chaos mesh experiment as

```
kubectl get $(params.type) $(params.name) --namespace $(params.namespace)
```