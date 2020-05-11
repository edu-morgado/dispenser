import 'package:dispenser_ui/customizedwidgets/inventoryWishListTopBar.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:dispenser_ui/home/inventory/inventoryItemsColumn.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Inventory extends StatefulWidget {
  final Manager manager;

  Inventory(this.manager);

  @override
  State<StatefulWidget> createState() {
    return InventoryState(this.manager);
  }
}

class InventoryState extends State<Inventory> {
  Manager manager;
  InventoryState(this.manager);

  List<bool> isSelected = List<bool>();
  int isOpened = -1;

  @override
  void initState() {
    manager.loadInventoriesFromFile().then((bool hasUpdated) {
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
      isSelected[i] = false;
    } else {
      isSelected[i] = true;
    }
    print(isSelected);
    setState(() {});
  }

  void updateFoodItems() {
    setState(() {});
  }

  Future<void> updateInventories() async {
    await manager.loadFoodItemsFromFile();
    print("dengueeeeee");
  }

  @override
  Widget build(BuildContext context) {
    initializeIsSelected(manager.inventories.inventories.length);
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        TopBar(updateFoodItems, manager, context, isSelected, "Inventories"),
        Expanded(
          child: LiquidPullToRefresh(
            springAnimationDurationInMilliseconds: 100,
            onRefresh: () => updateInventories(),
            child: ListView.builder(
              itemCount: manager.inventories.inventories.length,
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
                                  manager.inventories.inventories[index].name),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/inventory/${manager.inventories.inventories[index].ttype}.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          FoodItemColumn(updateFoodItems,
                              manager.inventories.inventories[index])
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
                                manager.inventories.inventories[index].name),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/inventory/${manager.inventories.inventories[index].ttype}.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
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
        ),
      ]),
    );
  }
}
