import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/customizedwidgets/inventoryWishListTopBar.dart';
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

  bool anySelected() {
    for (int i = 0; i < isSelected.length; i++) if (isSelected[i]) return true;
    return false;
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
        TopBar(updateFoodItems, manager, context, isSelected, "Wishlists"),
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
