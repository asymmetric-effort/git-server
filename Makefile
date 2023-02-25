DOCKER_HUB:=docker.internal.asymmetric-effort.com
GIT_SERVER_DOCKER_IMAGE_NAME:=asymmetric-effort/git-server:local
GIT_SERVER_DOCKER_CONTAINER_NAME:=git-server
GIT_SERVER_IP_ADDRESS:=10.37.129.2
GIT_SERVER_SSH_PORT:=22
GIT_SERVER_HTTP_PORT:=8888
GIT_SERVER_VOLUME:=$(HOME)/git_server

git_server/help:
	@echo '$@'
	@echo 'make git_server/build     -> build the container locally'
	@echo 'make git_server/upload    -> upload the container to the docker hub (internal only)'
	@echo '                             (this will re-tag the container appropriately)'
	@echo 'make git_server/run       -> run the container from the docker hub'
	@echo 'make git_server/run-local -> run the container locally (for bootstrapping)'
	@echo 'make git_server/logs      -> tail the logs of a running git server'
	@echo 'make git_server/stop      -> stop the git server'
	@exit 0

include Makefile.d/*.mk
