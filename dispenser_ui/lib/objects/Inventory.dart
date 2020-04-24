import 'package:json_annotation/json_annotation.dart';
import 'FoodItem.dart';

part 'Inventory.g.dart';

@JsonSerializable()
class ObjInventory {

  int id;
  String name;
  int ttype;
  DateTime dateCreated;
  DateTime dateLastUpdated;
  List<ObjFoodItem> foodItems = List<ObjFoodItem>();

  ObjInventory(this.name, this.ttype, this.dateCreated, this.dateLastUpdated);

  
  @override
  String toString() {
    return "inventory" + "id ->" +
        id.toString() +" $name ttype is $ttype, and it was created in ${dateCreated.toString()}";
  }
  factory ObjInventory.fromJson(Map<String, dynamic> json) => _$ObjInventoryFromJson(json);

  Map<String, dynamic> toJson() => _$ObjInventoryToJson(this);
}



@JsonSerializable()
class ListInventory {
  List<ObjInventory> inventories;

  ListInventory() : inventories = List<ObjInventory>();

  int get length {
    return inventories.length;
  }


  bool isEmpty() {
    return inventories.length == 0;
  }

  bool updateFromList(List<ObjInventory> newInventories){
    inventories = newInventories;
    return true;
  }




  factory ListInventory.fromJson(Map<String, dynamic> json) =>
      _$ListInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListInventoryToJson(this);
}
