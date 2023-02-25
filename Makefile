all: run tekton-chaos-mesh
run:
	./runner/init-chaos-runner.sh
tekton-chaos-mesh:
	./tekton-chaos-mesh/deploy.sh