# rhel-dev-arm
Development machine for RHEL 10 as image mode


# Making an iso.
Passing in secrets is not opinionated. To make it as easy as possible a simple template is used to build out the config.toml

```shell
export SSH_KEY_PATH=$HOME/.ssh/id_rsa.pub
export PASSWORD_HASH= # use openssl passwd -6
export DOCKER_AUTH_PATH=`pwd`/docker-auth.json # or similar
export USER= # my user
```

`make iso` will look after the rest. Using `direnv` or similar to manage the secrets is encouraged.