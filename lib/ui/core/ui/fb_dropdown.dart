import 'package:flutter/material.dart';

class DropdownOption {
  const DropdownOption(this.id, this.label);
  final int id;
  final String label;
}

class FbDropdown extends StatelessWidget {
  const FbDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.onSelect,
    required this.value,
  });

  final String label;
  final List<DropdownOption> options;
  final Function(int) onSelect;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton(
          hint: Text('Select an option'),
          isExpanded: true,
          items: options.map((o) => DropdownMenuItem<int>(
              value: o.id, child: Text(o.label))).toList(growable: false),
          onChanged: (id) => onSelect(id!),
          value: value,
        ),
      ],
    );
  }
}