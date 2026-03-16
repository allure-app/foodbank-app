// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:foodbank_app/domain/exceptions/not_found_exception.dart';
// import 'package:foodbank_app/domain/exceptions/unauthenticated_exception.dart';
// import 'package:foodbank_app/core/repositories/local_storage_repository.dart';
// import 'package:foodbank_app/data/models/schema.dart';
// import 'package:foodbank_app/domains/auth/models/user_model.dart';
// import 'package:foodbank_app/domains/auth/repositories/user_db_repository.dart';
//
// void main() {
//   late AppDatabase db;
//   late FlutterSecureStorage flutterSecureStorage;
//   late LocalStorageRepositoryInterface localStorage;
//
//   setUp(() {
//     db = AppDatabase(
//       DatabaseConnection(
//         NativeDatabase.memory(),
//         closeStreamsSynchronously: true,
//       ),
//     );
//
//     FlutterSecureStorage.setMockInitialValues({});
//     flutterSecureStorage = FlutterSecureStorage();
//     localStorage = LocalStorageRepository(
//       storage: flutterSecureStorage,
//     );
//   });
//
//   tearDown(() async {
//     await db.close();
//   });
//
//   test('Users can be created with just a name', () async {
//     // Arrange.
//     const String name = 'Test User';
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final input = UserModel(name: name);
//
//     // Act.
//     final result = await sut.create(input);
//
//     // Assert.
//     expect(result.name, name);
//     expect(result.categoryId, isNot(null));
//     expectLater(
//       await (db.select(db.user)..where((u) => u.categoryId.equals(result.categoryId as int))).getSingle(),
//       isA<UserData>().having((u) => u.name, 'database name matches', name),
//     );
//   });
//
//   test('Supplying id on create does nothing', () async {
//     // Arrange.
//     const int id = 999;
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final input = UserModel(name: 'Test User', categoryId: id);
//
//     // Act.
//     final result = await sut.create(input);
//
//     // Assert.
//     expect(result.categoryId, isNot(id));
//   });
//
//   test('Password cannot be stored locally', () async {
//     // Arrange.
//     const String password = 'password';
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final input = UserModel(name: 'Test User', password: password);
//
//     // Act.
//     final result = await sut.create(input);
//
//     // Assert.
//     expect(result.categoryId, isNot(null));
//     expect(result.password, null);
//     expectLater(
//       await sut.getAll(),
//       isA<List<UserModel>>().having(
//         (users) => users.first.password,
//         'does not contain password',
//         null,
//       ),
//     );
//   });
//
//   test('Can get multiple users', () async {
//     // Arrange.
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     await sut.create(UserModel(name: 'User 1'));
//     await sut.create(UserModel(name: 'User 2'));
//
//     // Act.
//     final result = await sut.getAll();
//
//     // Assert.
//     expect(result, hasLength(2));
//   });
//
//   test('Updating a user that does not exist throws a not found error', () async {
//     // Arrange.
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final input = UserModel(name: 'Test User', categoryId: 1);
//
//     // Act.
//     Future<UserModel> action() => sut.update(input);
//
//     // Assert.
//     expect(action(), throwsA(isA<NotFoundException>()));
//   });
//
//   test('Updating a user that does exist is successful', () async {
//     // Arrange.
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final created = await sut.create(UserModel(name: 'Test User'));
//     final input = UserModel(name: 'Updated Name', categoryId: created.categoryId);
//
//     // Act.
//     final result = await sut.update(input);
//
//     // Assert.
//     expect(result.name, 'Updated Name');
//     expectLater(
//       await sut.getAll(),
//       isA<List<UserModel>>().having(
//         (users) => users.first.name,
//         'user name',
//         'Updated Name',
//       ),
//     );
//   });
//
//   test('Get me when not setup throw unauthenticated exception', () async {
//     // Arrange.
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//
//     // Act.
//     Future<UserModel> action() => sut.getMe();
//
//     // Assert.
//     expect(action(), throwsA(isA<UnauthenticatedException>()));
//   });
//
//   test('Get me when authenticated returns correct model', () async {
//     // Arrange.
//     final sut = UserDbRepository(db: db, localStorage: localStorage);
//     final user = await sut.create(UserModel(name: 'Test User'));
//     localStorage.setUserDetails(UserDetails(categoryId: user.categoryId as int));
//
//     // Act.
//     final result = await sut.getMe();
//
//     // Assert.
//     expect(result.name, 'Test User');
//   });
// }