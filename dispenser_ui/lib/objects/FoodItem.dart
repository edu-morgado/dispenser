import 'package:json_annotation/json_annotation.dart';

part 'FoodItem.g.dart';


@JsonSerializable()
class ObjFoodItem {

  ObjFoodItem();

  factory ObjFoodItem.fromJson(Map<String, dynamic> json) => _$ObjFoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$ObjFoodItemToJson(this);
}


@JsonSerializable()
class ListFoodItem {

  List<ObjFoodItem> foodItems;

  ListFoodItem() : foodItems = List<ObjFoodItem>();

  int get lenght {
    return foodItems.length;
  }


  bool isEmpty() {
    return foodItems.length == 0;
  }


  factory ListFoodItem.fromJson(Map<String, dynamic> json) => _$ListFoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$ListFoodItemToJson(this);
}