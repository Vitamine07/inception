LOGIN = mbenzira
DATA_PATH = /home/$(LOGIN)/data
COMPOSE_FILE = srcs/docker-compose.yml

all: setup
	docker compose -f $(COMPOSE_FILE) up -d --build

setup:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

re:
	make down
	make all
down:
	docker compose -f $(COMPOSE_FILE) down

clean: down
	docker system prune -a --force

fclean: clean
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/
