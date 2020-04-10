import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';

class InventoryItem extends StatefulWidget {
  final Manager manager;
  final ObjFoodRepository repository;

  InventoryItem(this.manager, this.repository, {Key key}) : super(key: key);

  @override
  _InventoryItemState createState() => _InventoryItemState(manager, repository);
}

class _InventoryItemState extends State<InventoryItem> {
  ObjFoodRepository repository;
  Manager manager;

  _InventoryItemState(this.manager, this.repository);

  foodInformation(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "ATENÇÃO",
      desc: "Comida dengada",
      buttons: [
        DialogButton(
          child: Text(
            "Terminal sessão.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.15,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
          Row(children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    manager.foodRepositories.repositories.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ]),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: ListView.builder(
                itemCount: repository.foodItems.length,
                itemBuilder: (context, i) => InkWell(
                  onTap: () => foodInformation(context),
                  child: ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text(manager.foodItems.foodItems[i].name),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
