import 'package:json_annotation/json_annotation.dart';

part 'FoodRepository.g.dart';

@JsonSerializable()
class ObjFoodRepository {



  ObjFoodRepository();

  factory ObjFoodRepository.fromJson(Map<String, dynamic> json) => _$ObjFoodRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$ObjFoodRepositoryToJson(this);
}



@JsonSerializable()
class ListFoodRepository {
  List<ObjFoodRepository> foodRepositories;

  ListFoodRepository() : foodRepositories = List<ObjFoodRepository>();

  int get lenght {
    return foodRepositories.length;
  }


  bool isEmpty() {
    return foodRepositories.length == 0;
  }


  factory ListFoodRepository.fromJson(Map<String, dynamic> json) =>
      _$ListFoodRepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListFoodRepositoryToJson(this);
}
