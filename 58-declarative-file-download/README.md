# Declarative file download

Goal: Download yaml files from [hub.tekton.dev](https://hub.tekton.dev/tekton/task/git-clone) in declarative way

Reason:

1. source url is specified
2. very easy to upgrade to newer version

Result: **failed** for `kpt`, **passed** for `kustomize`, see [.result](.result)

Reason: `kpt` doesn't have such option

Command: `mkdir -p .result && kubectl kustomize -o .result`

## Alternative

1. `kustomize`
2. call kustomize from kpt
    1. `kpt` use `exec` and call `kubectl kustomize` - doesn't work, it will remove resources
    2. `kpt`use `exec` in some other way? not yet clear