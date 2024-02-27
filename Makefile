.DEFAULT_GOAL := lint
GITHUB_BASE_REF ?= master

.PHONY: lint
lint:
	node_modules/.bin/commitlint -g commitlint.config.js --from=$$(git rev-parse remotes/origin/$(GITHUB_BASE_REF))

.PHONY: test
test: test/positive test/negative

.PHONY: test/negative
test/negative:
	podman run --rm \
	  -v $$(pwd)/commitlint.test.config.js:/commitlint.config.js \
	  docker.io/library/node:alpine \
	  npm install --no-audit --no-fund -g @commitlint/cli @flagbit/config-commitlint; echo foo | commitlint || echo success

.PHONY: test/positive
test/positive:
	podman run --rm \
	  -v $$(pwd)/commitlint.test.config.js:/commitlint.config.js \
	  -v $$(pwd)/COMMITMSG:/COMMITMSG \
	  docker.io/library/node:alpine \
	  npm install --no-audit --no-fund -g @commitlint/cli @flagbit/config-commitlint; cat COMMITMSG | commitlint && echo success
