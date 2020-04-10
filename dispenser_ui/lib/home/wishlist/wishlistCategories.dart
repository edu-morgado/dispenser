import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';
import 'package:dispenser_ui/home/wishlist/wishlistAllItems.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:dispenser_ui/ObjManager.dart';

class WishListCategories extends StatefulWidget {
  final Manager manager;

  WishListCategories(this.manager);

  @override
  State<StatefulWidget> createState() {
    return WishListState(manager);
  }
}

class WishListState extends State<WishListCategories> {
  Manager manager;
  WishListState(this.manager);
  @override
  void initState() {
    super.initState();
  }



  void loadWishListAllItems(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => WishListAllItems(manager));
    Navigator.of(context).push(route);
  }

  List<bool> isSelected = List<bool>();

  List<Color> mycolors = List<Color>();


  void selectedForDeletion(int i) {
    setState(() {
      print("selceting for delection");
      if (isSelected[i]) {
        mycolors[i] = Color.fromRGBO(182, 122, 133, 1);
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
          onPressed: () => deleteWishLists(),
        );

    return Container();
  }

  void deleteWishLists(){
    int i;
    setState(() {
      for ( i = 0; i < isSelected.length; i++){
        print("inside for removing items");
        if (isSelected[i]){
          manager.wishlists.wishlists.removeAt(i);
          i = 0;
          isSelected = [];
          for (int i = 0; i < manager.wishlists.wishlists.length; i++)
            isSelected.add(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < manager.foodRepositories.repositories.length; i++)
    {
      isSelected.add(false);
      mycolors.add(Color.fromRGBO(182, 122, 133, 1));
    }
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
            child: Center(child: godfathersNameStyle("WishList")),
          ),
          deleteIconButton(),
        ]),
        SizedBox(width: 75),
        Container(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 1,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () => selectedForDeletion(index),
                        onTap: () => Navigator.of(context).push(  MaterialPageRoute(
                          builder: (BuildContext context) => WishListItems(manager.wishlists.wishlists[index]))),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8 + 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: godfathersNameStyle('Wishlist ${manager.wishlists.wishlists[index].name}'),
                        ),
                      ),
                    );
                  },
                  childCount: manager.wishlists.wishlists.length,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
