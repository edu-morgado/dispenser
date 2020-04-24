// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjInventory _$ObjInventoryFromJson(Map<String, dynamic> json) {
  return ObjInventory(
      json['name'] as String,
      json['ttype'] as int,
      json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      json['dateLastUpdated'] == null
          ? null
          : DateTime.parse(json['dateLastUpdated'] as String))
    ..id = json['id'] as int
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
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'dateLastUpdated': instance.dateLastUpdated?.toIso8601String(),
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
