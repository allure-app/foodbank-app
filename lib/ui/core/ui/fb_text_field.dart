import 'package:flutter/material.dart';

class FbTextField extends StatelessWidget {
  const FbTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isLoading = false,
  });

  final TextEditingController controller;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TextField is the base
        TextField(
          controller: controller,
          readOnly: isLoading,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
        ),

        // Loading overlay
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}