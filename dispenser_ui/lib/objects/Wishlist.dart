
import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';
part 'WishList.g.dart';

@JsonSerializable()
class ObjWishList {

  int id;
  String name;  
  DateTime dateCreated;
  DateTime dateLastUpdated;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();
  

  ObjWishList(this.name, this.dateCreated, this.dateLastUpdated);

  @override
  String toString() {
    return "wishlist id=${this.id} with name=${this.name}";
  }

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

  bool updateFromList(List<ObjWishList> newWishlists) {
    wishlists = newWishlists;
    return true;
  }

  factory ListWishList.fromJson(Map<String, dynamic> json) => _$ListWishListFromJson(json);
  Map<String, dynamic> toJson() => _$ListWishListToJson(this);
}