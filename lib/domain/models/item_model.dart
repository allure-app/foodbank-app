import 'package:foodbank_app/data/models/schema.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required int categoryId,
    required String? barcode,
    required String name,
    required String? brand,
    required DateTime? expiresAt,
    required DateTime addedAt,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json)
  => _$ItemModelFromJson(json);

  factory ItemModel.fromEntity(ItemData i) => ItemModel(
    id: i.id,
    categoryId: i.categoryId,
    barcode: i.barcode,
    name: i.name,
    brand: i.brand,
    expiresAt: i.expiresAt,
    addedAt: i.addedAt,
  );
}