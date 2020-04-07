import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';

part 'FoodRepository.g.dart';

@JsonSerializable()
class ObjFoodRepository {

  int type;
  String name;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();

  ObjFoodRepository(this.type, this.name);

  void addFoodItemToRepository(ObjFoodItem foodItem) => foodItems.add(foodItem);

  factory ObjFoodRepository.fromJson(Map<String, dynamic> json) => _$ObjFoodRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$ObjFoodRepositoryToJson(this);
}



@JsonSerializable()
class ListFoodRepository {
  List<ObjFoodRepository> repositories;

  ListFoodRepository() : repositories = List<ObjFoodRepository>();

  int get length {
    return repositories.length;
  }


  bool isEmpty() {
    return repositories.length == 0;
  }


  factory ListFoodRepository.fromJson(Map<String, dynamic> json) =>
      _$ListFoodRepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListFoodRepositoryToJson(this);
}
