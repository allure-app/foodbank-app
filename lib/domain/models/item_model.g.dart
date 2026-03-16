// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => _ItemModel(
  id: (json['id'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  barcode: json['barcode'] as String?,
  name: json['name'] as String,
  brand: json['brand'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  addedAt: DateTime.parse(json['addedAt'] as String),
);

Map<String, dynamic> _$ItemModelToJson(_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'barcode': instance.barcode,
      'name': instance.name,
      'brand': instance.brand,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'addedAt': instance.addedAt.toIso8601String(),
    };
