#!/bin/bash
kubectl create namespace tekton-chaos-mesh
kubectl create serviceaccount tekton-chaos-mesh -n tekton-chaos-mesh
kubectl create clusterrole tekton-chaos-mesh --verb=get,list,watch,create,delete,patch --resource=*.chaos-mesh.org
kubectl create clusterrolebinding tekton-chaos-mesh --serviceaccount=tekton-chaos-mesh:tekton-chaos-mesh --clusterrole tekton-chaos-mesh
kubectl apply -f tekton-chaos-mesh/chaos-mesh-task.yaml
kubectl create -f tekton-chaos-mesh/chaos-mesh-taskrun.yaml