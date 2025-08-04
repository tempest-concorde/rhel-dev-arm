FROM registry.redhat.io/rhel10/rhel-bootc:latest
RUN /usr/bin/crb enable
RUN sudo dnf install -y epel-release

RUN dnf install -y \
    podman \
    skopeo \
    git \ 
    vim \
    make \
    vim-enhanced \
    direnv && dnf clean all

# Install Red Hat server UI
RUN dnf groupinstall -y "Server with GUI" && dnf clean all

RUN bootc container lint
