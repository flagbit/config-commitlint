# Config Commitlint

This is the configuration to lint our commitmessages at flagbit.
The basic format is simply using [conventionalcommits](https://www.conventionalcommits.org/en/v1.0.0/),
this config is only setting some more precise specifications.

This config is used by a tool named [commitlint](https://commitlint.js.org/#/),
that comes pretty handy to have a clean, readable git-history.

Conventionalcommits in general are giving us 3 important benefits:

1. our git history is clean, readable and informative
2. we can use automatic-semantic-versioning in our projects, the version to
   set is then generated out of the commitmessages. (type and breaking-change)
3. we can generate automated CHANGELOG files in our repositories. These are then
   also generated out of the commitmessages. (type and scope)

## How should a good COMMTIMSG look?

```
fix: Don't use GITHUB_TOKEN for release-please

Because events generated by a GITHUB_TOKEN will not trigger
other workflows.

References: FBTLOPS-159
```

## How can I use this in my project?

Create a new file named `commitlint.config.js` in your projects root directory,
including this content:

```javascript
module.exports = {
  extends: ["@flagbit/config-commitlint"],
  parserPreset: {
    parserOpts: {
      issuePrefixes: ["\\s[\\w\\d]{1,10}-"],
    },
  },
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

## How can I use this locally?

The package holding our config is published to default npm-registry. Because
most of us have set in their `.npmrc` to use our private registry for the
namespace `@flagbit`, it is necessary to tell yarn/npm which registry to use.
You can do like this:

```bash
yarn global add @commitlint/cli @flagbit/config-commitlint --registry https://registry.npmjs.org
```

## How can I get automated SemVer?

coming soon

## How can I get autoamted CHANGELOG?

coming soon
