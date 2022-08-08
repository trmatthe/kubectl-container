# vim: filetype=make

export APP  := trmatthe/kubectl

.DEFAULT_GOAL := build

askver:
	curl -sL  --fail "https://hub.docker.com/v2/repositories/${APP}/tags/?page_size=1000" | jq '.results | .[] | .name'

build:
	@echo 'building $(APP)'
	docker build -t $(APP) .

push:
	@echo 'pushing $(APP) to docker hub'
	docker tag $(APP) $(APP):latest
	docker push $(APP):latest

all: build push
	@echo 'building and pushing $(APP) as :latest'

