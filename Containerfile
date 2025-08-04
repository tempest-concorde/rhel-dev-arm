FROM registry.redhat.io/rhel10/rhel-bootc:latest
# Install EPEL for RHEL 10
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf groupinstall -y "Server with GUI" && dnf clean all 

RUN dnf install -y \
    podman \
    skopeo \
    git \ 
    vim \
    make \
    vim-enhanced \
    direnv && dnf clean all


RUN bootc container lint
