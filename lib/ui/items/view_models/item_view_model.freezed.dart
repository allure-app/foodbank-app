// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemState {

 ItemModel? get item; List<CategoryModel> get categories; ValidationErrors get validationErrors;
/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemStateCopyWith<ItemState> get copyWith => _$ItemStateCopyWithImpl<ItemState>(this as ItemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemState&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.validationErrors, validationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(validationErrors));

@override
String toString() {
  return 'ItemState(item: $item, categories: $categories, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class $ItemStateCopyWith<$Res>  {
  factory $ItemStateCopyWith(ItemState value, $Res Function(ItemState) _then) = _$ItemStateCopyWithImpl;
@useResult
$Res call({
 ItemModel? item, List<CategoryModel> categories, ValidationErrors validationErrors
});


$ItemModelCopyWith<$Res>? get item;

}
/// @nodoc
class _$ItemStateCopyWithImpl<$Res>
    implements $ItemStateCopyWith<$Res> {
  _$ItemStateCopyWithImpl(this._self, this._then);

  final ItemState _self;
  final $Res Function(ItemState) _then;

/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = freezed,Object? categories = null,Object? validationErrors = null,}) {
  return _then(_self.copyWith(
item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemModel?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,validationErrors: null == validationErrors ? _self.validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as ValidationErrors,
  ));
}
/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemModelCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [ItemState].
extension ItemStatePatterns on ItemState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemState value)  $default,){
final _that = this;
switch (_that) {
case _ItemState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemState value)?  $default,){
final _that = this;
switch (_that) {
case _ItemState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ItemModel? item,  List<CategoryModel> categories,  ValidationErrors validationErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemState() when $default != null:
return $default(_that.item,_that.categories,_that.validationErrors);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ItemModel? item,  List<CategoryModel> categories,  ValidationErrors validationErrors)  $default,) {final _that = this;
switch (_that) {
case _ItemState():
return $default(_that.item,_that.categories,_that.validationErrors);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ItemModel? item,  List<CategoryModel> categories,  ValidationErrors validationErrors)?  $default,) {final _that = this;
switch (_that) {
case _ItemState() when $default != null:
return $default(_that.item,_that.categories,_that.validationErrors);case _:
  return null;

}
}

}

/// @nodoc


class _ItemState implements ItemState {
   _ItemState({this.item, final  List<CategoryModel> categories = const [], final  ValidationErrors validationErrors = const {}}): _categories = categories,_validationErrors = validationErrors;
  

@override final  ItemModel? item;
 final  List<CategoryModel> _categories;
@override@JsonKey() List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  ValidationErrors _validationErrors;
@override@JsonKey() ValidationErrors get validationErrors {
  if (_validationErrors is EqualUnmodifiableMapView) return _validationErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_validationErrors);
}


/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemStateCopyWith<_ItemState> get copyWith => __$ItemStateCopyWithImpl<_ItemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemState&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._validationErrors, _validationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_validationErrors));

@override
String toString() {
  return 'ItemState(item: $item, categories: $categories, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class _$ItemStateCopyWith<$Res> implements $ItemStateCopyWith<$Res> {
  factory _$ItemStateCopyWith(_ItemState value, $Res Function(_ItemState) _then) = __$ItemStateCopyWithImpl;
@override @useResult
$Res call({
 ItemModel? item, List<CategoryModel> categories, ValidationErrors validationErrors
});


@override $ItemModelCopyWith<$Res>? get item;

}
/// @nodoc
class __$ItemStateCopyWithImpl<$Res>
    implements _$ItemStateCopyWith<$Res> {
  __$ItemStateCopyWithImpl(this._self, this._then);

  final _ItemState _self;
  final $Res Function(_ItemState) _then;

/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = freezed,Object? categories = null,Object? validationErrors = null,}) {
  return _then(_ItemState(
item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemModel?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,validationErrors: null == validationErrors ? _self._validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as ValidationErrors,
  ));
}

/// Create a copy of ItemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemModelCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
