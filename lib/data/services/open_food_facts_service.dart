import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final openFoodFactsServiceProvider = Provider((_) {
  return OpenFoodFactsService();
});

abstract class OpenFoodFactsServiceInterface {
  Future<Product?> getProduct(String barcode);
}

class OpenFoodFactsService extends OpenFoodFactsServiceInterface {
  OpenFoodFactsService({this.debounceDuration = const Duration(milliseconds: 500)});

  Timer? _debounce;
  final Duration debounceDuration;
  final Map<String, Product?> _cache = {};

  @override
  Future<Product?> getProduct(String barcode) async {
    if (_cache.containsKey(barcode)) return _cache[barcode];

    // Wait until user stops scanning/typing for 500ms
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    final completer = Completer<Product?>();

    _debounce = Timer(debounceDuration, () async {
      final config = ProductQueryConfiguration(
        barcode,
        version: ProductQueryVersion.v3,
        fields: [ProductField.NAME, ProductField.BRANDS],
        productTypeFilter: ProductTypeFilter.all,
      );

      if (kDebugMode) {
        print('[OpenFoodFacts API] Retreiving product info for $barcode');
      }

      final result = await OpenFoodAPIClient.getProductV3(config);

      if (kDebugMode) {
        print('[OpenFoodFacts API] API response status: ${result.status}');
      }

      if (result.status == ProductResultV3.statusSuccess) {
        _cache[barcode] = result.product;
        completer.complete(result.product);
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }
}