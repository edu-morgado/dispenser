import 'package:dispenser_ui/home/inventory/inventoryItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:provider/provider.dart';

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
  

  @override
  void initState() {
    manager.loadInventoriesFromFile().then((bool hasUpdated){
      if (manager.inventories != null)
      {
        print("we have loaded the inventories from disk");
        print(manager.inventories.toJson());
        
      }
      if(mounted && hasUpdated) setState(() {
        print("now its setting state");
      });
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
      onPressed: () => deleteFoodRepositories(manager),
    );
  }

  void deleteFoodRepositories(Manager manager) {
    int i;
    setState(() {
      for (i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          manager.inventories.inventories.removeAt(i);
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

  Widget topBar(Manager manager) {
    if (anySelected())
      return Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          child: Center(child: godfathersNameStyle("Inventory")),
        ),
        Spacer(
          flex: 2,
        ),
        selectAllIconButton(),
        deleteIconButton(manager),
      ]);
    else
      return Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          child: Center(child: godfathersNameStyle("Inventory")),
        ),
      ]);
  }

  @override
  Widget build(BuildContext context) {

    initializeIsSelected(manager.inventories.inventories.length);
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        Container(height: 45),
        topBar(manager),
        SizedBox(width: 75),
        Container(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: manager.inventories.inventories.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                  onLongPress: () => selected(index),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          InventoryItem(manager.inventories.inventories[index]))),
                  child: Stack(alignment: Alignment.topRight, children: [
                    Container(
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
