WORKING_DIR != git rev-parse --show-toplevel
LOCAL_BIN   := ${WORKING_DIR}/bin

DEVCTL ?= ${LOCALBIN}/devctl
DPRINT ?= ${LOCALBIN}/dprint

BUN := bun --cwd packages/ui

start-ui:
	$(BUN) start

dev-ui:
	$(BUN) dev

docker-build-ui:
	docker build packages/ui -t minecraft-operator-ui:latest

bin/dprint: .versions/dprint | .make/dprint/install.sh bin
	DPRINT_INSTALL=${CURDIR} .make/dprint/install.sh $(shell $(DEVCTL) v dprint)
	@touch $@

bin/devctl: .versions/devctl | bin
	go install github.com/unmango/devctl/cmd@v$(shell cat $<)
	mv bin/cmd $@
