# config-commitlint

> Shared commitlint configuration for Flagbit projects. Published to npm as `@flagbit/config-commitlint`, it extends `@commitlint/config-conventional` with stricter rules (sentence-case body/subject, mandatory references, 72-char line limits, enforced type enum).

## Tech Stack
- Node.js, plain CommonJS (`index.js`)
- `@commitlint/cli` ^12, `@commitlint/config-conventional` ^12

## Repository Structure
- `index.js` — the exported commitlint rule set (the package's main entry)
- `commitlint.config.js` — local config used to lint this repo's own commits (extends `index.js`, adds Jira issue-prefix parser)
- `Makefile` — single `lint` target for CI and local use

## Build / Test / Lint

```bash
# Install dependencies
npm ci           # or: yarn

# Lint commits since origin/master (default)
make lint

# Lint commits since a specific base
GITHUB_BASE_REF=main make lint
```

`make lint` runs `commitlint` against all commits from `origin/$GITHUB_BASE_REF` to `HEAD`.

## Conventions
- Conventional Commits enforced by this package's own rules
- Releases are automated via `release-please` on push to `master`; merging a release PR triggers `npm publish --access public`
- Do **not** write commits with `chore: release` as the subject — they are intentionally ignored by commitlint
- References footer is **required** in every commit (e.g. `References: IS-123`)

## Gotchas / Notes
- Local install: if your `.npmrc` routes `@flagbit` to a private registry, install with `--registry https://registry.npmjs.org` to pull from npm
- `header-min-length: 30` — subjects shorter than 30 characters will fail linting
