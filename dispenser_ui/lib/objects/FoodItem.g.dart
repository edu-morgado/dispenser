// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodItem _$ObjFoodItemFromJson(Map<String, dynamic> json) {
  return ObjFoodItem(json['name'] as String, json['quantity'] as int);
}

Map<String, dynamic> _$ObjFoodItemToJson(ObjFoodItem instance) =>
    <String, dynamic>{'name': instance.name, 'quantity': instance.quantity};

ListFoodItem _$ListFoodItemFromJson(Map<String, dynamic> json) {
  return ListFoodItem()
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListFoodItemToJson(ListFoodItem instance) =>
    <String, dynamic>{'foodItems': instance.foodItems};
