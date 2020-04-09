import 'package:dispenser_ui/home/inventory/inventoryItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/home/inventory/addInventory.dart';
import 'package:dispenser_ui/ObjManager.dart';

class Inventory extends StatefulWidget {
  final Manager manager;

  Inventory(this.manager);

  @override
  State<StatefulWidget> createState() {
    return InventoryState(manager);
  }
}

class InventoryState extends State<Inventory> {
  Manager manager;

  InventoryState(this.manager);

  List<String> inventoryItem = [
    "fridge",
    "freezer",
    "storage",
  ];

  void loadAddInventory(BuildContext context){
    var route = new MaterialPageRoute(
      builder:(BuildContext context) => AddInventoryInventoryPage(manager));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    print(inventoryItem.length);
    return Scaffold(
      
      body: ListView.builder(
        itemCount: manager.foodRepositories.repositories.length,
        itemBuilder: (context, i) => Column(
          children: [
            Divider(
              height: 10.0,
            ),
            InkWell(
              onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                  InventoryItem(manager.foodRepositories.repositories[i]))),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image:
                        AssetImage('assets/inventory/${manager.foodRepositories.repositories[i].ttype}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
