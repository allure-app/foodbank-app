generate:
	dart run build_runner build

build-web:
	flutter build web --base-href /foodbank-app/ -o docs