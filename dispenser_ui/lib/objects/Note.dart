import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Note.g.dart';

@JsonSerializable()
class ObjNote {
  int id;
  String title;
  String content;
  DateTime date_created;
  DateTime date_last_edited;
  Color note_color;
  int is_archived = 0;

  ObjNote(this.id, this.title, this.content, this.date_created,
      this.date_last_edited, this.note_color);

  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  void archiveThisNote() {
    is_archived = 1;
  }

// overriding toString() of the note class to print a better debug description of this custom class
  @override
  toString() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date_created': epochFromDate(date_created),
      'date_last_edited': epochFromDate(date_last_edited),
      'note_color': note_color.toString(),
      'is_archived': is_archived
    }.toString();
  }

  factory ObjNote.fromJson(Map<String, dynamic> json) =>
      _$ObjNoteFromJson(json);

  Map<String, dynamic> toJson() => _$ObjNoteToJson(this);
}

@JsonSerializable()
class ListNote {
  List<ObjNote> notes;

  ListNote() : notes = List<ObjNote>();

  int get lenght {
    return notes.length;
  }

  bool isEmpty() {
    return notes.length == 0;
  }

  factory ListNote.fromJson(Map<String, dynamic> json) =>
      _$ListNoteFromJson(json);
  Map<String, dynamic> toJson() => _$ListNoteToJson(this);
}
