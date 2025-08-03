FROM registry.redhat.io/rhel10/rhel-bootc:latest

RUN dnf install -y \
    podman \
    skopeo \
    git \ 
    vim \
    make \
    vim-enhanced


RUN bootc container lint
