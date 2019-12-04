FROM docker:dind

# Install requirements
RUN apk add -U openssl curl tar gzip bash ca-certificates && \
  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
  apk add glibc-2.30-r0.apk && \
  rm glibc-2.30-r0.apk

# Ruby is required for reading CI_ENVIRONMENT_URL from .gitlab-ci.yml
RUN apk add ruby git

# Install Helm
RUN apk add --update --no-cache curl ca-certificates && \
    curl -L https://get.helm.sh/helm-v3.0.0-linux-amd64.tar.gz |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    apk del curl && \
    rm -f /var/cache/apk/* && \
    helm version --client

## Install Helm Canary
#RUN curl https://kubernetes-helm.storage.googleapis.com/helm-canary-linux-amd64.tar.gz | \
#  tar zx && mv linux-amd64/helm /usr/bin/ && \
#  helm version --client

# Install kubectl
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/latest.txt)/bin/linux/amd64/kubectl && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client

ENTRYPOINT []
CMD []
