

LOGIN		=	fbelfort

COMPOSE		=	docker compose -f srcs/docker-compose.yaml

ENV			=	./srcs/.env

DATA		=	~/$(LOGIN)/data

DATA_WP		=	$(DATA)/wordpress

DATA_DB		=	$(DATA)/mariadb

all	:	up

$(ENV):
	@echo "ERROR: missing '$@' file\ncheck srcs/env_sample"
	@exit 1

$(DATA_DB):
	@mkdir -p $@

$(DATA_WP):
	@mkdir -p $@

up	:	$(ENV) $(DATA_DB) $(DATA_WP)
	@echo "See the log file for further building information"
	@$(COMPOSE) up -d > log

down:
	@$(COMPOSE) down

clean:
	@rm -f log
	@$(COMPOSE) down --rmi all --volumes --remove-orphans

fclean: clean
	@docker system prune --volumes --all --force
	@sudo rm -rf  $(DATA_DB) $(DATA_WP)

re	: fclean all

.PHONY: all $(DATA_DB) $(DATA_WP) up down clean fclean re