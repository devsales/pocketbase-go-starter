run:
	go run main.go serve

build-ui:
	cd ui && pnpm build

run-ui:
	cd ui && pnpm dev

migrations:
	go run main.go migrate collections

# run air to detect any go file changes to re-build and re-run the server.
serve:
	go run github.com/air-verse/air@v1.61.7 serve --dev

# run tailwindcss to generate the styles.css bundle in watch mode.
watch-tailwind:
	bunx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/style.css --minify --watch=always

dev:
	make -j2 serve watch-tailwind
