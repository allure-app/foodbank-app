import 'package:flutter/material.dart';
import 'package:foodbank_app/routing/app_router.dart';
import 'package:foodbank_app/ui/core/ui/fb_gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Bank')),
      body: SafeArea(
        child: ListView(
          children: [
            _PageTile(route: Routes.categories, label: 'Categories', icon: Icons.category),
            _PageTile(route: Routes.items, label: 'Items', icon: Icons.inventory),
            // _PageTile(route: Routes.settings, label: 'Settings', icon: Icons.settings),
          ],
        ),
      ),
    );
  }
}

class _PageTile extends StatelessWidget {
  const _PageTile({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const FbGap(direction: Direction.horizontal),
          Text(label),
        ],
      ),
      onTap: () => context.push(route),
    );
  }
}

