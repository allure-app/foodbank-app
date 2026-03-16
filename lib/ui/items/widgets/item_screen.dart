import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/data/services/open_food_facts_service.dart';
import 'package:foodbank_app/domain/models/item_model.dart';
import 'package:foodbank_app/ui/core/ui/fb_barcode.dart';
import 'package:foodbank_app/ui/core/ui/fb_date_picker.dart';
import 'package:foodbank_app/ui/core/ui/fb_dropdown.dart';
import 'package:foodbank_app/ui/core/ui/fb_form_field.dart';
import 'package:foodbank_app/ui/core/ui/fb_scaffold.dart';
import 'package:foodbank_app/ui/core/ui/fb_text_field.dart';
import 'package:foodbank_app/ui/items/view_models/item_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ItemScreen extends ConsumerStatefulWidget {
  const ItemScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends ConsumerState<ItemScreen> {
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  int? categoryId;
  DateTime addedAt = DateTime.now();
  DateTime? expiresAt;
  String? barcode;
  bool _loadingProduct = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(itemViewModelProvider(widget.id).notifier);
    ref.watch(itemViewModelProvider(widget.id)).whenData((_) => _load());

    return FbScaffold(
      title: 'Item',
      provider: itemViewModelProvider(widget.id),
      onLoad: () async {
        await notifier.refresh();
        _load();
      },
      builder: (state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FbFormField(
                fieldKey: 'name',
                field: FbTextField(controller: nameController, label: 'Name', isLoading: _loadingProduct),
                errors: state.validationErrors,
              ),
              FbFormField(
                fieldKey: 'brand',
                field: FbTextField(controller: brandController, label: 'Brand', isLoading: _loadingProduct),
                errors: state.validationErrors,
              ),
              FbFormField(
                fieldKey: 'categoryId',
                field: FbDropdown(
                  label: 'Category',
                  options: state.categories.map((c) => DropdownOption(c.id, c.name)).toList(growable: false),
                  onSelect: (selectedId) => setState(() => categoryId = selectedId),
                  value: categoryId,
                ),
                errors: state.validationErrors,
              ),
              FbFormField(
                fieldKey: 'barcode',
                field: FbBarcode(
                  label: 'Barcode',
                  value: barcode,
                  onChange: (value) async {
                    setState(() {
                      barcode = value;
                      _loadingProduct = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Loading product information, please wait...'),
                    ));

                    final openFoodFactsService = ref.read(openFoodFactsServiceProvider);
                    final product = await openFoodFactsService.getProduct(value);

                    if (product != null) {
                      setState(() {
                        nameController.value = TextEditingValue(
                          text: product.getBestProductName(OpenFoodFactsLanguage.ENGLISH),
                        );

                        brandController.value = TextEditingValue(
                          text: product.getFirstBrand() ?? '',
                        );

                        _loadingProduct = false;
                      });
                    }
                  },
                ),
                errors: state.validationErrors,
              ),
              FbFormField(
                fieldKey: 'addedAt',
                field: FbDatePicker(
                  label: 'Purchase Date',
                  firstDate: DateTime.now().subtract(Duration(days: 7)),
                  lastDate: DateTime.now(),
                  initialDate: addedAt,
                  value: addedAt,
                  onSelect: (date) => setState(() => addedAt = date),
                ),
                errors: state.validationErrors,
              ),
              FbFormField(
                fieldKey: 'expiresAt',
                field: FbDatePicker(
                  label: 'Expiry Date',
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 1825)),
                  initialDate: expiresAt,
                  value: expiresAt,
                  onSelect: (date) => setState(() => expiresAt = date),
                ),
                errors: state.validationErrors,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final item = ItemModel(
                      id: widget.id ?? 0,
                      categoryId: categoryId ?? 0,
                      barcode: barcode,
                      name: nameController.text,
                      brand: brandController.text,
                      addedAt: addedAt,
                      expiresAt: expiresAt,
                    );

                    bool success;

                    if (widget.id == null) {
                      success = await notifier.add(item);
                    } else {
                      success = await notifier.edit(item);
                    }

                    if (success) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.pop();
                      });
                    }
                  },
                  child: Text(widget.id == null ? 'Add' : 'Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _load() async {
    final state = ref.watch(itemViewModelProvider(widget.id));

    if (widget.id != null) {
      if (state.requireValue.item != null) {
        final item = state.requireValue.item as ItemModel;
        setState(() {
          nameController.value = TextEditingValue(text: item.name);
          brandController.value = TextEditingValue(text: item.brand ?? '');
          barcode = item.barcode;
          categoryId = item.categoryId;
          addedAt = item.addedAt;
          expiresAt = item.expiresAt;
        });
      }
    }
  }
}

