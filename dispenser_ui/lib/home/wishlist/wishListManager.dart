import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:dispenser_ui/ObjManager.dart';
class WishListManager extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return WishListState();
  }
}

class WishListState extends State<WishListManager> {
  @override
  void initState() {
    super.initState();
  }


  List<bool> isSelected = List<bool>();

  List<Color> mycolors = List<Color>();

  void initializeIsSelected(int size) {
    if (isSelected.length == 0){
      for (int i = 0; i < size; i++) isSelected.add(false);
      for (int i = 0; i < size; i++) mycolors.add(Color.fromRGBO(182, 122, 133, 1));
    }
  }
  
  void setEverythingToSelected(){
    for(int i = 0 ; i < isSelected.length ; i++) isSelected[i] = true;
  }

  void setEverythingToNotSelected(){
    for(int i = 0 ; i < isSelected.length ; i++) isSelected[i] = false;
  }

  void selected(int i) {
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

  Widget deleteIconButton(Manager manager) {
    print("in function deleteIconbutton");
    for (bool selected in isSelected)
      if (selected)
        return IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => deleteWishLists(manager),
        );

    return Container();
  }

  void deleteWishLists(Manager manager){
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
    final Manager manager = Provider.of<Manager>(context) ;

    initializeIsSelected(manager.wishlists.wishlists.length);

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
          deleteIconButton(manager),
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
                        onLongPress: () => selected(index),
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
