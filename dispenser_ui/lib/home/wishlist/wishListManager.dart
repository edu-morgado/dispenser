import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dispenser_ui/home/wishlist/wishlistItems.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/customizedwidgets/foodItems_column.dart';

class WishListManager extends StatefulWidget {
  final Manager manager;

  WishListManager(this.manager);
  @override
  State<StatefulWidget> createState() {
    return WishListState(this.manager);
  }
}

class WishListState extends State<WishListManager> {
  Manager manager;
  WishListState(this.manager);

  List<bool> isSelected = List<bool>();
  int isOpened = -1;

  @override
  void initState() {
    manager.loadWishListsFromFile().then((bool hasUpdated) {
      if (mounted && hasUpdated) setState(() {});
    });
    super.initState();
  }

  void initializeIsSelected(int size) {
    if (isSelected.length != size)
      for (int i = isSelected.length; i < size; i++) isSelected.add(false);
  }

  void setEverythingToSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = true;
    setState(() {});
  }

  void setEverythingToNotSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = false;
    setState(() {});
  }

  void selected(int i) {
    if (isSelected[i]) {
      print("INDEX -> $i not selected for deletion");
      isSelected[i] = false;
    } else {
      isSelected[i] = true;
      print("INDEX -> $i  selected for deletion");
    }
    print(isSelected);
    setState(() {});
  }

  Widget deleteIconButton(Manager manager) {
    return IconButton(
      icon: Icon(Icons.delete_outline),
      onPressed: () => deleteWishlist(manager),
    );
  }

  void deleteWishlist(Manager manager) {
    int i;
    setState(() {
      for (i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          manager.wishlists.wishlists.removeAt(i);
          isSelected.removeAt(i);
          i = -1;
        }
      }
    });
  }

  Widget selectAllIconButton() {
    return Checkbox(
        value: allSelected(),
        onChanged: (bool value) {
          print(allSelected());
          if (!allSelected())
            setEverythingToSelected();
          else
            setEverythingToNotSelected();
        });
  }

  bool anySelected() {
    for (int i = 0; i < isSelected.length; i++) if (isSelected[i]) return true;
    return false;
  }

  bool allSelected() {
    for (int i = 0; i < isSelected.length; i++)
      if (!isSelected[i]) return false;
    return true;
  }

  int wishlistNumbSelected() {
    int n = 0;
    for (int i = 0; i < isSelected.length; i++) if (isSelected[i]) n++;
    return n;
  }

  Widget topBar(Manager manager) {
    if (anySelected())
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(child: godfathersNameStyle("Editing Wishlists")),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: new BorderRadius.vertical(
                bottom: new Radius.circular(20.0),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: selectAllIconButton()),
              dispenserDescription(
                  "${wishlistNumbSelected()} Wishlists Selected"),
              Expanded(child: Container()),
              deleteIconButton(manager),
            ],
          ),
        ],
      );
    else
      return Row(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Center(child: godfathersNameStyle("Wishlists")),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.circular(20.0),
            ),
          ),
        )
      ]);
  }

  void updateFoodItems() {
    setState(() {
      print("SETSTATING FOR UPDATEING FOOD PRODUCTS");
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeIsSelected(manager.wishlists.wishlists.length);

    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        topBar(manager),
        SizedBox(width: 75),
        Container(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: manager.wishlists.wishlists.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                  child: Stack(alignment: Alignment.topLeft, children: [
                index == isOpened
                    ? Column(children: [
                        GestureDetector(
                          onLongPress: () => selected(index),
                          onTap: () {
                            setState(() {
                              isOpened != index
                                  ? isOpened = index
                                  : isOpened = -1;
                            });
                          },
                          child: Container(
                            child: godfathersNameStyle(
                                manager.wishlists.wishlists[index].name),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.red,
                            ),
                          ),
                        ),
                        FoodItemColumn(updateFoodItems,
                            manager.wishlists.wishlists[index]),
                      ])
                    : GestureDetector(
                        onLongPress: () => selected(index),
                        onTap: () {
                          setState(() {
                            isOpened != index
                                ? isOpened = index
                                : isOpened = -1;
                          });
                        },
                        child: Container(
                          child: godfathersNameStyle(
                              manager.wishlists.wishlists[index].name),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.green),
                        ),
                      ),
                anySelected()
                    ? Checkbox(
                        value: isSelected[index],
                        onChanged: (bool value) {
                          selected(index);
                        })
                    : Container(),
              ])),
            ),
          ),
        ),
      ]),
    );
  }
}
