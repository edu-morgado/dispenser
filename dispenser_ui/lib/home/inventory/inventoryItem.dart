import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InventoryItem extends StatefulWidget {
  final ObjFoodRepository repository;

  InventoryItem(this.repository);

  @override
  _InventoryItemState createState() => _InventoryItemState(repository);
}

class _InventoryItemState extends State<InventoryItem> {
  ObjFoodRepository repository;

  _InventoryItemState(this.repository);

  List<bool> isSelected = List<bool>();

  void initializeIsSelected(int size) {
    if (isSelected.length != size )
      for (int i = isSelected.length; i < size; i++) isSelected.add(false);
  }

  void setEverythingToSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = true;
  }

  void setEverythingToNotSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = false;
  }

  void selected(int i) {
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
          onPressed: () => deleteFoodItems(),
        );

    return Container();
  }

  void deleteFoodItems() {
    int i;
    setState(() {
      for (i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          repository.foodItems.removeAt(i);
          isSelected.removeAt(i);
          i = -1;
        }
      }
    });
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > repository.foodItems.length)
      newIndex = repository.foodItems.length;
    if (oldIndex < newIndex) newIndex--;

    ObjFoodItem item1 = repository.foodItems[oldIndex];
    repository.foodItems[oldIndex] = repository.foodItems[newIndex];
    repository.foodItems[newIndex] = item1;
    setState(() {});
  }

  foodInformation(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "ATENÇÃO",
      desc: "Comida dengada",
      buttons: [
        DialogButton(
          child: Text(
            "Terminal sessão.",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    initializeIsSelected(repository.foodItems.length);
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.15,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Spacer(),
          deleteIconButton(),
        ]),
        Row(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  repository.name,
                  style: TextStyle(fontSize: 20),
                ),
              ))
        ]),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.topLeft,
          child: ReorderableListView(
              onReorder: (oldIndex, newIndex) => reorder(oldIndex, newIndex),
              children: [
                for (int i = 0; i < repository.foodItems.length; i++)
                  InkWell(
                    key: ValueKey(i),
                    onTap: () => foodInformation(context),
                    child: ListTile(
                      leading: Icon(Icons.navigate_next),
                      title: Text(repository.foodItems[i].name),
                      subtitle: Text("Quantity:" +
                          repository.foodItems[i].quantity.toString()),
                      trailing: Checkbox(
                          value: isSelected[i],
                          onChanged: (bool value) {
                            selected(i);
                          }),
                    ),
                  ),
              ]),
        )),
      ]),
    );
  }
}
