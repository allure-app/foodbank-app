import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/data/repositories/category_repository.dart';
import 'package:foodbank_app/data/repositories/item_repository.dart';
import 'package:foodbank_app/domain/exceptions/result.dart';
import 'package:foodbank_app/domain/exceptions/validation_exception.dart';
import 'package:foodbank_app/domain/models/category_model.dart';
import 'package:foodbank_app/domain/models/item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_view_model.freezed.dart';

final itemViewModelProvider =
  AsyncNotifierProvider.family<ItemViewModel, ItemState, int?>(ItemViewModel.new);

@freezed
abstract class ItemState with _$ItemState {
  factory ItemState({
    ItemModel? item,
    @Default([]) List<CategoryModel> categories,
    @Default({}) ValidationErrors validationErrors,
  }) = _ItemState;
}

class ItemViewModel extends AsyncNotifier<ItemState> {
  ItemRepositoryInterface get _itemRepository => ref.read(itemRepositoryProvider);
  CategoryRepositoryInterface get _categoryRepository => ref.read(categoryRepositoryProvider);

  ItemViewModel(int? id) : _id = id;
  final int? _id;

  @override
  Future<ItemState> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<ItemState> _load() async {
    final categoriesResult = await _categoryRepository.getAll();
    final categories = switch (categoriesResult) {
      Ok<List<CategoryModel>>() => categoriesResult.value,
      Err<List<CategoryModel>>() => throw categoriesResult.error,
    };

    if (_id == null) {
      return ItemState(item: null, categories: categories);
    }

    final itemResult = await _itemRepository.getById(_id);
    final item = switch (itemResult) {
      Ok<ItemModel>() => itemResult.value,
      Err<ItemModel>() => throw itemResult.error,
    };

    return ItemState(item: item, categories: categories);
  }

  Future<bool> edit(ItemModel item) async => _saveItem(item);
  Future<bool> add(ItemModel item) async => _saveItem(item, isNew: true);
  Future<bool> _saveItem(ItemModel item, {bool isNew = false}) async {
    if (!_validate(item)) {
      return false;
    }

    final result = isNew
        ? await _itemRepository.create(item)
        : await _itemRepository.update(item);

    return switch (result) {
      Ok<None>() => true,
      Err<None>() => throw result.error,
    };
  }

  bool _validate(ItemModel item) {
    state = AsyncData(state.requireValue.copyWith(validationErrors: {}));
    
    if (item.categoryId == 0) {
      _addValidationError('categoryId', 'Category is compulsory.');
    } else if (state.requireValue.categories.where((c) => c.id == item.categoryId).isEmpty) {
      _addValidationError('categoryId', 'Invalid category.');
    }

    if (item.name.isEmpty || item.name.length > 100) {
      _addValidationError('name', 'Must be between 1 and 100 characters.');
    }

    if (item.brand != null && item.brand!.isNotEmpty && item.brand!.length > 100) {
      _addValidationError('brand', 'Must be between 1 and 100 characters.');
    }

    return state.requireValue.validationErrors.isEmpty;
  }

  void _addValidationError(String key, String message) {
    final errors = ValidationErrors.from(state.requireValue.validationErrors);

    errors.putIfAbsent(key, () => []);
    errors[key] = [...errors[key]!, message];

    state = AsyncData(state.requireValue.copyWith(validationErrors: errors));
  }
}