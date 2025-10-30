BRANCH ?= main

.PHONY: sync upstream rebase

upstream:
	bash scripts/update-upstream.sh

rebase: upstream
	bash scripts/rebase-on-upstream.sh $(BRANCH)

sync: upstream rebase
	bash scripts/sync-and-push.sh $(BRANCH)
