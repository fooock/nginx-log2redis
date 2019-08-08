NGINX_BASE_DIR := ./build/nginx

bootstrap:
	./scripts/bootstrap.sh

clear:
	./scripts/clear.sh

start:
	$(NGINX_BASE_DIR)/sbin/nginx

stop:
	kill $$(cat $(NGINX_BASE_DIR)/logs/nginx.pid)
