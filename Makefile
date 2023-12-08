.PHONY: all
all:

.PHONY: start
start:
	docker-compose up -d --remove-orphans

.PHONY: stop
stop:
	docker-compose down -v --remove-orphans

.PHONY: shell
shell:
	docker-compose exec -ti master weed shell