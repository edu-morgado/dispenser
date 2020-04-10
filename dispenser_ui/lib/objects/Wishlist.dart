
import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';
part 'Wishlist.g.dart';

@JsonSerializable()
class ObjWishlist {

  int id;
  String name;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();
  

  ObjWishlist(this.id,this.name);

  void addFoodItemToCategory(ObjFoodItem foodItem) => foodItems.add(foodItem);

  factory ObjWishlist.fromJson(Map<String, dynamic> json) => _$ObjWishlistFromJson(json);
  Map<String, dynamic> toJson() => _$ObjWishlistToJson(this);
}

@JsonSerializable()
class ListWishlist {
  List<ObjWishlist> wishlists;

  ListWishlist() : wishlists = List<ObjWishlist>();

  int get lenght {
    return wishlists.length;
  }

  bool isEmpty() {
    return wishlists.length == 0;
  }

  factory ListWishlist.fromJson(Map<String, dynamic> json) => _$ListCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListCategoryToJson(this);
}