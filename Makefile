# vim: noexpandtab filetype=make
SHELL:=/usr/bin/env bash
ORG:=jwmarshall
NAME:=shackle
DOCKER:=docker
PUSH:=false

# HAHA! I lied there is a default task!
default:
	@echo "Please read Makefile, there is no default task!"

all: image test

image:
	$(DOCKER) build -t $(ORG)/$(NAME) .

test: image
	$(DOCKER) run -it --rm $(ORG)/$(NAME) bash -c "/run.sh & dig @localhost test.example.com | grep -q 127.0.99.1"
