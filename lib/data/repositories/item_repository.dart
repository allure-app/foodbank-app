import 'package:drift/drift.dart';
import 'package:foodbank_app/data/models/schema.dart';
import 'package:foodbank_app/domain/exceptions/not_found_exception.dart';
import 'package:foodbank_app/domain/exceptions/result.dart';
import 'package:foodbank_app/domain/exceptions/server_exception.dart';
import 'package:foodbank_app/domain/models/item_model.dart';
import 'package:riverpod/riverpod.dart';

final itemRepositoryProvider = Provider((ref) {
  return ItemRepository(db: ref.read(databaseProvider));
});

abstract class ItemRepositoryInterface {
  Future<Result<List<ItemModel>>> getAllByCategory(int categoryId);
  Future<Result<List<ItemModel>>> getAll();
  Future<Result<ItemModel>> getById(int id);
  Future<Result<None>> create(ItemModel item);
  Future<Result<None>> update(ItemModel item);
  Future<Result<None>> delete(int id);
}

class ItemRepository implements ItemRepositoryInterface {
  const ItemRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  @override
  Future<Result<List<ItemModel>>> getAllByCategory(int categoryId) async {
    try {
      final items = await (_db.select(_db.item)
        ..where((i) => i.categoryId.equals(categoryId)))
          .get();

      return Ok(items.map(ItemModel.fromEntity).toList(growable: true));
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<List<ItemModel>>> getAll() async {
    try {
      final items = await (_db.select(_db.item)).get();
      return Ok(items.map(ItemModel.fromEntity).toList(growable: true));
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<ItemModel>> getById(int id) async {
    try {
      final item = await (_db.select(_db.item)
        ..where((i) => i.id.equals(id)))
          .getSingleOrNull();

      if (item == null) {
        return Err(NotFoundException());
      }

      return Ok(ItemModel.fromEntity(item));
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<None>> create(ItemModel item) async {
    try {
      await (_db.into(_db.item).insert(ItemCompanion.insert(
        categoryId: item.categoryId,
        name: item.name,
        brand: Value(item.brand),
        addedAt: item.addedAt,
        expiresAt: Value(item.expiresAt),
      )));

      return Ok(const None());
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<None>> update(ItemModel item) async {
    try {
      final rows = await (_db.update(_db.item)
        ..where((i) => i.id.equals(item.id)))
          .write(ItemCompanion(
            id: Value(item.id),
            categoryId: Value(item.categoryId),
            name: Value(item.name),
            brand: Value(item.brand),
            addedAt: Value(item.addedAt),
            expiresAt: Value(item.expiresAt),
          ));

      if (rows == 0) {
        return Err(NotFoundException());
      }

      return Ok(const None());
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<None>> delete(int id) async {
    try {
      final rows = await (_db.delete(_db.item)..where((i) => i.id.equals(id))).go();

      if (rows == 0) {
        return Err(NotFoundException());
      }

      return Ok(const None());
    } catch (e) {
      return Err(ServerException());
    }
  }
}