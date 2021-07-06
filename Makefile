.DEFAULT_GOAL := lint
GITHUB_BASE_REF ?= master

.PHONY: lint
lint:
	node_modules/.bin/commitlint -g commitlint.config.js --from=$$(git rev-parse remotes/origin/$(GITHUB_BASE_REF))
