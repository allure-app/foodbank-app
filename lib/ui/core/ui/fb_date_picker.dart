import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FbDatePicker extends StatefulWidget {
  const FbDatePicker({
    super.key,
    required this.label,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.value,
    required this.onSelect,
  });

  final String label;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final DateTime? value;
  final Function(DateTime) onSelect;

  @override
  State<FbDatePicker> createState() => _FbDatePickerState();
}

class _FbDatePickerState extends State<FbDatePicker> {
  final controller = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!maskFormatter.isFill()) return;

      final text = controller.text;
      final date = _tryParse(text);
      if (date == null) return;

      if (date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate)) {
        return;
      }

      widget.onSelect(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.value = TextEditingValue(text: _format(widget.value));

    return TextField(
      controller: controller,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.label,
        hintText: 'dd/mm/yyyy',
      ),
    );
  }

  String _format(DateTime? date) {
    if (date == null) return '';

    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString().padLeft(4, '0');

    return '$d/$m/$y';
  }

  DateTime? _tryParse(String text) {
    try {
      final parts = text.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final date = DateTime(year, month, day);

      if (date.day != day || date.month != month || date.year != year) {
        return null;
      }

      return date;
    } catch (_) {
      return null;
    }
  }
}
