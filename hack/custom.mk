_ != mkdir -p .make

WORKING_DIR != git rev-parse --show-toplevel
LOCAL_BIN   := ${WORKING_DIR}/bin

DEVCTL ?= ${LOCAL_BIN}/devctl
DPRINT ?= ${LOCAL_BIN}/dprint
BUN    := bun

UI_PATH := packages/ui

start-ui:
	$(BUN) --cwd ${UI_PATH} start

dev-ui:
	$(BUN) --cwd ${UI_PATH} dev

docker-build-ui:
	docker build ${UI_PATH} -t minecraft-operator-ui:latest

bin/dprint: .versions/dprint | .make/dprint/install.sh bin
	DPRINT_INSTALL=${CURDIR} .make/dprint/install.sh $(shell $(DEVCTL) v dprint)
	@touch $@

bin/devctl: .versions/devctl | bin
	GOBIN=${LOCAL_BIN} go install github.com/unmango/devctl/cmd@v$(shell cat $<)
	mv bin/cmd $@

.envrc: hack/example.envrc
	cp $< $@

.make/bun-install: ${UI_PATH}/package.json ${UI_PATH}/bun.lock $(shell $(DEVCTL) list --ts)
	$(BUN) install --cwd ${UI_PATH}
	@touch $@
