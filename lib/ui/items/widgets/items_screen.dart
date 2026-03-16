import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/routing/app_router.dart';
import 'package:foodbank_app/ui/core/ui/fb_list_view.dart';
import 'package:foodbank_app/ui/core/ui/fb_scaffold.dart';
import 'package:foodbank_app/ui/items/view_models/items_view_model.dart';
import 'package:go_router/go_router.dart';

class ItemsScreen extends ConsumerStatefulWidget {
  const ItemsScreen({super.key});

  @override
  ConsumerState<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends ConsumerState<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(itemsViewModelProvider.notifier);

    return FbScaffold(
      title: 'Items',
      provider: itemsViewModelProvider,
      onAdd: () async => await context.push(Routes.itemCreate),
      onLoad: () => notifier.refresh(),
      builder: (items) => FbListView(
        items: items,
        idSelector: (item) => item.id,
        itemBuilder: (_, item) => Text(item.name),
        onEdit: (item) async {
          await context.push(Routes.item(item.id));
          await notifier.refresh();
        },
        onDelete: (item) async => await notifier.delete(item.id),
      ),
    );
  }
}
