import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InventoryItem extends StatefulWidget {

  final ObjFoodRepository repository;

  InventoryItem(this.repository) ;

  @override
  _InventoryItemState createState() => _InventoryItemState(repository);
}

class _InventoryItemState extends State<InventoryItem> {
   ObjFoodRepository repository;

   _InventoryItemState(this.repository);

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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Food"),
      ),
      body: ListView.builder(
        itemCount: repository.foodItems.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => foodInformation(context),
          child: ListTile(
            leading: Icon(Icons.fastfood),
            title: Text(repository.foodItems[i].name),
          ),
        ),
      ),
    );
  }
}
