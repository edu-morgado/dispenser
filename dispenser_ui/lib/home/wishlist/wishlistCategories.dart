import 'package:dispenser_ui/home/wishlist/wishlistRemote.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';

class WishListCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListCategories> {
    
      void loadWishlistItemsPage(BuildContext context) {

    var route = new MaterialPageRoute(
        builder: (BuildContext context) => WishListItems());
    Navigator.of(context).push(route);
  }
  
void loadcloudlist(BuildContext context) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => RemoteWishlist());
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
            onPressed: () => loadWishlistItemsPage(context),
          ),
          IconButton(
            icon: Icon(
              Icons.cloud_download,
              color: Colors.white,
            ),
            onPressed: () => loadcloudlist(context),
          ),
        ],
      ),
      body: CustomScrollView(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 + 20,
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text('Grid Item $index'),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('Grid Item $index'),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

/*

      GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: categories,
          itemBuilder: (context, i) {
            return Card(
              elevation: 10.0,
              child: Text("Category Card"),
            );
          }),
          */
