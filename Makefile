repo = tabashir
name = pmwiki
fullname = $(repo)/$(name)
#fullname = "jeffgeiger/centos-pmwiki"
vol_dir = /local/docker/volumes
html_dir = /var/www/html

help: env
	@echo "------ targets ------"
	@echo "make build -- build docker images"
	@echo "make refresh -- build docker images (cached)"
	@echo "make start -- run container"
	@echo "make stop -- stop container"

env:
	@echo "------ current variables ------"
	@echo "repo: $(repo)"
	@echo "name: $(name)"
	@echo "fullname: $(fullname)"
	@echo "vol_dir: $(vol_dir)"
	@echo "html_dir: $(html_dir)"

build:
	docker build --no-cache --rm -t $(fullname) .

refresh:
	docker build -t $(fullname) .

start:
	docker run -d --name $(name) -v $(vol_dir)/pmwiki/pub:$(html_dir)/pub -v $(vol_dir)/pmwiki/local:$(html_dir)/local -v $(vol_dir)/pmwiki/cookbook:$(html_dir)/cookbook -v $(vol_dir)/pmwiki/wiki.d:$(html_dir)/wiki.d -p 50060:80 $(fullname)

stop:
	docker stop HIAWATHA
	docker rm $(docker ps -a -q)

clean:
	-@docker images -q $(fullname) | xargs docker rmi


