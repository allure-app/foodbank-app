import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod/riverpod.dart';

part 'schema.g.dart';

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

class Item extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Category, #id)();
  TextColumn get barcode => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get brand => text().nullable().withLength(min: 1, max: 100)();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get addedAt => dateTime()();
}

final databaseProvider = Provider((_) {
  return AppDatabase();
});

@DriftDatabase(tables: [Category, Item])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'foodbank',
      native: DriftNativeOptions(),
    );
  }
}