import 'package:flutter/material.dart';

class WishListItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListItems> {
  List<String> titles = ["Meat", "Dengue", "Coockies"];
  static List<bool> isChecked = [false, false, false, false, false, false];

  List<List<Widget>> foodtypes() {
    return [meat(), dengue(), coockies()];
  }

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
      ListTile(leading: Text("2 ITEM")),
    ];
  }

  List<Widget> dengue() {
    return [
      ListTile(leading: Text("3 ITEM")),
      ListTile(leading: Text("4 ITEM")),
    ];
  }

  List<Widget> coockies() {
    return [
      ListTile(leading: Text("5 ITEM")),
      ListTile(leading: Text("6 ITEM")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> types = foodtypes();
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
        ],
      ),
      body: ListView.builder(
        itemCount: types.length,
        itemBuilder: (context, i) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text(titles[i]))),
              color: Color.fromRGBO(75, 133, 149, 1),
            ),
            Column(
              children: types[i],
            ),
          ],
        ),
      ), 
    );
  }
}
