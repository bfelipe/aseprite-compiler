prepare:
	mkdir aseprite

build-image:
	docker compose build --no-cache

container-up:
	docker compose up

copy-binary:
	docker cp $(shell docker ps -a --filter "name=aseprite-compiler" --format "{{.ID}}"):/aseprite/build/bin/. ./aseprite

install-dependencies:
	sudo apt install libc++-dev libc++abi-dev -y

clean-container:
	docker compose rm aseprite-compiler

clean-image:
	docker image rm $$(docker image ls --format '{{.Repository}}' | grep aseprite) && docker image prune

clean-binary:
	rm -r aseprite/

reset:
	make clean-container
	make clean-image
	make clean-binary

install:
	make prepare
	make build-image
	make container-up
	make copy-binary
	make install-dependencies
	make clean-container
	make clean-image
