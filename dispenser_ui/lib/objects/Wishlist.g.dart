// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WishList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjWishList _$ObjWishListFromJson(Map<String, dynamic> json) {
  return ObjWishList(json['name'] as String)
    ..id = json['id'] as int
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ObjWishListToJson(ObjWishList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'foodItems': instance.foodItems
    };

ListWishList _$ListWishListFromJson(Map<String, dynamic> json) {
  return ListWishList()
    ..wishlists = (json['wishlists'] as List)
        ?.map((e) =>
            e == null ? null : ObjWishList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListWishListToJson(ListWishList instance) =>
    <String, dynamic>{'wishlists': instance.wishlists};
