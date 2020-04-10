import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/objects/Category.dart';

class WishListAllItems extends StatefulWidget {
  final List<ObjFoodItem> categories;

  WishListAllItems(this.categories);

  @override
  State<StatefulWidget> createState() {

    return WishListState(this.categories);
  }
}

class WishListState extends State<WishListAllItems> {
  List<ObjFoodItem> categories;
  static List<bool> isChecked = [false, false, false, false, false, false];

  WishListState(this.categories);


  List<Widget> meat() {
    return [
      ListTile(
        leading: Text("1 ITEM"),
        trailing: Checkbox(
            value: isChecked[0],
            onChanged: (bool value) {
              setState(() {
                isChecked[0] = value;
              });
            }),
      ),
      ListTile(
        leading: Text("2 ITEM"),
        trailing: Checkbox(
            value: isChecked[1],
            onChanged: (bool value) {
              setState(() {
                isChecked[1] = value;
              });
            }),
      ),
    ];
  }

  List<Widget> dengue() {
    return [
      ListTile(
        leading: Text("3 ITEM"),
        trailing: Checkbox(
            value: isChecked[2],
            onChanged: (bool value) {
              setState(() {
                isChecked[2] = value;
              });
            }),
      ),
      ListTile(
        leading: Text("4 ITEM"),
        trailing: Checkbox(
            value: isChecked[3],
            onChanged: (bool value) {
              setState(() {
                isChecked[3] = value;
              });
            }),
      ),
    ];
  }

  List<Widget> coockies() {
    return [
      ListTile(
        leading: Text("5 ITEM"),
        trailing: Checkbox(
            value: isChecked[4],
            onChanged: (bool value) {
              setState(() {
                isChecked[4] = value;
              });
            }),
      ),
      ListTile(
        leading: Text("6 ITEM"),
        trailing: Checkbox(
            value: isChecked[5],
            onChanged: (bool value) {
              setState(() {
                isChecked[5] = value;
              });
            }),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
          title: Text("WishList Page"),
          centerTitle: true,
          elevation: 9.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.playlist_add,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ]),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text(categories[i].name))),
              color: Color.fromRGBO(75, 133, 149, 1),
            ),
            Column(
              children: [Container()],
            ),
          ],
        ),
      ),
    );
  }
}
