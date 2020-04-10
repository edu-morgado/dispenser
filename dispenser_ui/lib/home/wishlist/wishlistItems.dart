import 'package:flutter/material.dart';
import 'package:dispenser_ui/objects/Wishlist.dart';

class WishListItems extends StatefulWidget {
  final ObjWishList wishlist;

  WishListItems(this.wishlist);

  @override
  State<StatefulWidget> createState() {
    return WishListState(wishlist);
  }
}

class WishListState extends State<WishListItems> {
  ObjWishList wishlist;

  WishListState(this.wishlist);

   List<bool> isChecked = List<bool>();

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i< wishlist.foodItems.length ; i++) 
      isChecked.add(false);
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
        itemCount: wishlist.foodItems.length,
        itemBuilder: (context, i) => ListTile(
          leading: Text(
            wishlist.foodItems[i].name),
            trailing: Checkbox(
                value: isChecked[i],
                onChanged: (bool value) {
                  setState(() {
                    isChecked[i] = value;
                  });
                }),
          ),
        ),
    );
  }
}
