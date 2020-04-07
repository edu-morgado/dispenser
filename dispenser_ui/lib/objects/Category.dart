
import 'package:json_annotation/json_annotation.dart';

part 'Category.g.dart';

@JsonSerializable()
class ObjCategory {

  ObjCategory();

  factory ObjCategory.fromJson(Map<String, dynamic> json) => _$ObjCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ObjCategoryToJson(this);
}

@JsonSerializable()
class ListCategory {


  List<ObjCategory> categories;

  ListCategory() : categories = List<ObjCategory>();

  int get lenght {
    return categories.length;
  }


  bool isEmpty() {
    return categories.length == 0;
  }


  factory ListCategory.fromJson(Map<String, dynamic> json) => _$ListCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListCategoryToJson(this);
}