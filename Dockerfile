# syntax=docker/dockerfile:1
FROM alpine:3.15.4
ARG KUBECTL_V=1.22.8

# apk files * kubectl are unlikely to change so can be chained to fit in single
# cache layer
RUN addgroup kctl && adduser -H -D -G kctl kctl && \
    apk add --update --no-cache curl ca-certificates bash && \
    curl -sLO https://dl.k8s.io/release/v${KUBECTL_V}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && chmod 755 /usr/bin/kubectl
WORKDIR /home/kctl
COPY kubeconfig-gen.sh .
RUN chown -R kctl:kctl /home/kctl
USER kctl
ENTRYPOINT ["/home/kctl/kubeconfig-gen.sh"]
CMD [""]
