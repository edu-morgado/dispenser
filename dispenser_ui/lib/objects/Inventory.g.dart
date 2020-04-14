// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjInventory _$ObjInventoryFromJson(Map<String, dynamic> json) {
  return ObjInventory(
      json['id'] as int, json['ttype'] as int, json['name'] as String)
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ObjInventoryToJson(ObjInventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ttype': instance.ttype,
      'foodItems': instance.foodItems
    };

ListInventory _$ListInventoryFromJson(Map<String, dynamic> json) {
  return ListInventory()
    ..inventories = (json['inventories'] as List)
        ?.map((e) =>
            e == null ? null : ObjInventory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListInventoryToJson(ListInventory instance) =>
    <String, dynamic>{'inventories': instance.inventories};
