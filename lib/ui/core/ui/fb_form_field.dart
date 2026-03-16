import 'package:flutter/material.dart';
import 'package:foodbank_app/domain/exceptions/validation_exception.dart';
import 'package:foodbank_app/ui/core/ui/fb_error.dart';
import 'package:foodbank_app/ui/core/ui/fb_gap.dart';

class FbFormField<T> extends StatelessWidget {
  const FbFormField({
    super.key,
    required this.field,
    required this.fieldKey,
    required this.errors,
  });

  final Widget field;
  final String fieldKey;
  final ValidationErrors errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        field,
        FbError(field: fieldKey, errors: errors),
        const FbGap(),
      ],
    );
  }
}