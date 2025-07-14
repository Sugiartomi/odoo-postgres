DOCKER = docker
COMPOSE = ${DOCKER} compose
CONTAINER_ODOO = odoo-2
CONTAINER_DB = odoo-postgres-2
ODOO_DB_NAME = odoo-project-postgres
DB_PASSWORD = odoo
DB_USERNAME = odoo

help:
	@echo "Available targets"
	@echo "start - start with daemon"
	@echo "stop - stop the compose"
	@echo "restart - restart the compose"
	@echo "console - odoo interactive console"
	@echo "psql - postgress interactive shell"
	@echo "logs odoo - logs the odoo container"
	@echo "logs db - logs the postgress container"

start:
	$(COMPOSE) up -d
stop:
	$(COMPOSE) down
restart:
	$(COMPOSE) restart
console:
	$(DOCKER) exec -it $(CONTAINER_ODOO) odoo shell --db_host=$(CONTAINER_DB) -d $(ODOO_DB_NAME) -r $(DB_USERNAME) -w $(DB_PASSWORD)
psql:
	$(DOCKER) exec -it $(CONTAINER_DB) psql -U $(DB_USERNAME) -d $(ODOO_DB_NAME)

define log_target
	@if [ "$(1)" = "odoo" ]; then \
		$(COMPOSE) logs -f $(CONTAINER_ODOO); \
	elif [ "$(1)" = "db" ]; then \
		$(COMPOSE) logs -f $(CONTAINER_ODOO); \
	else \
		echo "Invalid logs target."; \
	fi
endef

logs:
	$(call log_target,$(word 2,$(MAKECMDGOALS)))

.PHONY: start stop restart console psql logs

