_ != mkdir -p .make

WORKING_DIR != git rev-parse --show-toplevel
LOCAL_BIN   := ${WORKING_DIR}/bin

DEVCTL ?= ${LOCAL_BIN}/devctl
DPRINT ?= ${LOCAL_BIN}/dprint
BUN    := bun

UI_PATH := packages/ui
UI_IMG  ?= ui:latest

start-ui:
	$(BUN) --cwd ${UI_PATH} start

dev-ui:
	$(BUN) --cwd ${UI_PATH} dev

test-ui:
	$(BUN) test --cwd ${UI_PATH}

docker-build-ui:
	${CONTAINER_TOOL} build ${UI_PATH} -t ${UI_IMG}

docker-push-ui:
	${CONTAINER_TOOL} build ${UI_PATH} -t ${UI_IMG}

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
