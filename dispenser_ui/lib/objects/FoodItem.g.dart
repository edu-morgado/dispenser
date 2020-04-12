// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodItem _$ObjFoodItemFromJson(Map<String, dynamic> json) {
  return ObjFoodItem(
      json['id'] as int, json['name'] as String, json['quantity'] as int, json['section'] as int );
}

Map<String, dynamic> _$ObjFoodItemToJson(ObjFoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'section': instance.quantity
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
