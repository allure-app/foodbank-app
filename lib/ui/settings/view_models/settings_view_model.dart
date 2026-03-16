// import 'package:drift/drift.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:foodbank_app/data/models/schema.dart';
// import 'package:foodbank_app/domain/exceptions/server_exception.dart';
// import 'package:foodbank_app/ui/core/scaffold_state.dart';
//
// final settingsViewModelProvider = ChangeNotifierProvider((ref) {
//   return SettingsViewModel(db: ref.read(databaseProvider));
// });
//
// class SettingsViewModel extends ChangeNotifier implements FbScaffoldState {
//   SettingsViewModel({required AppDatabase db}) : _db = db;
//
//   final AppDatabase _db;
//
//   @override
//   Error? get error => _error;
//   Error? _error;
//
//   @override
//   bool get isEmpty => false;
//
//   @override
//   bool get isLoading => _isLoading;
//   bool _isLoading = false;
//
//   Future<void> dropDatabase() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final m = Migrator(_db);
//       for (final table in _db.allTables) {
//         await m.deleteTable(table.actualTableName);
//         await m.createTable(table);
//         _db.markTablesUpdated({table});
//       }
//     } catch (e) {
//       _error = ServerException();
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }