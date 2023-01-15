# Share Tasks and Pipelines

Options how to share
1. `kpt`
2. fork
3. git-submodules
4. `uses` implemented in [Jenkins](https://jenkins-x.io/v3/develop/pipelines/catalog/)

# Declarative file download with Kustomize

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- https://api.hub.tekton.dev/v1/resource/tekton/task/kubernetes-actions/0.2/raw
```

Pros:
* Very easy to upgrade if needed
* Source of the file declared
* Synergy with approach when `kustomize` is used for other yaml (or maybe `kpt` - TBD)

Cons:
* No output folder is specified

# Chaos Mesh Yaml(s)

There are few options where to specify chaos mesh yaml(s).

1. YAML as user parameter in PipelineRun
2. YAML in Task with some params to specify by user