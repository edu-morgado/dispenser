// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjHome _$ObjHomeFromJson(Map<String, dynamic> json) {
  return ObjHome(json['name'] as String)..id = json['id'] as int;
}

Map<String, dynamic> _$ObjHomeToJson(ObjHome instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ListHome _$ListHomeFromJson(Map<String, dynamic> json) {
  return ListHome()
    ..homes = (json['homes'] as List)
        ?.map((e) =>
            e == null ? null : ObjHome.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListHomeToJson(ListHome instance) =>
    <String, dynamic>{'homes': instance.homes};
