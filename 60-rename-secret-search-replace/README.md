# Rename Secret

Goal: rename secret (change `metadata.name`) in Secret itself and in related file(s), like [pod.yaml](pod.yaml)

Result: **failed**

Reason: unclear how to identify secret in order to change `metadata.name` in that secret. (there is no option to identify by `filename`)

## Another issue
* In case if upstream rename secret or adds this secret to another file, how to modify it?
* in case if volume is renamed?