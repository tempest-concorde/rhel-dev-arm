FROM registry.redhat.io/rhel10/rhel-bootc:latest
# Install EPEL for RHEL 10

RUN dnf groupinstall -y "Server with GUI" && dnf clean all 
RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/10/tailscale.repo


RUN dnf install -y \
    qemu-guest-agent \
    podman \
    skopeo \
    git \ 
    vim \
    make \
    vim-enhanced \
    go \
    java-21-openjdk \
    tailscale \ 
    java-21-openjdk-devel \
    maven && \
    dnf clean all

COPY direnv /usr/bin/local/direnv
RUN chmod +x /usr/bin/local/direnv

RUN bootc container lint
