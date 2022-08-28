# Rename Secret

Goal: rename secret (change `metadata.name`) in Secret itself and in related file(s), like [pod.yaml](pod.yaml)

Result: **failed**

## Issue#0 (main reason)
Unclear how to identify secret in order to change `metadata.name` in that secret. (there is no option to
identify by `filename`)

## Issue#1

Upstream: In case if upstream rename secret (without providing functions to update)?

## Issue#2

Upstream: Add this secret to another file -> what the result will be?

## Issue#3

Upstream: In case if volume name renamed?