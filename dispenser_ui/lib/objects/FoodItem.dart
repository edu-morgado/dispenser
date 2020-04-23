import 'package:json_annotation/json_annotation.dart';

part 'FoodItem.g.dart';

@JsonSerializable()
class ObjFoodItem {
  int id;
  String name;
  int quantity;
  int category;

  ObjFoodItem.withId(this.id, this.name, this.quantity, this.category);
  ObjFoodItem(this.name, this.quantity, this.category);

  String get foodname {
    return this.name;
  }

  set foodname(String name) {
    this.name = name;
  }

  int get foodquantity {
    return this.quantity;
  }

  set foodquantity(int quantity){
    this.quantity = quantity;
  }

  @override
  String toString() {
    return "id ->" +
        id.toString() +
        "name ->" +
        name +
        "quantity ->" +
        quantity.toString() +
        "category ->" +
        category.toString();
  }

  factory ObjFoodItem.fromJson(Map<String, dynamic> json) =>
      _$ObjFoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$ObjFoodItemToJson(this);
}

@JsonSerializable()
class ListFoodItem {
  List<ObjFoodItem> foodItems;

  ListFoodItem() : foodItems = List<ObjFoodItem>();

  int get length {
    return foodItems.length;
  }

  bool isEmpty() {
    return foodItems.length == 0;
  }

  factory ListFoodItem.fromJson(Map<String, dynamic> json) =>
      _$ListFoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$ListFoodItemToJson(this);
}
