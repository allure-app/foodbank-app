import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/routing/app_router.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Foodbank',
      version: '1.0.0',
      comment: 'talk.with.allure@gmail.com',
    );

    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}