# Change part of docker image to proxy

Goal: change `gcr.io/` to `proxy.company.com/`

Result: **passed**, see [.result](.result)

Command: `kpt fn source . | kpt fn sink .result && kpt fn render .result`

Details: used `Starlank`

## Desired Improvement #1

This `Starlank` [function](changeProxy.yaml) better to search as
in https://catalog.kpt.dev/search-replace/v0.2/?id=field-path-patterns to be able to change image on any hierarchy
level.

At the same time this might not be applicable for `Tekton` or `Argo Workflow`.
Tekton option with specifying image as parameter: `image: $(params.image)`

## Desired Improvement #2  (corner case)

It is possible to specify image `gcr.io/kpt-fn/starlark:v0.4.3` as `starlark:v0.4.3`, so changing proxy will require to
add
`gcr.io/kpt-fn/` (`proxy.company.com/kpt-fn/`)

## Desired Improvement #3

Dynamic support of docker registries, e.g. `gchr.io`, `quay.io`, `k8s.gcr.io`

```
apiVersion: fn.kpt.dev/v1alpha1
kind: StarlarkRun
metadata:
  name: change-image-proxy
params:
  gcr.io: proxy.company.com
  gchr.io: proxy2.company.com
  quay.io: proxy3.company.com
```

## Desired Improvement #4

In Tekton Task image can be specified in field `default`, where `name: image` value can be any

```
- default: gcr.io/cloud-builders/kubectl@sha256:8ab94be8b2b4f3d117f02d868b39540fddd225447abf4014f7ba4765cb39f753
  description: Kubectl wrapper image
  name: image
```

Specifying in `PipelineRun` or in `Pipeline` (as above, `name: image` can have any name)

```
params:
  - name: image
    value: gcr.io/cloud-builders/kubectl@sha256:8ab94be8b2b4f3d117f02d868b39540fddd225447abf4014f7ba4765cb39f753
```

## Desired Improvement #5 (corner case)

In case if image will be specified as: `kpt-fn/starlark:v0.4.3` it will be pulled from docker hub, result should be
`dockerproxy.company.name/kpt-fn/starlark:v0.4.3`