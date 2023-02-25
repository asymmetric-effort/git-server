Asymmetric-Effort/Bootstrap/Git-Server
======================================
(c) 2023 Sam Caldwell. See LICENSE.txt

## Objective:

  * **MVP**: Establish an internal git repository which is accessible via SSH
    using key-based authentication.
 
  * **ITERATION**: Ensure that a user can view the code and other content of
    a git repository via HTTP for any repository in this internal git server.

  * **ITERATION**: Implement githooks which will execute linters, build jobs
    and other automation.

  * **ITERATION**: Implement HA replication and fail-over between svr00 and
    svr01.

## Caveat:

  * By default, data is stored at `$(HOME)/git_server/` where
    home is the home directory of the user running the docker
    container

## References

  * see [Git-SCM](
    https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols).
    This material is the source used to create this project, specifically
    chapter 4.

  * The `git-tools` repository contains tools that make `git-server`
    easier to use with custom `git` scripts for `git create`, 
    `git use`, `git list` and `git delete`.

## Building Container
To build the container...
  1. Clone this repo
  2. Navigate to the directory
  3. Run `make git_server/build`

## To Run Local Container
To run this locally (e.g. bootstrapping an environment):
  1. Build the container locally (see above).
  2. Run `make git_server/run_local`

## To Upload the Image
To upload the container image:
  1. Build the container (see above)
  2. Run `make git_server/upload`

  > Disclaimer: This currently is not implemented and
    by design it will only upload to my local docker hub.

## Stop Services
To stop the git server, run `make git_server/stop`

## Tailing logs of running services
To tail the logs, run `make git_server/logs`
