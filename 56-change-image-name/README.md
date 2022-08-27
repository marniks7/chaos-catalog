# Change part of docker image to proxy

Goal: `change gcr.io/` to `proxy.company.com/`

Result: **passed**

Details: used `Starlank`

## Desired Improvement #1

This `Starlank` [function](changeProxy.yaml) better to search as
in https://catalog.kpt.dev/search-replace/v0.2/?id=field-path-patterns to be able to change image on any hierarchy level.

## Desired Improvement #2

It is possible to specify image `gcr.io/kpt-fn/starlark:v0.4.3` as `starlark:v0.4.3`, so changing proxy will require to add
`gcr.io/kpt-fn/`

## Desired Improvement #3

Dynamic support of docker registries, e.g. `gchr.io`, `quay.io`, `k8s.gcr.io`