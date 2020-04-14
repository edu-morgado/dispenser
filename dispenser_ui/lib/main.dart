import 'package:dispenser_ui/home/homePageManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/WishList.dart';
import 'package:dispenser_ui/objects/Inventory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Manager manager = new Manager();

  Manager createManager() {
    manager.inventories.inventories
        .add(ObjInventory(1, 3, "Items Not Stored"));
    manager.inventories.inventories
        .add(ObjInventory(2, 1, "Fridge"));
    manager.inventories.inventories
        .add(ObjInventory(3, 2, "Freezer"));
    manager.inventories.inventories
        .add(ObjInventory(4, 3, "Storage"));
    manager.wishlists.wishlists.add(ObjWishList(1, "All Items"));
    ObjFoodItem item1 = ObjFoodItem(1, "leite", 6, 12);
    ObjFoodItem item2 = ObjFoodItem(2, "badjoraz", 2, 12);
    ObjFoodItem item3 = ObjFoodItem(3, "degnue", 7, 12);
    ObjFoodItem item4 = ObjFoodItem(4, "carne", 12, 12);
    ObjFoodItem item5 = ObjFoodItem(5, "peixe", 11, 12);
    ObjFoodItem item6 = ObjFoodItem(6, "bolachas", 8, 12);
    ObjFoodItem item7 = ObjFoodItem(7, "dengues", 4, 12);
    ObjFoodItem item8 = ObjFoodItem(8, "batatas", 3, 12);

    manager.inventories.inventories[0].addFoodItemToRepository(item1);
    manager.inventories.inventories[0].addFoodItemToRepository(item2);
    manager.inventories.inventories[0].addFoodItemToRepository(item3);
    manager.inventories.inventories[1].addFoodItemToRepository(item1);
    manager.inventories.inventories[1].addFoodItemToRepository(item4);
    manager.inventories.inventories[1].addFoodItemToRepository(item7);
    manager.inventories.inventories[2].addFoodItemToRepository(item8);
    manager.inventories.inventories[2].addFoodItemToRepository(item6);
    manager.inventories.inventories[2].addFoodItemToRepository(item5);
    manager.inventories.inventories[3].addFoodItemToRepository(item3);
    manager.inventories.inventories[3].addFoodItemToRepository(item6);
    manager.inventories.inventories[3].addFoodItemToRepository(item5);
    manager.wishlists.wishlists[0].foodItems.add(item1);
    manager.wishlists.wishlists[0].foodItems.add(item3);
    manager.wishlists.wishlists[0].foodItems.add(item2);
    return manager;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => createManager(),
      child: Consumer<Manager>(builder: (context, manager, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue, secondaryHeaderColor: Colors.white),
          home: Home(),
        );
      }),
    );
  }
}
