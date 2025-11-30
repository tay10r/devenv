TAG ?= devenv:1.0
#BUILDX ?= buildx

.PHONY: build
build:
	docker $(BUILDX) build --tag $(TAG) .
	docker volume create devenv_workspaces

.PHONY: run
run:
	#docker run --rm --name devenv --mount type=volume,src=devenv_workspaces,dst=/home/dev/workspaces -p 5500:5500 -it $(TAG)
	docker run --rm --name devenv --mount type=bind,src=$(PWD)/workspaces,dst=/home/dev/workspaces -p 5500:5500 -it $(TAG)
