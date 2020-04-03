import 'package:dispenser_ui/home/inventory/inventoryItem.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InventoryState();
  }
}

class InventoryState extends State<Inventory> {
  List<String> inventoryItem = [
    "fridge",
    "freezer",
    "storage",
  ];

  @override
  Widget build(BuildContext context) {
    print(inventoryItem.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: ListView.builder(
        itemCount: inventoryItem.length,
        itemBuilder: (context, i) => Column(
          children: [
            Divider(
              height: 10.0,
            ),
            InkWell(
              onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                  InventoryItem())),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image:
                        AssetImage('assets/inventory/${inventoryItem[i]}.jpg'),
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
