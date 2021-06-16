# Config Commitlint

Commitlint configuration used at flagbit

## How can I use this in my project?

Create a new file named `commitlint.config.js` in your projects root directory,
including this content:

```javascript
module.exports = {
  extends: ["@flagbit/config-commitlint"],
};
```

...add (or extend an existing) Makefile to include a `lint` target:

```makefile
.DEFAULT_GOAL := lint
GITHUB_BASE_REF ?= master

.PHONY: lint
lint:
	commitlint -g commitlint.config.js --from=$$(git rev-parse remotes/origin/$(GITHUB_BASE_REF))
```

...and finally add a github-workflow to your project by placing a file named
`commitlint.yml` to the `.github/workflows/`-directory in your project. If this
directory is not existing, then you can simply create it. The `commitlint.yml`
needs to include this content:

```yml
name: commitlint
on: pull_request

jobs:
  commitlint:
    name: Lint Commit Messages
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - run: |
          yarn global add @commitlint/cli @flagbit/config-commitlint 
          echo "$(yarn global bin)" >> $GITHUB_PATH
      - run: make lint
```
