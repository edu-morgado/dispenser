import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:dispenser_ui/home/wishlist/wishlistRemote.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';
import 'package:dispenser_ui/home/wishlist/addMenus.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class WishListCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListCategories>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;
  static const List<IconData> icons = const [
    Icons.sms,
    Icons.mail,
    Icons.phone
  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void loadAddProductPage(BuildContext context) {
    print("dengue");
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddProduct());
    Navigator.of(context).push(route);
  }

  void loadAddCategoryPage(BuildContext context) {
    print("dengue");
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddCategory());
    Navigator.of(context).push(route);
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

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => loadAddProductPage(context),
          label: 'First Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => loadAddCategoryPage(context),
          label: 'Second Child',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        Container(height: 45),
        Center(child: Text("Wish List", style: TextStyle(fontSize: 30))),
        SizedBox(width: 75),
        Container(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
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
                          color: Colors.red,
                          child: Text('Grid Item $index'),
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
                        onTap: () => loadWishlistItemsPage(context),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: Text('Grid Item $index'),
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
      floatingActionButton: buildSpeedDial(),
    );
  }
}
