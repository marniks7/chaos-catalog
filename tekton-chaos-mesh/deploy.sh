#!/bin/bash
kubectl create namespace tekton-chaos-mesh
kubectl apply -f tekton-chaos-mesh/roles.yaml
kubectl apply -f tekton-chaos-mesh/chaos-mesh-task.yaml
kubectl apply -f tekton-chaos-mesh/tekton-chaos-mesh-wait.yaml