// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjCategory _$ObjCategoryFromJson(Map<String, dynamic> json) {
  return ObjCategory();
}

Map<String, dynamic> _$ObjCategoryToJson(ObjCategory instance) =>
    <String, dynamic>{};

ListCategory _$ListCategoryFromJson(Map<String, dynamic> json) {
  return ListCategory()
    ..categories = (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : ObjCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListCategoryToJson(ListCategory instance) =>
    <String, dynamic>{'categories': instance.categories};
