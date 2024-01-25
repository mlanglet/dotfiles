.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install:
	./scripts/install.sh

update: 
	./scripts/update.sh

sync: update
	./scripts/sync.sh

.PHONY: all install update sync
