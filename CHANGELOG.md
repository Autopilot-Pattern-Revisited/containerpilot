## 4.0.0 (June 5th, 2026)

This release modernizes the revived ContainerPilot fork after the original
upstream history, while preserving the core runtime behavior.

BREAKING CHANGES:

- Removed the legacy `makefile` build path in favor of direct Go, Docker, and
  GitHub Actions workflows.
- Removed the legacy Drone, Travis CI, direnv, and Nix shell configuration.
- Release artifacts are now produced from `v*` tags by GitHub Actions rather
  than the original release tooling.

FEATURES:

- Added Go module based builds with updated dependencies and static
  `CGO_ENABLED=0` binaries.
- Added YAML configuration support alongside the existing JSON5 configuration
  path, including a YAML fixture test.
- Bundled `consul-template` 0.42.0 into the ContainerPilot binary. Running the
  executable as `consul-template` dispatches to the embedded consul-template
  CLI.
- Added a modern multi-stage Dockerfile that builds ContainerPilot directly and
  embeds `version.GitHash` and `version.Version` from Git metadata. Docker
  builds now use `git describe --tags --always --dirty` with a sensible
  development fallback instead of hard-coded `v0.0.0`.
- Added GitHub Actions CI for linting, unit tests, and integration tests.
- Added GitHub Actions releases for multi-platform GHCR Docker images
  (`linux/amd64`, `linux/arm64`) and static binary archives for `linux/amd64`,
  `linux/arm64`, `darwin/amd64`, and `darwin/arm64`, with SHA256 checksums.

BUG FIXES:

- Fixed discovery test server compatibility with the current retry testing
  interface and ensured it returns a complete HTTP URL.
- Fixed config tests after the configuration format changes.
- Fixed staticcheck findings, including stale compiler directives, deprecated
  random seeding in tests, dynamic printf formatting, and unused
  consul-template wrapper fields.
- Fixed unit test failures under `CGO_ENABLED=0 go test -v ./... -bench .`.
- Fixed JSON5 test coverage by adding a YAML variant.
- Fixed telemetry tests for the current validation behavior.

INFRASTRUCTURE:

- CI now installs the latest Consul release available from HashiCorp releases
  for unit tests and verifies the download with SHA256.
- Integration tests now run only on pushes to `master`.
- Updated integration tests and fixtures for Docker Compose v2 while keeping a
  `docker-compose` compatibility wrapper for existing test scripts.
- Updated integration fixtures to use current base images, including
  `hashicorp/consul:latest` and `node:22-bookworm-slim`.
- Updated the nginx integration fixture to use the bundled ContainerPilot binary
  as both `/bin/containerpilot` and `/bin/consul-template`, removing the old
  external consul-template download.
- Added integration debug log upload in CI.
- Refreshed repository documentation and import paths for the
  `Autopilot-Pattern-Revisited/containerpilot` fork.

## 3.6.2 (Unreleased)

## 3.6.1 (December 7th, 2017)

BUG FIXES:

- Clean-up core signals handler by removing unnecessary cruft (#533)
- Clean-up a few things around global/job shutdown (#533)
- Add optional debug logging of timer/timeout events (#534)
- Prevent overzealous collection of Metric events through Prometheus (#536)
- docs: fix typo in link to job config spec (#537)

SHA1 57857530356708e9e8672d133b3126511fb785ab

## 3.6.0 (November 14th, 2017)

This release adds two major enhancements, upgrades to Go 1.9 and Consul 1.0.0 as
well as signal events.

We've added a new event trigger to ContainerPilot. You can now send a UNIX
signal into a `containerpilot` process and have it trigger a custom job. Signal
based jobs can trigger on either `SIGHUP` or `SIGUSR2`.

FEATURES:

- Upgraded to Go 1.9 for building ContainerPilot (#519)
- Upgraded to Consul 1.0.0 for our testing infrastructure and target Consul
  version (#519)
- Signal events which allow a job to trigger on a UNIX signal (#513)

SHA1 1248784ff475e6fda69ebf7a2136adbfb902f74b

## 3.5.1 (October 19th, 2017)

BUG FIXES:

- Fix a goroutine leak in the signal handler code path (#523)

SHA1 7ee8e59588b6b593325930b0dc18d01f666031d7

## 3.5.0 (October 13th, 2017)

The big change in this release for ContainerPilot is a refactoring of how the
app shuts down. We're now using the Go context package throughout the entire
application. Many of the race conditions and timing issues that occurred on
global shutdown should now be removed.

FEATURES:

- Log the pid of every job in a logger field (#497)

BUG FIXES:

- Refactor away EventHandler into separate pub/sub interfaces (#476)
- Migrate from deprecated Consul API call PassTTL to UpdateTTL (#515)

SHA1 f06b2e8398f83ee860a73c207354b75758e3e3ac

## 3.4.3 (September 25th, 2017)

FEATURES:

- add Jobs to status endpoint (#507)

BUG FIXES:

- cleanup test assert.Equal argument order (#509)
- fix lint and support go 1.9 (#507)
- enter/exit maintenance events should also trigger job start (#501)
- Fix join (#495)

SHA1 e8258ed166bcb3de3e06638936dcc2cae32c7c58

## 3.4.2 (August 23rd, 2017)

BUG FIXES:

- split SIGCHLD from all other signal handlers in supervisor (#493)

SHA1 5c99ae9ede01e8fcb9b027b5b3cb0cfd8c0b8b88

## 3.4.1 (August 21st, 2017)

BUG FIXES:

- move defer out of loop so as not to leak a closure (#488)

SHA1 4d13cfb345de86135ab2271b77516c6b6a7bed3a

## 3.4.0 (August 18, 2017)

FEATURES:

- config: Introduce logging to file w/ log file re-open on SIGUSR1 (#477)
- add raw logging field to bypass logger for exec (#462)

BUG FIXES:

- control: HTTPServer should handle existing control socket files (#480)
- docs: Better language around `stopTimeout` (#479)
- fix GOOS setting in makefile (#483)
- discovery: fix tls config for Consul (#481)
- default restarts to "unlimited" when when->interval is set (#473)
- docs: add pointers to godoc (#475)

SHA1 ff14bfc9f6b7a10654b0c8777175c2b0436575aa

## 3.3.4 (August 9, 2017)

BUG FIXES:

* fix race that can sometimes cause deadlock during reload/shutdown with larger numbers of jobs (#468) (#469)

SHA1 806f28a25a06acdbcfa8940c8968d5f8e20a2c4f

## 3.3.3 (August 8, 2017)

BUG FIXES:

- make sure jobs configured for stopping/stopped exit on shutdown/reload (#465) (#466)

SHA1 8d680939a8a5c8b27e764d55a78f5e3ae7b42ef4

## 3.3.2 (August 2, 2017)

BUG FIXES:

- Fix when->timeout canceling running jobs (#456) (#458)

SHA1 056d45f728e9b9c61793d6f994da291d5eebeabd

## 3.3.1 (July 31, 2017)

BUG FIXES:

- fixed bug where `/status` always reported job as "unknown" status (#445) (#450)
- fixed bug where job exec was getting `SIGKILL` instead of `SIGTERM` on ContainerPilot stop (#448) (#449)
- fixed bug where supervisor's `SIGCHLD` handler could block `SIGTERM`/`SIGINT` handlers

SHA1 e27c1b9cd1023e622f77bb19914606dee3c9b22c

## 2.7.7 (July 31, 2017)

BUG FIXES:

- Backport supervisor process to v2 to avoid race in zombie cleanup after timeout (#447) (#452)

SHA1 030f1e54a43a842d38b30373f8847132a9771829

## 3.3.0 (July 19, 2017)

BUG FIXES:

- move child reaping into supervisor process (#439) (#440)
- bugfix for catching another when event stopping the running job (#417) (#438)
