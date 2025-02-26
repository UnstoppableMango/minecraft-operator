WORKING_DIR != git rev-parse --show-toplevel
LOCAL_BIN   := ${WORKING_DIR}/bin

DEVCTL ?= ${LOCALBIN}/devctl
DPRINT ?= ${LOCALBIN}/dprint

bin/dprint: .versions/dprint | .make/dprint/install.sh bin
	DPRINT_INSTALL=${CURDIR} .make/dprint/install.sh $(shell $(DEVCTL) v dprint)
	@touch $@

bin/devctl: .versions/devctl | bin
	go install github.com/unmango/devctl/cmd@v$(shell cat $<)
	mv bin/cmd $@
