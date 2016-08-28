repo = tabashir
name = pmwiki
fullname = $(repo)/$(name)
vol_dir = /local/docker/volumes/pmwiki
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
	docker run -d --name $(name) -v $(vol_dir)/pub:$(html_dir)/pub -v $(vol_dir)/local:$(html_dir)/local -v $(vol_dir)/cookbook:$(html_dir)/cookbook -v $(vol_dir)/wiki.d:$(html_dir)/wiki.d -p 50060:80 $(fullname)

stop:
	docker stop $(name)
	docker ps -aqf "ancestor=$(fullname)" | xargs --no-run-if-empty docker rm

clean:
	docker images -q $(fullname) | xargs --no-run-if-empty docker rmi


