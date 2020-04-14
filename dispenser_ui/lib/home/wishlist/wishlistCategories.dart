import 'package:dispenser_ui/home/homePageManager.dart';
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

  List<bool> isSelected = List<bool>();
  List<Color> mycolors = List<Color>();

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

  bool anySelected() {
    for (int i = 0; i < isSelected.length; i++) if (isSelected[i]) return true;
    return false;
  }

  bool allSelected() {
    for (int i = 0; i < isSelected.length; i++)
      if (!isSelected[i]) return false;
    return true;
  }

  void selected(int i) {
    print("length is ${isSelected.length}");
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

  Widget deleteIconButton() {
    for (bool selected in isSelected)
      if (selected)
        return IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => deleteWishlists(),
        );
    return Container();
  }

  void deleteWishlists() {
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

  Widget topBar() {
    if (anySelected())
      return Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          child: Center(child: godfathersNameStyle("Wishlists")),
        ),
        Spacer(
          flex: 2,
        ),
        selectAllIconButton(),
        deleteIconButton(),
      ]);
    else
      return Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          child: Center(child: godfathersNameStyle("Wishlists")),
        ),
      ]);
  }

  @override
  Widget build(BuildContext context) {
    initializeIsSelected(manager.wishlists.wishlists.length);
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        Container(height: 45),
        topBar(),
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
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WishListItems(
                                        manager.wishlists.wishlists[index]))),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8 + 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: godfathersNameStyle(
                              'Wishlist ${manager.wishlists.wishlists[index].name}'),
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
