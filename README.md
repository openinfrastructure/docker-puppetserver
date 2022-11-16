# Puppetserver Docker Image

This repository manages the Docker image that we use for spinning up
a Puppetserver instance.

## Building the image

*The make and docker executables must be installed to build the image.*

The [Makefile](./Makefile) includes a `build-image` target that abstracts the
commands necessary to build the image:

```bash
❯ make build-image
Building image for Puppet version ""
docker build \
                --build-arg PUPPET_VERSION= \
                --build-arg PUPPET_VERSION_MAJOR=7 \
                -t oi_puppetserver:1.0.0 .
[+] Building 82.0s (7/7) FINISHED
<...>
```

## Running the container locally

The [Makefile](./Makefile) includes a `docker-run` target that abstracts the
commands necessary to run an instance of the container locally:

```bash
❯ make docker-run
docker run --rm -it \
        -v /Users/glarizza/src/oi/docker-puppetserver:/workspace \
        oi_puppetserver:1.0.0 \
        /bin/bash
root@466439a997b2:/#
```

NOTE: The repository root is mounted at `/workspace` to allow for copying files
to/from the running container.
