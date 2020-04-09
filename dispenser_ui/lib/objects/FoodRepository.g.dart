// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodRepository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodRepository _$ObjFoodRepositoryFromJson(Map<String, dynamic> json) {
  return ObjFoodRepository(
      json['id'] as int, json['ttype'] as int, json['name'] as String)
    ..foodItems = (json['foodItems'] as List)
        ?.map((e) =>
            e == null ? null : ObjFoodItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ObjFoodRepositoryToJson(ObjFoodRepository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ttype': instance.ttype,
      'foodItems': instance.foodItems
    };

ListFoodRepository _$ListFoodRepositoryFromJson(Map<String, dynamic> json) {
  return ListFoodRepository()
    ..repositories = (json['repositories'] as List)
        ?.map((e) => e == null
            ? null
            : ObjFoodRepository.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListFoodRepositoryToJson(ListFoodRepository instance) =>
    <String, dynamic>{'repositories': instance.repositories};
