import 'package:foodbank_app/ui/categories/widgets/categories_screen.dart';
import 'package:foodbank_app/ui/home/widgets/home_screen.dart';
import 'package:foodbank_app/ui/items/widgets/item_screen.dart';
import 'package:foodbank_app/ui/items/widgets/items_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/';
  static const String categories = '/categories';
  static const String items = '/items';
  static const String itemCreate = '/items/create';
  static String item(int id) => '/items/$id';
  // static const String settings = '/settings';
}

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.categories,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: Routes.items,
      builder: (context, state) => const ItemsScreen(),
    ),
    GoRoute(
      path: Routes.itemCreate,
      builder: (context, state) => const ItemScreen(),
    ),
    GoRoute(
      path: '/items/:id',
      builder: (context, state) => ItemScreen(id: int.parse(state.pathParameters['id'].toString())),
    ),
    // GoRoute(
    //   path: Routes.settings,
    //   builder: (context, state) => const SettingsScreen(),
    // ),
  ],
);