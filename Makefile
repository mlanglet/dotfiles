.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install:
	./install.sh

update: 
	./update.sh

sync: update
	./sync.sh

.PHONY: all install update sync
