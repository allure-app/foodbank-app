import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/data/repositories/category_repository.dart';
import 'package:foodbank_app/data/repositories/item_repository.dart';
import 'package:foodbank_app/domain/exceptions/result.dart';
import 'package:foodbank_app/domain/exceptions/validation_exception.dart';
import 'package:foodbank_app/domain/models/category_model.dart';
import 'package:foodbank_app/domain/models/item_model.dart';
import 'package:foodbank_app/ui/core/ui/fb_scaffold.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_view_model.freezed.dart';

final categoriesViewModelProvider = AsyncNotifierProvider(CategoriesViewModel.new);

@freezed
abstract class CategoriesState with _$CategoriesState implements HasIsEmpty {
  factory CategoriesState({
    @Default({}) ValidationErrors validationErrors,
    @Default([]) List<CategoryModel> categories,
  }) = _CategoriesState;

  const CategoriesState._();
  @override bool get isEmpty => categories.isEmpty;
}

class CategoriesViewModel extends AsyncNotifier<CategoriesState> {
  CategoryRepositoryInterface get _categoryRepository => ref.read(categoryRepositoryProvider);
  ItemRepositoryInterface get _itemRepository => ref.read(itemRepositoryProvider);

  @override
  Future<CategoriesState> build() => _load();

  Future<CategoriesState> _load() async {
    final result = await _categoryRepository.getAll();
    return switch (result) {
      Ok<List<CategoryModel>>() => CategoriesState(categories: result.value),
      Err<List<CategoryModel>>() => throw result.error,
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> add(String name) async {
    final category = CategoryModel(id: 0, name: name);
    if (!_validate(category)) {
      return;
    }

    final result = await _categoryRepository.create(category);
    state = switch (result) {
      Ok<CategoryModel>() => AsyncData(state.requireValue.copyWith(
        categories: [...state.requireValue.categories, result.value],
      )),
      Err<CategoryModel>() => throw result.error,
    };
  }

  Future<bool> edit(CategoryModel category) async {
    if (!_validate(category)) {
      return false;
    }

    final result = await _categoryRepository.update(category);

    switch (result) {
      case Ok<None>():
        final categories = List.of(state.requireValue.categories);
        categories[categories.indexWhere((c) => c.id == category.id)] = category;
        state = AsyncData(state.requireValue.copyWith(categories: categories));
      case Err<None>():
        throw result.error;
    }

    return state.error == null;
  }

  Future<ValidationErrors?> delete(int id) async {
    state = AsyncData(state.requireValue.copyWith(validationErrors: {}));
    if (await _doesCategoryHaveItems(id)) {
      return {
        'error': ['Cannot delete categories that have items.'],
      };
    }

    final result = await _categoryRepository.delete(id);
    state = switch (result) {
      Ok<None>() => AsyncData(state.requireValue.copyWith(
        categories: state.requireValue.categories.where((c) => c.id != id).toList(),
      )),
      Err<None>() => throw result.error,
    };

    return null;
  }

  bool _validate(CategoryModel category) {
    state = AsyncData(state.requireValue.copyWith(validationErrors: {}));

    if (category.name.isEmpty || category.name.length > 100) {
      state = AsyncData(state.requireValue.copyWith(validationErrors: {
        'name': ['Must be within 1 and 100 characters.'],
      }));

      return false;
    }

    return true;
  }

  Future<bool> _doesCategoryHaveItems(int categoryId) async {
    final result = await _itemRepository.getAllByCategory(categoryId);

    switch (result) {
      case Ok<List<ItemModel>>():
        return result.value.isNotEmpty;
      case Err<List<ItemModel>>():
        return true; // It failure, it's safer to not allow deletion.
    }
  }
}