generate:
	dart run build_runner build

build-web:
	flutter build web --profile --source-maps --base-href /foodbank-app/ -o docs