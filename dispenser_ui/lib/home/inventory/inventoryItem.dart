import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InventoryItem extends StatefulWidget {
  InventoryItem({Key key}) : super(key: key);

  @override
  _InventoryItemState createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  List<String> foodItems = [
    "food1",
    "food2",
    "food3",
    "food4",
    "food5",
    "food6",
    "food7",
    "food8",
    "food9",
    "food10"
  ];

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Name of Food"),
        ),
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => foodInformation(context),
          child: ListTile(
            leading: Icon(Icons.fastfood),
            title: Text(foodItems[i]),
          ),
        ),
      ),
    );
  }
}
