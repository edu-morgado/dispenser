// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodRepository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjFoodRepository _$ObjFoodRepositoryFromJson(Map<String, dynamic> json) {
  return ObjFoodRepository();
}

Map<String, dynamic> _$ObjFoodRepositoryToJson(ObjFoodRepository instance) =>
    <String, dynamic>{};

ListFoodRepository _$ListFoodRepositoryFromJson(Map<String, dynamic> json) {
  return ListFoodRepository()
    ..foodRepositories = (json['foodRepositories'] as List)
        ?.map((e) => e == null
            ? null
            : ObjFoodRepository.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListFoodRepositoryToJson(ListFoodRepository instance) =>
    <String, dynamic>{'foodRepositories': instance.foodRepositories};
