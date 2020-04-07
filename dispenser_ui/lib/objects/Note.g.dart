// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjNote _$ObjNoteFromJson(Map<String, dynamic> json) {
  return ObjNote(
      json['id'] as int,
      json['title'] as String,
      json['content'] as String,
      json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      json['date_last_edited'] == null
          ? null
          : DateTime.parse(json['date_last_edited'] as String),
      json['note_color'])
    ..is_archived = json['is_archived'] as int;
}

Map<String, dynamic> _$ObjNoteToJson(ObjNote instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date_created': instance.date_created?.toIso8601String(),
      'date_last_edited': instance.date_last_edited?.toIso8601String(),
      'note_color': instance.note_color,
      'is_archived': instance.is_archived
    };

ListNote _$ListNoteFromJson(Map<String, dynamic> json) {
  return ListNote()
    ..notes = (json['notes'] as List)
        ?.map((e) =>
            e == null ? null : ObjNote.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListNoteToJson(ListNote instance) =>
    <String, dynamic>{'notes': instance.notes};
