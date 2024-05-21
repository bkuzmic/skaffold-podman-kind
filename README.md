# Skaffold - using Podman and Kind

This is an example of running running Skaffold with only rootless Podman and Kind (no Docker client or server is required), using local registry also deployed in Kind.

## Test environment
- Ubuntu 24.04
- Podman 4.9.3 (rootless)
- [Kind v0.23.0](https://github.com/kubernetes-sigs/kind/releases/download/v0.23.0/kind-linux-amd64)
- [Skaffold v2.12.0](https://github.com/GoogleContainerTools/skaffold/releases/download/v2.12.0/skaffold-linux-amd64)

## Setup

### Podman

Setup access to local Registry. Create or modify registries.conf:

> vi ~/.config/containers/registries.conf

```
[[registry]]
location="localhost:5001"
insecure=true
```

### Kind

Create new Kind Cluster and expose local Registry on port 5001:
> ./kind-with-registry.sh


### Skaffold

Modify global configuration (or create new config file): $HOME/.skaffold/config and add option to disable Kind loading images using load method:
```
global:  
  kind-disable-load: true
```

## Run example

Run Skaffold to build a new Docker image and deploy the pod to k8s cluster, with command:
> skaffold dev

## Debug example

> skaffold debug