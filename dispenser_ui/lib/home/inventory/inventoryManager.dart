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

  List<String> inventoryItem = [
    "fridge",
    "freezer",
    "storage",
  ];

  void loadAddInventory(BuildContext context) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => AddInventoryInventoryPage(manager));
    Navigator.of(context).push(route);
  }

  void selectedForDeletion(int i) {
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

  Widget deleteIconButton() {
    print("in function deleteIconbutton");
    for (int i = 0; i < isSelected.length; i++)
      if (isSelected[i])
        return IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => deleteFoodRepositories(),
        );

    return Container();
  }

  void deleteFoodRepositories(){
    int i;
    setState(() {
      for ( i = 0; i < isSelected.length; i++){
        print("inside for removing items");
        if (isSelected[i]){
          manager.foodRepositories.repositories.removeAt(i);
          i = 0;
          isSelected = [];
          for (int i = 0; i < manager.foodRepositories.repositories.length; i++)
            isSelected.add(false);
        }
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < manager.foodRepositories.repositories.length; i++)
      isSelected.add(false);

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
            child: Center(child: godfathersNameStyle("Inventory")),
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
