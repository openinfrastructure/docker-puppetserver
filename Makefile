PUPPET_VERSION_MAJOR := 7

DOCKER_IMAGE_NAME := oi_puppetserver
DOCKER_IMAGE_TAG_VERSION := 1.0.0

.PHONY: build-image
build-image:
	$(info Building image for Puppet major version "$(PUPPET_VERSION_MAJOR)")
	docker build \
		--build-arg PUPPET_VERSION=${PUPPET_VERSION} \
		--build-arg PUPPET_VERSION_MAJOR=${PUPPET_VERSION_MAJOR} \
		-t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG_VERSION} .

.PHONY: docker-run
docker-run:
	docker run --rm -it \
	-v $(CURDIR):/workspace \
	${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG_VERSION} \
	/bin/bash
