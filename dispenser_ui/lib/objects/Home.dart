import 'package:json_annotation/json_annotation.dart';
import 'Note.dart';
import 'Category.dart';
import 'FoodItem.dart';
import 'FoodRepository.dart';


part 'Home.g.dart';


@JsonSerializable()
class ObjHome {
  ListNote notes   ;
  ListFoodItem foodItems  ;
  ListCategory categories   ;
  ListFoodRepository foodRepositories   ;



  ObjHome(this.notes, this.foodItems, this.categories, this.foodRepositories);

  factory ObjHome.fromJson(Map<String, dynamic> json) => _$ObjHomeFromJson(json);
  Map<String, dynamic> toJson() => _$ObjHomeToJson(this);
}