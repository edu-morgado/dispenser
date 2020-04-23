// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodItem _$ObjFoodItemFromJson(Map<String, dynamic> json) {
  return ObjFoodItem(
      json['name'] as String, json['quantity'] as int, json['category'] as int)
    ..id = json['id'] as int
    ..foodname = json['foodname'] as String
    ..foodquantity = json['foodquantity'] as int;
}

Map<String, dynamic> _$ObjFoodItemToJson(ObjFoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'category': instance.category,
      'foodname': instance.foodname,
      'foodquantity': instance.foodquantity
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
