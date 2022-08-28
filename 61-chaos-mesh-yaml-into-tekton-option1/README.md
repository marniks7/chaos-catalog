# Chaos Mesh Yaml into Tekton Task

Goal: path chaos mesh yaml inside `Task` as parameter with `Tekton` variables substitution inside

Result: **failed**

Reason: Tekton 

1. create `kpt live init && kpt live apply`
2. logs: `kubectl logs pod-kill-pod`
3. destroy `kpt live destroy`