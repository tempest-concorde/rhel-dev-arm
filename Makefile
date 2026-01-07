# Architecture detection for multi-arch builds
UNAME_ARCH := $(shell uname -m)
ifeq ($(UNAME_ARCH),x86_64)
    BINARY_ARCH := amd64
else ifeq ($(UNAME_ARCH),aarch64)
    BINARY_ARCH := arm64
else
    BINARY_ARCH := $(UNAME_ARCH)
endif

get_vma:
	echo "Not implemented"
	# wget https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.115.0/vmutils-linux-$(BINARY_ARCH)-v1.115.0.tar.gz -O vmutils.tar.gz
	# tar -xvzf ./vmutils.tar.gz
	# mv vmagent-prod vmagent
	# rm *-prod vmutils.tar.gz
get_node:
	echo "Not implemented"
	# wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-$(BINARY_ARCH).tar.gz -O node-exporter.tar.gz
	# tar -xvzf ./node-exporter.tar.gz
	# mv node_exporter-1.9.1.linux-$(BINARY_ARCH)/node_exporter node_exporter
	# rm -r node-exporter.tar.gz node_exporter-1.9.1.linux-$(BINARY_ARCH)

get-direnv:
	wget https://github.com/direnv/direnv/releases/download/v2.37.1/direnv.linux-$(BINARY_ARCH) -O direnv

get-deps: get_node get_vma get-direnv


dev:
	go install github.com/hairyhenderson/gomplate/v3/cmd/gomplate@latest

toml:
	gomplate -f config.toml.tmpl -o config.toml

iso: toml get-deps
	rm -rf output
	mkdir output
	podman pull quay.io/rh-ee-chbutler/rhel-dev:latest
	podman pull registry.redhat.io/rhel10/bootc-image-builder:latest
	podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t -v /var/lib/containers/storage:/var/lib/containers/storage -v $(CURDIR)/config.toml:/config.toml -v $(CURDIR)/output:/output registry.redhat.io/rhel10/bootc-image-builder:latest --type iso quay.io/rh-ee-chbutler/rhel-dev:latest


qcow: toml get-deps
	rm -rf output
	mkdir output
	podman pull quay.io/rh-ee-chbutler/rhel-dev:latest
	podman pull registry.redhat.io/rhel10/bootc-image-builder:latest
	podman run \
			--rm \
			-it \
			--privileged \
			--pull=newer \
			--security-opt label=type:unconfined_t \
			-v $(CURDIR)/config.toml:/config.toml:ro \
			-v $(CURDIR)/output:/output \
			-v /var/lib/containers/storage:/var/lib/containers/storage \
			registry.redhat.io/rhel10/bootc-image-builder:latest \
			--local \
			--type qcow2 \
			quay.io/rh-ee-chbutler/rhel-dev:latest