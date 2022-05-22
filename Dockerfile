# syntax=docker/dockerfile:1
FROM alpine:3.15.4
ARG KUBECTL_V=1.22.8
RUN addgroup kctl && adduser -H -D -G kctl kctl
RUN apk add --update --no-cache curl ca-certificates bash
RUN curl -sLO https://dl.k8s.io/release/v${KUBECTL_V}/bin/linux/amd64/kubectl && mv kubectl /usr/bin/kubectl && chmod 755 /usr/bin/kubectl
WORKDIR /home/kctl
COPY kubeconfig-gen.sh .
RUN chown -R kctl:kctl /home/kctl
USER kctl
CMD /home/kctl/kubeconfig-gen.sh
