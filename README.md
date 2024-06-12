# Skaffold - using Podman and Kind

This is an example of running Skaffold with only rootless Podman and Kind (no Docker client or server is required), using local registry also deployed in Kind.

## Test environment
- Ubuntu 24.04 or MacOS Sonoma (14)
- Podman >=v4.9.3 (rootless)
- [Kind v0.23.0](https://github.com/kubernetes-sigs/kind/releases/tag/v0.23.0)
- [Skaffold v2.12.0](https://github.com/GoogleContainerTools/skaffold/releases/tag/v2.12.0)

## Setup

### Podman

Setup access to local Registry. Create or modify registries.conf:

> vi $HOME/.config/containers/registries.conf

```
[[registry]]
location="localhost:5001"
insecure=true
```

**For MacOS**

Follow the instructions in Podman Desktop for Mac:
https://podman-desktop.io/docs/containers/registries#setting-up-a-registry-with-an-insecure-certificate

Start the Podman Machine.

### Kind

Be sure to delete existing Kind Cluster and Kind Registry:
```
> kind delete cluster
> podman rm kind-registry
```

Create new Kind Cluster and expose local Registry on port 5001:
> ./kind-with-registry.sh

### Skaffold (optional step)

Modify global configuration (or create new config file): `$HOME/.skaffold/config` and add option to disable Kind loading images using load method:
```
global:  
  kind-disable-load: true
```

## Run example

Run Skaffold to build a new Docker image and deploy the pod to k8s cluster, with command:
> skaffold dev

## Debug example

> skaffold debug


## Additional notes

When rebooted, podman will stop all containers. In order to run skaffold commands again, just start the two containers:
```
> podman start kind-registry
> podman start kind-control-plane
```