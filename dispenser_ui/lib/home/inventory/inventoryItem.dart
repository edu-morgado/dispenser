import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dispenser_ui/textStyles.dart';

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

  Widget topBar() {
    if (anySelected())
      return Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          child: Center(child: godfathersNameStyle(repository.name)),
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
          child: Center(child: godfathersNameStyle(repository.name)),
        ),
      ]);
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
        Container(height: 45),
        topBar(),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
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
