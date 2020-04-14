import 'WishList.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Note.dart';
import 'FoodItem.dart';
import 'Inventory.dart';


part 'Home.g.dart';


@JsonSerializable()
class ObjHome {
  ListNote notes   ;
  ListFoodItem foodItems  ;
  ListWishList categories   ;
  ListInventory inventories   ;



  ObjHome(this.notes, this.foodItems, this.categories, this.inventories);

  factory ObjHome.fromJson(Map<String, dynamic> json) => _$ObjHomeFromJson(json);
  Map<String, dynamic> toJson() => _$ObjHomeToJson(this);
}