# Chaos Mesh Yaml into Tekton Task

Goal: put params into params and get variable substitution

Result: **failed**

Reason: `/tekton/scripts/script-0-pgnxz: line 4: params.namespace: command not found`

1. create `kpt live init && kpt live apply`
2. logs: `kubectl logs params-ref-params-pod`
3. destroy `kpt live destroy`

## Issue#2
Pod is marked as successful