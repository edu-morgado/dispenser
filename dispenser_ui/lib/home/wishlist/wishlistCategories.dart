import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:dispenser_ui/home/wishlist/wishlistRemote.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';

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
    );
  }
}
