import 'package:flutter/material.dart';
import 'package:foodbank_app/domain/exceptions/validation_exception.dart';

class FbError extends StatelessWidget {
  const FbError({super.key, required this.field, required this.errors});

  final String field;
  final ValidationErrors errors;

  @override
  Widget build(BuildContext context) {
    if (!errors.containsKey(field)) {
      return SizedBox.shrink();
    }

    final colours = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...errors[field]!.map((message) {
            return Text(message, style: TextStyle(color: colours.error, fontSize: 12.0));
          }),
        ],
      ),
    );
  }
}
