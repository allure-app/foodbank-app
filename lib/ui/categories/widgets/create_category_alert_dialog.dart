import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateCategoryAlertDialog extends StatefulWidget {
  const CreateCategoryAlertDialog({super.key, required this.onCreate});

  final Function(String name) onCreate;

  @override
  State<CreateCategoryAlertDialog> createState() => _CreateCategoryAlertDialogState();
}

class _CreateCategoryAlertDialogState extends State<CreateCategoryAlertDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Category'),
      content: TextField(controller: controller),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onCreate(controller.text);
            context.pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}