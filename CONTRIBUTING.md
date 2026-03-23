# Contributing to cli-utils

## Project Overview

cli-utils is a collection of command-line utilities designed to streamline common development workflows. This project provides modular, composable tools that integrate seamlessly into existing scripts and pipelines.

## How to Add New Utilities

1. **Create a new directory** under `cmd/` with the utility name (e.g., `cmd/myutil/`)
2. **Add a `main.go`** file with the utility implementation
3. **Register the command** in the root `main.go` or cmd root if using subcommands
4. **Add tests** in a corresponding `*_test.go` file
5. **Update README.md** with usage documentation for the new utility

## Testing Approach

- Unit tests are required for all new utilities using Go's standard testing package
- Place tests in the same package as the code they test
- Use table-driven tests where appropriate
- Run tests with: `go test ./...`
- Ensure tests pass before submitting pull requests

## Release Process

1. All changes are submitted via pull requests
2. PRs require at least one review approval before merging
3. Releases are managed through GitHub releases
4. Version bumps follow semantic versioning (MAJOR.MINOR.PATCH)
5. Upon merge to main, a release draft is automatically created
6. Publish the release to trigger package updates