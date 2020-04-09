
import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';

part 'Category.g.dart';

@JsonSerializable()
class ObjCategory {

  int id;
  String name;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();
  

  ObjCategory(this.id,this.name);

  void addFoodItemToCategory(ObjFoodItem foodItem) => foodItems.add(foodItem);

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