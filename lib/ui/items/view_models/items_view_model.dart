import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodbank_app/data/repositories/item_repository.dart';
import 'package:foodbank_app/domain/exceptions/result.dart';
import 'package:foodbank_app/domain/models/item_model.dart';

final itemsViewModelProvider = AsyncNotifierProvider(ItemsViewModel.new);

class ItemsViewModel extends AsyncNotifier<List<ItemModel>> {
  ItemRepositoryInterface get _itemRepository => ref.read(itemRepositoryProvider);

  @override
  Future<List<ItemModel>> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<ItemModel>> _load() async {
    final result = await _itemRepository.getAll();
    return switch (result) {
      Ok<List<ItemModel>>() => result.value,
      Err<List<ItemModel>>() => throw result.error,
    };
  }

  Future<bool> delete(int id) async {
    final result = await _itemRepository.delete(id);
    switch (result) {
      case Ok<None>():
        state = AsyncData(state.requireValue.where((i) => i.id != id).toList());
        return true;
      case Err<None>():
        state = AsyncError(result.error, StackTrace.empty);
        return false;
    }
  }
}