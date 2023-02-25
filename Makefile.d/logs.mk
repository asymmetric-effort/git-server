git_server/logs:
	@echo "$@ starting..."
	docker logs -f $(GIT_SERVER_DOCKER_CONTAINER_NAME)