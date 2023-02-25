git_server/stop:
	@echo "$@ running"
	docker kill $(GIT_SERVER_DOCKER_CONTAINER_NAME)
	@echo "$@ done"