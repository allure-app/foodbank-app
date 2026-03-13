import 'package:foodbank_app/domains/categories/views/categories_view.dart';
import 'package:foodbank_app/domains/dashboard/dashboard_view.dart';
import 'package:foodbank_app/domains/items/views/item_view.dart';
import 'package:foodbank_app/domains/items/views/items_view.dart';
import 'package:foodbank_app/domains/settings/views/settings_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String dashboard = '/';
  static const String categories = '/categories';
  static const String items = '/items';
  static String item(int id) => '/items/$id';
  static const String settings = '/settings';
}

final router = GoRouter(
  initialLocation: Routes.dashboard,
  routes: [
    GoRoute(
      path: Routes.dashboard,
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: Routes.categories,
      builder: (context, state) => const CategoriesView(),
    ),
    GoRoute(
      path: Routes.items,
      builder: (context, state) => const ItemsView(),
    ),
    GoRoute(
      path: '/items/:id',
      builder: (context, state) => ItemView(id: state.pathParameters['id'] as int),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsView(),
    ),
  ],
);