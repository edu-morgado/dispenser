// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjCategory _$ObjCategoryFromJson(Map<String, dynamic> json) {
  return ObjCategory(json['name'] as String, json['type'] as int);
}

Map<String, dynamic> _$ObjCategoryToJson(ObjCategory instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.type};

ListCategory _$ListCategoryFromJson(Map<String, dynamic> json) {
  return ListCategory()
    ..categories = (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : ObjCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListCategoryToJson(ListCategory instance) =>
    <String, dynamic>{'categories': instance.categories};
