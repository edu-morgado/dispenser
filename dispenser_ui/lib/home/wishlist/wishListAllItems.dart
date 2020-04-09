import 'package:flutter/material.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/home/wishlist/addWishlist.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';

class WishListAllItems extends StatefulWidget {
  final Manager manager;


  WishListAllItems(this.manager);

  @override
  State<StatefulWidget> createState() {
    return WishListState(this.manager);
  }
}

class WishListState extends State<WishListAllItems> {
  static List<bool> isChecked = [false, false, false, false, false, false];
  Manager manager;
  WishListState(this.manager);

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

  void loadAddWishlist(BuildContext context) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => AddCategoryWishlist(manager));
    Navigator.of(context).push(route);
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
        itemCount: manager.foodItems.length,
        itemBuilder: (context, i) => Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  itemCount: manager.foodItems.length,
                  itemBuilder: (context, i) => ListTile(
                    leading: Text(manager.foodItems.foodItems[i].name),
                    trailing: Checkbox(
                        value: isChecked[i],
                        onChanged: (bool value) {
                          setState(() {
                            isChecked[i] = value;
                          });
                        }),
                  ),
                ),
              ),
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
