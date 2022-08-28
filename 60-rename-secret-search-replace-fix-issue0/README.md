# Rename Secret with search replace

Goal: rename secret (change `metadata.name`) in Secret itself and in related file(s), like [pod.yaml](pod.yaml)

Result: **still failed**: 

## Issue#0 (main reason)

The previous issue#0 is fixed, but now we have another problem: we need 3 (!) files to support that renaming

More over, user will need to set that in 3 (!) files, or we will need to make automation for that

## Issue#1

Upstream: In case if upstream rename secret (without providing functions to update)?

## Issue#2

Upstream: Add this secret to another file -> what the result will be?