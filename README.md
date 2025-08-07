# rhel-dev-arm
Simple setup for a development machine on arm using bootc.

Why: 
- On Mac OS using UTM or similar qcow images are painful to use. It's much easier to use an iso installer.
- ISO simulates edge deployment requirements


# Making an iso.
Passing in secrets is not opinionated. To make it as easy as possible a simple template is used to build out the config.toml

```shell
export SSH_KEY_PATH=$HOME/.ssh/id_rsa.pub
export DOCKER_AUTH_PATH=`pwd`/docker-auth.json # or similar for your container registry.
export PASSWORD_HASH='' # us openssl password -6 Make sure to use raw strings (single quotes)
export USERNAME=myusername
```

`make iso` will look after the rest. Using `direnv` or similar to manage the secrets is encouraged.


# Fun things I've found
1. Root users don't cache credentials for podman in RHEL. Rebooting will require re-authenticating with `quay.io` and `registry.redhat.io`
2. Don't try to add more than one group to a user using `--groups`
3. It's much easier if you build as root and don't use sudo.
