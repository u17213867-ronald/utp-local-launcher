.DEFAULT_GOAL := help
.PHONY : resources

include .env

# Variables

BRANCH ?= develop


# Build Section

build-project: ##@Build Build specific project  PROJECT=utp-microservice-advertisement
	cd $(PROJECT_PATH)$(PROJECT) && \
	make build && \
	make install || echo "Skipping make install because it is not found" && \
	make migrate APP_ENV=local || echo "Skipping make migrate because it is not found" 

build: ##@Build Build all projects
	@make build-project PROJECT=utp-microservice-advertisement
	@make build-project PROJECT=utp-web

# Update Section

update-project: ##@Update Update specific project and set branch  PROJECT=neoauto-microservice-activities BRACH=develop
	cd $(PROJECT_PATH)$(PROJECT) && \
	git stash -u && \
	git fetch origin && \
	git checkout $(BRANCH) && \
	git pull origin $(BRANCH) && \
	make sync-container-config ENV=local CONFIG_PATH=dev ACCOUNT_ENV=dev && \
	make migrate || echo "Skipping make migrate because it is not found"

update: ##@Update Update all projects
	@make update-project PROJECT=utp-local-infrastructure
	@make update-project PROJECT=utp-microservice-advertisement
	@make update-project PROJECT=utp-solr
	@make update-project PROJECT=utp-web


# Start Section

start-project: ##@Start Start specific project
	@cd $(PROJECT_PATH)$(PROJECT) && \
	make up

start-infrastructure: ##@Start Start local infrastructure
	@make start-project PROJECT=utp-local-infraestructure

start-services: ##@Start Start all services
	@make start-project PROJECT=utp-microservice-advertisement

start-portal: ##@Start Start portal
	@make start-project PROJECT=utp-web

solr-data-import: ##@Start Run Solr data import
	cd $(PROJECT_PATH)utp-solr && \
	make data-import-run 

up: ##@Global Start all containers
	@make start-infrastructure
	@make start-services
	@make start-portal
	@make solr-data-import

down: ##@Global Stop all containers
	@docker rm -f $(shell docker ps -aq)

# Help Section

GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "Usage: make [target]\n\n"; \
	for (sort keys %help) { \
		print "${WHITE}$$_:$(RESET)\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = " " x (32 - length $$_->[0]); \
			print "  ${YELLOW}$$_->[0]$(RESET)$$sep${GREEN}$$_->[1]$(RESET)\n"; \
		}; \
		print "\n"; \
	}

help:
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
