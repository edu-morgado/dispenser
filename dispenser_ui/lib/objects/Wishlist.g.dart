// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjWishlist _$ObjWishlistFromJson(Map<String, dynamic> json) {
  return ObjWishlist(json['id'] as int, json['name'] as String)
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ObjWishlistToJson(ObjWishlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'foodItems': instance.foodItems
    };

ListWishlist _$ListCategoryFromJson(Map<String, dynamic> json) {
  return ListWishlist()
    ..wishlists = (json['wishlists'] as List)
        ?.map((e) =>
            e == null ? null : ObjWishlist.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListCategoryToJson(ListWishlist instance) =>
    <String, dynamic>{'wishlists': instance.wishlists};
