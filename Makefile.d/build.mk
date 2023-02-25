git_server/build:
	@echo "$@ starting."
	docker build --compress --tag $(GIT_SERVER_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."
