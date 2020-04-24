// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodItem _$ObjFoodItemFromJson(Map<String, dynamic> json) {
  return ObjFoodItem(
      json['name'] as String,
      json['quantity'] as int,
      json['category'] as String,
      json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      json['dateLastUpdated'] == null
          ? null
          : DateTime.parse(json['dateLastUpdated'] as String))
    ..id = json['id'] as int;
}

Map<String, dynamic> _$ObjFoodItemToJson(ObjFoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'category': instance.category,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'dateLastUpdated': instance.dateLastUpdated?.toIso8601String()
    };

ListFoodItem _$ListFoodItemFromJson(Map<String, dynamic> json) {
  return ListFoodItem()
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListFoodItemToJson(ListFoodItem instance) =>
    <String, dynamic>{'foodItems': instance.foodItems};
