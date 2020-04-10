
import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';
part 'Wishlist.g.dart';

@JsonSerializable()
class ObjWishList {

  int id;
  String name;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();
  

  ObjWishList(this.id,this.name);

  void addFoodItemToCategory(ObjFoodItem foodItem) => foodItems.add(foodItem);

  factory ObjWishList.fromJson(Map<String, dynamic> json) => _$ObjWishListFromJson(json);
  Map<String, dynamic> toJson() => _$ObjWishListToJson(this);
}

@JsonSerializable()
class ListWishList {
  List<ObjWishList> wishlists;

  ListWishList() : wishlists = List<ObjWishList>();

  int get lenght {
    return wishlists.length;
  }

  bool isEmpty() {
    return wishlists.length == 0;
  }

  factory ListWishList.fromJson(Map<String, dynamic> json) => _$ListWishListFromJson(json);
  Map<String, dynamic> toJson() => _$ListWishListToJson(this);
}