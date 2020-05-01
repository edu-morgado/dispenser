import 'WishList.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Note.dart';
import 'FoodItem.dart';
import 'Inventory.dart';

part 'Home.g.dart';

@JsonSerializable()
class ObjHome {
  int id;
  String name;

  ObjHome(this.name);
  ObjHome.getExistingHome();

  @override
  String toString() {
    return "home name:${this.name} with id: ${this.id}";
  }

  factory ObjHome.fromJson(Map<String, dynamic> json) =>
      _$ObjHomeFromJson(json);
  Map<String, dynamic> toJson() => _$ObjHomeToJson(this);
}

@JsonSerializable()
class ListHome {
  List<ObjHome> homes;

  ListHome() : homes = List<ObjHome>();

  bool isEmpty() {
    return homes.length == 0;
  }

  factory ListHome.fromJson(Map<String,dynamic> json) =>_$ListHomeFromJson(json);
  Map<String, dynamic> toJson() => _$ListHomeToJson(this);
}
