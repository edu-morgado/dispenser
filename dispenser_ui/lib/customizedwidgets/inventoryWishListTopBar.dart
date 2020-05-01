import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ObjManager.dart';
import '../textStyles.dart';

class TopBar extends StatelessWidget {
  TopBar(this.updateParent, this.manager, this.context, this.isSelected,
      this.name);
  Function updateParent;
  Manager manager;
  List<bool> isSelected;
  BuildContext context;
  String name;

  Widget deleteIconButton(Manager manager) {
    return IconButton(
      icon: Icon(Icons.delete_outline),
      onPressed: () => deleteFoodRepositories(manager),
    );
  }

  void deleteFoodRepositories(Manager manager) {
    int i;

    for (i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        manager.inventories.inventories.removeAt(i);
        isSelected.removeAt(i);
        i = -1;
      }
    }
    updateParent();
  }

  void setEverythingToSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = true;
    updateParent();
  }

  void setEverythingToNotSelected() {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = false;
    updateParent();
  }

  bool allSelected() {
    for (int i = 0; i < isSelected.length; i++)
      if (!isSelected[i]) return false;
    return true;
  }

  Widget selectAllIconButton() {
    return Checkbox(
        value: allSelected(),
        onChanged: (bool value) {
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

  int inventoryNumbSelected() {
    int n = 0;
    for (int i = 0; i < isSelected.length; i++) if (isSelected[i]) n++;
    return n;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          height: anySelected() ? MediaQuery.of(context).size.height * 0.15 : 0,
          duration: Duration(milliseconds: 300,),
          curve: Curves.fastOutSlowIn,
          child: Center(child: godfathersTextStyle("$name")),
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.circular(20.0),
            ),
          ),
        ),
        if (anySelected())
          AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            height: anySelected() ? MediaQuery.of(context).size.height * 0.05 : 0,
            duration: Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: selectAllIconButton()),
                dispenserDescription(
                    "${inventoryNumbSelected()} $name Selected"),
                Expanded(child: Container()),
                deleteIconButton(manager),
              ],
            ),
          ),
      ],
    );
  }
}
