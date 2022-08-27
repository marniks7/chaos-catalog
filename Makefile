kustomize:
	$(MAKE) -C chaos-catalog
kpt-source-test:
	kpt fn source chaos-catalog | kpt fn sink 55-test
kpt-source-test-delete:
	rm -rf 55-test
