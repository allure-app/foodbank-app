generate:
	dart run build_runner build

build-web:
	flutter build web --debug --source-maps --dart-define=Dart2jsOptimization=O0 --base-href /foodbank-app/ -o docs