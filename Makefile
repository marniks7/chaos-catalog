SINK=1001-test
kustomize:
	$(MAKE) -C chaos-catalog
kpt-test-source:
	kpt fn source chaos-catalog | kpt fn eval - -i set-namespace:v0.4.1 -- namespace=$(SINK) | kpt fn sink $(SINK)
kpt-test-apply:
	kpt live init $(SINK) && kpt live apply $(SINK)
kpt-test-delete:
	kpt live destroy $(SINK) || true && rm -rf $(SINK)

# all
#make kpt-test-source && make kpt-test-apply || make kpt-test-delete