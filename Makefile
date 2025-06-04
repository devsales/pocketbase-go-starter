run:
	go run main.go serve

build-ui:
	cd ui && pnpm build

run-ui:
	cd ui && pnpm dev

migrations:
	go run main.go migrate collections

dev:
	make -j2 run run-ui
