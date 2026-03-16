import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditCategoryAlertDialog extends StatefulWidget {
  const EditCategoryAlertDialog({
    super.key,
    required this.value,
  });

  final String value;

  @override
  State<EditCategoryAlertDialog> createState() => _EditCategoryAlertDialogState();
}

class _EditCategoryAlertDialogState extends State<EditCategoryAlertDialog> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.value = TextEditingValue(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Category'),
      content: TextField(controller: controller),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.pop(controller.text);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}