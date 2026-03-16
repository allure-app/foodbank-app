import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/ui/categories/view_models/categories_view_model.dart';
import 'package:foodbank_app/ui/categories/widgets/create_category_alert_dialog.dart';
import 'package:foodbank_app/ui/categories/widgets/edit_category_alert_dialog.dart';
import 'package:foodbank_app/ui/core/ui/fb_list_view.dart';
import 'package:foodbank_app/ui/core/ui/fb_scaffold.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(categoriesViewModelProvider.notifier);

    return FbScaffold(
      title: 'Categories',
      provider: categoriesViewModelProvider,
      onLoad: notifier.refresh,
      onAdd: () => showDialog(
        context: context,
        builder: (context) => CreateCategoryAlertDialog(onCreate: notifier.add),
      ),
      builder: (state) => FbListView(
        items: state.categories,
        idSelector: (category) => category.id,
        itemBuilder: (_, category) => Text(category.name),
        onEdit: (category) async {
          final name = await showDialog(
            context: context,
            builder: (context) => EditCategoryAlertDialog(value: category.name),
          );

          if (name != null) {
            await notifier.edit(category.copyWith(name: name));
          }
        },
        onDelete: (category) async {
          final errors = await notifier.delete(category.id);
          if (errors != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errors['error']!.join(', ')),
              ));
            });

            return false;
          }

          return true;
        },
      ),
    );
  }
}
