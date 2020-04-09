import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:dispenser_ui/home/wishlist/wishlistRemote.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';
import 'package:dispenser_ui/textStyles.dart';

class WishListCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListCategories> {
  @override
  void initState() {
    super.initState();
  }

  void loadWishlistItemsPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => WishListItems());
    Navigator.of(context).push(route);
  }

  void loadcloudlist(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => RemoteWishlist());
    Navigator.of(context).push(route);
  }

  void loadWishListAllItems(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => WishListAllItems());
    Navigator.of(context).push(route);
  }

  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<Color> mycolors = [
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7),
    Color.fromRGBO(182, 122, 133, 0.7)
  ];
  void selectedForDeletion(int i) {
    setState(() {
      print("selceting for delection");
      if (isSelected[i]) {
        mycolors[i] =  Color.fromRGBO(182, 122, 133, 1);
        isSelected[i] = false;
      } else {
        mycolors[i] = Colors.red;
        isSelected[i] = true;
      }
    });
  }

  Widget deleteIconButton() {
    print("in function deleteIconbutton");
    for (bool selected in isSelected)
      if (selected)
        return IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => print("DELETE NOW NIGGA"),
        );

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        Container(height: 45),
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            child: Center(child: godfathersNameStyle("Wish List")),
          ),
          deleteIconButton(),
        ]),
        SizedBox(width: 75),
        Container(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () => loadWishListAllItems(context),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8 + 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: godfathersNameStyle('Grid Item $index'),
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () => selectedForDeletion(index),
                        onTap: () => loadWishlistItemsPage(context),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: mycolors[index],
                              borderRadius: BorderRadius.circular(20.0)),
                          child: godfathersNameStyle('Grid Item $index'),
                        ),
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
