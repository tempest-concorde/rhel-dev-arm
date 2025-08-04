FROM registry.redhat.io/rhel10/rhel-bootc:latest
# Install EPEL for RHEL 10

RUN dnf groupinstall -y "Server with GUI" && dnf clean all 

RUN dnf install -y \
    podman \
    skopeo \
    git \ 
    vim \
    make \
    vim-enhanced \
    go && \
    dnf clean all

COPY direnv /usr/bin/local/direnv
RUN chmod +x /usr/bin/local/direnv

RUN bootc container lint
