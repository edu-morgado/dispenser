import 'package:dispenser_ui/home/inventory/inventoryItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/home/inventory/addInventory.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/textStyles.dart';

class Inventory extends StatefulWidget {
  final Manager manager;

  Inventory(this.manager);

  @override
  State<StatefulWidget> createState() {
    return InventoryState(manager);
  }
}

class InventoryState extends State<Inventory> {
  Manager manager;

  InventoryState(this.manager);

  List<bool> isSelected = List<bool>();

  void selectedForDeletion(int i) {
    if (isSelected.length == 0)
      initializeIsSelected(manager.foodRepositories.repositories.length);
    setState(() {
      if (isSelected[i]) {
        print("INDEX -> $i not selected for deletion");
        isSelected[i] = false;
      } else {
        isSelected[i] = true;
        print("INDEX -> $i  selected for deletion");
      }
    });
  }

  void initializeIsSelected(int size) {
    for (int i = 0; i < size; i++) isSelected.add(false);
  }

  Widget deleteIconButton() {
    print("in function deleteIconbutton");
    for (int i = 0; i < isSelected.length; i++)
      if (isSelected[i])
        return IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => deleteRepository(),
        );

    return Container();
  }

  void deleteRepository() {
    int i;
    setState(() {
      for (i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          manager.foodRepositories.repositories.removeAt(i);
          isSelected.removeAt(i);
          i = -1;
        }
      }
    });
  }

  Widget selectAllIconButton() {
    print("in function selectIconbutton");
    for (int i = 0; i < isSelected.length; i++)
      if (isSelected[i])
        return IconButton(
          icon: Icon(Icons.select_all),
          onPressed: () =>
              selectAll(manager.foodRepositories.repositories.length),
        );

    return Container();
  }

  void selectAll(int size) {
    for (int i = 0; i < size; i++) isSelected.add(true);
  }

  Widget selectedBar() {
    return Row(children: [
      selectAllIconButton(),
      deleteIconButton(),
    ]);
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
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            child: Center(child: godfathersNameStyle("Inventory")),
          ),
           Spacer(flex:1),
          selectedBar(),
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
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InventoryItem(manager.foodRepositories
                                        .repositories[index]))),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8 + 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/inventory/${manager.foodRepositories.repositories[index].ttype}.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: manager.foodRepositories.repositories.length,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
