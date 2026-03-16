import 'package:flutter/material.dart';
import 'package:foodbank_app/ui/core/ui/fb_gap.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required String label,
    required Function() onReload,
  }) : _label = label, _onReload = onReload;

  final String _label;
  final Function() _onReload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('There are no $_label.'),
          Text('Press the add button to create one.'),
          const FbGap(),
          ElevatedButton.icon(
            onPressed: _onReload,
            label: Text('Reload'),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
