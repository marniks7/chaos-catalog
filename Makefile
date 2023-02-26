.PHONY: init deploy run run-pipeline-pod-kill run-task-pod-kill
init:
	./runner/init-chaos-runner.sh
deploy:
	./tekton-chaos-mesh/deploy.sh
run-pipeline-pod-kill: deploy
	kubectl create -f tekton-chaos-mesh/pipelinerun-pod-kill.yaml
run-task-pod-kill: deploy
	kubectl create -f tekton-chaos-mesh/chaos-mesh-taskrun.yaml