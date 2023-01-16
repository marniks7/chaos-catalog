FROM mikefarah/yq as YQ
FROM bitnami/kubectl
USER root
COPY --from=YQ /usr/bin/yq /usr/bin/yq
USER 1001