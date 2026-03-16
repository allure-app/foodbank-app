import 'package:drift/drift.dart';
import 'package:foodbank_app/data/models/schema.dart';
import 'package:foodbank_app/domain/exceptions/not_found_exception.dart';
import 'package:foodbank_app/domain/exceptions/result.dart';
import 'package:foodbank_app/domain/exceptions/server_exception.dart';
import 'package:foodbank_app/domain/models/category_model.dart';
import 'package:riverpod/riverpod.dart';

final categoryRepositoryProvider = Provider((ref) {
  return CategoryRepository(db: ref.read(databaseProvider));
});

abstract class CategoryRepositoryInterface {
  Future<Result<List<CategoryModel>>> getAll();
  Future<Result<CategoryModel>> create(CategoryModel category);
  Future<Result<None>> update(CategoryModel category);
  Future<Result<None>> delete(int id);
}

class CategoryRepository implements CategoryRepositoryInterface {
  const CategoryRepository({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  @override
  Future<Result<List<CategoryModel>>> getAll() async {
    try {
      final categories = await _db.select(_db.category).get();
      return Ok(categories.map(CategoryModel.fromEntity).toList(growable: true));
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<CategoryModel>> create(CategoryModel category) async {
    try {
      final id = await _db.into(_db.category).insert(CategoryCompanion.insert(
        name: category.name,
      ));

      return Ok(category.copyWith(id: id));
    } catch (e) {
      return Err(ServerException());
    }
  }

  @override
  Future<Result<None>> update(CategoryModel category) async {
    try {
      final rows = await (_db.update(_db.category)
        ..where((c) => c.id.equals(category.id)))
          .write(CategoryCompanion(name: Value(category.name)));

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
      final rows = await (_db.delete(_db.category)
        ..where((c) => c.id.equals(id)))
          .go();

      if (rows == 0) {
        return Err(NotFoundException());
      }

      return Ok(const None());
    } catch (e) {
      return Err(ServerException());
    }
  }
}