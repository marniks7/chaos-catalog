# Rename Secret with search replace

Goal: rename secret (change `metadata.name`) in Secret itself and in related file(s), like [pod.yaml](pod.yaml)

Function: https://catalog.kpt.dev/search-replace/v0.2/

Result: **failed**:

## Issue#0 (main reason)

Fragile:

What if there will be field with the same value (just a coincidence)? for example, secret `nginx` and imagine how many
fields might have the same values

## Issue#1

Upstream: In case if upstream rename secret (without providing functions to update)?

## Issue#2

Upstream: Add this secret to another file -> what the result will be?