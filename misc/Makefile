.DEFAULT_GOAL := help

.PHONY: all cloc todo help

all:

cloc: # Shows cloc source statistics.-
	@cloc --exclude-dir=client,vendor .

todo: # Shows TODOs
	@grep \
		--exclude-dir=./vendor \
		--exclude-dir=./client/node_modules \
		--text \
		--color \
		-nRo ' TODO:.*' .

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
