git_server/initialize:
	@echo "$@ starting"
	mkdir -p $(GIT_SERVER_VOLUME) || true
	@echo "$@ completed"

.$PHONY: git_server/run
REMOTE_IMAGE:=$(DOCKER_HUB)/$(GIT_SERVER_DOCKER_IMAGE_NAME)
git_server/run: git_server/initialize
	@echo "$@ starting."
	docker run -d \
			   --rm \
			   --name $(GIT_SERVER_DOCKER_CONTAINER_NAME) \
			   --publish $(GIT_SERVER_IP_ADDRESS):$(GIT_SERVER_SSH_PORT):22 \
			   --publish $(GIT_SERVER_IP_ADDRESS):$(GIT_SERVER_HTTP_PORT):80 \
			   --volume $(GIT_SERVER_VOLUME):/git/ $(REMOTE_IMAGE) .
	@echo "$@ completed."

.$PHONY: git_server/run/local
LOCAL_IMAGE:=$(GIT_SERVER_DOCKER_IMAGE_NAME)
git_server/run/local: git_server/initialize
	@echo "$@ starting."
	docker run -d \
			   --rm \
			   --name $(GIT_SERVER_DOCKER_CONTAINER_NAME) \
			   --publish $(GIT_SERVER_IP_ADDRESS):$(GIT_SERVER_SSH_PORT):22 \
			   --publish $(GIT_SERVER_IP_ADDRESS):$(GIT_SERVER_HTTP_PORT):80 \
			   --volume $(GIT_SERVER_VOLUME):/git/ $(LOCAL_IMAGE) .
	@echo "$@ completed."
