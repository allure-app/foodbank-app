import 'package:flutter/material.dart';
import 'package:foodbank_app/ui/barcode/barcode_scanner_screen.dart';

class FbBarcode extends StatefulWidget {
  const FbBarcode({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
  });

  final String label;
  final String? value;
  final Function(String barcode) onChange;

  @override
  State<FbBarcode> createState() => _FbBarcodeState();
}

class _FbBarcodeState extends State<FbBarcode> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(covariant FbBarcode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != controller.text) {
      controller.text = widget.value ?? '';
    }
  }

  Future<void> _scanBarcode() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const BarcodeScannerScreen(),
      ),
    );

    if (result != null) {
      controller.text = result;
      widget.onChange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: _scanBarcode,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        hintText: widget.label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: _scanBarcode,
        ),
      ),
    );
  }
}