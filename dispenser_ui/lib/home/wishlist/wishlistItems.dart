import 'package:flutter/material.dart';

class WishListItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListItems> {
  static List<bool> isChecked = [false, false, false, false, false, false];

  List<Widget> items() {
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
    List<Widget> foodItems = items();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.0),
        child: Flex(direction: Axis.vertical, children: [
          AppBar(
            title: Text("Category Name"),
            centerTitle: true,
            elevation: 15.0,
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
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Text("Information about category")),
          )
        ]),
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, i) => foodItems[i],
      ),
    );
  }
}


