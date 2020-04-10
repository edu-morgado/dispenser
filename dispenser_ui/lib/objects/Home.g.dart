// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjHome _$ObjHomeFromJson(Map<String, dynamic> json) {
  return ObjHome(
      json['notes'] == null
          ? null
          : ListNote.fromJson(json['notes'] as Map<String, dynamic>),
      json['foodItems'] == null
          ? null
          : ListFoodItem.fromJson(json['foodItems'] as Map<String, dynamic>),
      json['categories'] == null
          ? null
          : ListWishlist.fromJson(json['categories'] as Map<String, dynamic>),
      json['foodRepositories'] == null
          ? null
          : ListFoodRepository.fromJson(
              json['foodRepositories'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ObjHomeToJson(ObjHome instance) => <String, dynamic>{
      'notes': instance.notes,
      'foodItems': instance.foodItems,
      'categories': instance.categories,
      'foodRepositories': instance.foodRepositories
    };
