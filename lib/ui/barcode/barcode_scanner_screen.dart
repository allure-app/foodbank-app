import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin {

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.qrCode,
    ],
  );

  bool _found = false;

  late final AnimationController _laserController;

  @override
  void initState() {
    super.initState();

    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  void _handleBarcode(BarcodeCapture capture) async {
    if (_found) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value != null) {
      _found = true;

      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 120);
      }

      if (mounted) {
        Navigator.pop(context, value);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _laserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const scanSize = 260.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan barcode'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: controller.toggleTorch,
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: controller.switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [

          /// Camera
          MobileScanner(
            controller: controller,
            onDetect: _handleBarcode,
          ),

          /// Scan box
          Center(
            child: Container(
              width: scanSize,
              height: scanSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),

          /// Animated scan laser
          Center(
            child: SizedBox(
              width: scanSize,
              height: scanSize,
              child: AnimatedBuilder(
                animation: _laserController,
                builder: (_, __) {
                  return Align(
                    alignment: Alignment(0, _laserController.value * 2 - 1),
                    child: Container(
                      height: 2,
                      width: scanSize,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            ),
          ),

          /// Instructions
          const Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Align barcode inside the frame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}