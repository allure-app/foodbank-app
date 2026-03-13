import 'package:flutter/material.dart';
import 'package:foodbank_app/core/widgets/fb_scaffold.dart';

class ItemView extends StatelessWidget {
  const ItemView({ super.key, required this.id });

  final int id;

  @override
  Widget build(BuildContext context) {
    return FbScaffold(
      title: 'Item',
      body: const Placeholder(),
    );
  }
}
