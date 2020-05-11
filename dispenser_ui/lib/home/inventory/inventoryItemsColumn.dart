import 'package:dispenser_ui/objects/Inventory.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';
import 'package:dispenser_ui/customizedwidgets/columnBuilder.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:flutter/services.dart';
import 'package:find_dropdown/find_dropdown.dart';

import 'package:dispenser_ui/Request.dart';

class FoodItemColumn extends StatefulWidget {
  final Function updateParentState;
  final ObjInventory inventory;
  FoodItemColumn(this.updateParentState, this.inventory);

  @override
  State<StatefulWidget> createState() {
    return FoodItemColumnState();
  }
}

class FoodItemColumnState extends State<FoodItemColumn> {
  num quantity = 1;
  int openedTileIndex = -1;
  List<bool> isChecked = List<bool>();
  List<dynamic> products = [];
  List<Widget> addTilesManager = new List<Widget>();

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameNode = FocusNode();

  void updateInventory() {
    for (int i = 0; i < widget.inventory.foodItems.length; i++) {
      ObjFoodItem foodItem = widget.inventory.foodItems[i];
      if (products[i]['name'] != foodItem.name ||
          products[i]['quantity'] != foodItem.quantity) {
        print("updating Inventory");
        foodItem.name = products[i]['name'];
        foodItem.quantity = products[i]['quantity'];
        Requests.updateFoodItem(foodItem);
      }
    }

    for (int i = widget.inventory.foodItems.length; i < products.length; i++) {
      ObjFoodItem newProduct = ObjFoodItem(
          products[i]['name'],
          products[i]['quantity'],
          "categoria dengada furira",
          DateTime.now(),
          DateTime.now());
      widget.inventory.foodItems.add(newProduct);
      print("Inventory id is ->${widget.inventory.id}");
      Requests.createFoodItemForInventory(newProduct, widget.inventory.id);
    }
  }

  void initializeAddTilesManager(BuildContext context) {
    if (addTilesManager.length == 0) {
      for (int i = 0; i < widget.inventory.foodItems.length; i++) {
        products.add({
          'name': widget.inventory.foodItems[i].name,
          'quantity': widget.inventory.foodItems[i].quantity
        });
        addTilesManager.add(addClosedTile(products[i], i, context));
      }
    }
  }

  void addTileToTiles(BuildContext context) {
    if (products.length != 0 && openedTileIndex != -1) {
      products[openedTileIndex] = {
        'name': _nameController.text,
        'quantity': quantity,
      };
      updateInventory();
      addTilesManager[openedTileIndex] =
          addClosedTile(products[openedTileIndex], openedTileIndex, context);
    }
    //save previous countent and turns it into a closed tile (about to open a tile and its a new one)

    quantity = 1;
    _nameController.text = "New Product";
    products.add({'name': _nameController.text, 'quantity': quantity});

    int lastElementIndex = products.length - 1;

    // adding a new product element for new input information, adding a n ADD tile to the end of widget list

    addTilesManager.add(
        addOpenedTile(products[lastElementIndex], lastElementIndex, context));

    // making the before-than-last tile the opened Tile using the last element of
    // information because last tile is the add button (doesnt neeed information)

    openedTileIndex = lastElementIndex;
    // opened tile before-than-last in widget list is now opened Tile
    widget.updateParentState();
  }

  Widget addTile(BuildContext context) {
    quantity = 1;
    return Container(
        child: ListTile(
          onTap: () => addTileToTiles(context),
          title: Center(child:smallTextStyle(
            'Add',
          ),),
        ),
        decoration: BoxDecoration(
          color: Colors.purple[100],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30.0)
        ));
  }

  Widget addOpenedTile(dynamic tileInfo, int ownIndex, BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            width: 300,
            child: nameInput(
              context,
              tileInfo['name'],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () {
              setState(() {
                products[ownIndex] = {
                  'name': _nameController.text,
                  'quantity': quantity,
                };
                updateInventory();

                addTilesManager[ownIndex] =
                    addClosedTile(products[ownIndex], ownIndex, context);
                openedTileIndex = -1;
              });
            },
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.11,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.cyan[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(child: counter(tileInfo['quantity'])),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.11,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.cyan[200],
                ),
                child: Form(
                  key: formKey,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(16),
                    child: FindDropdown(
                      items: ["Custom", "Fridge", "Freezer", "Storage"],
                      onChanged: (String item) => print(item),
                      selectedItem: "Custom",
                    ),
                  ),
                ),
              ),
            ]),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  final formKey = new GlobalKey<FormState>();

  Widget addClosedTile(dynamic tileInfo, int newIndex, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.purple[50],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30.0)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (openedTileIndex != -1) {
            products[openedTileIndex] = {
              'name': _nameController.text,
              'quantity': quantity,
            };
            updateInventory();

            addTilesManager[openedTileIndex] = addClosedTile(
                products[openedTileIndex], openedTileIndex, context);
            addTilesManager[newIndex] =
                addOpenedTile(products[newIndex], newIndex, context);
            _nameController.text = products[newIndex]["name"];
            quantity = products[newIndex]["quantity"];
          } else {
            addTilesManager[newIndex] =
                addOpenedTile(products[newIndex], newIndex, context);
          }
          openedTileIndex = newIndex;
          widget.updateParentState();
        },
        child: ListTile(
          leading: Icon(Icons.navigate_next),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${tileInfo['name']}      ',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              Text(
                '${tileInfo['quantity']}      ',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          subtitle: Text("  Category:"),
          trailing: IconButton(
            onPressed: () {
              print("deleting now");
              // Remove info from products, widget from addTilesManager, remove from local storage and in data base
              Requests.deleteFoodItem(widget.inventory.foodItems[newIndex]);
              widget.inventory.foodItems.removeAt(newIndex);
              openedTileIndex = -1;
              setState(() {
                addTilesManager = [];
                products = [];
              });
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  Widget counter(int initialValue) {
    quantity = initialValue;
    return Counter(
      initialValue: initialValue,
      selectedValue: initialValue,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        quantity = value;
        setState(() {});
      },
    );
  }

  Widget nameInput(context, String name) {
    _nameController.text = name;
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _nameNode,
        textInputAction: TextInputAction.done,
        controller: _nameController,
        onEditingComplete: () {
          //loadHomePage(context);
        },
        decoration: new InputDecoration(
          hasFloatingPlaceholder: false,
          labelText: 'Product Name',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        inputFormatters: [new LengthLimitingTextInputFormatter(35)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeAddTilesManager(context);
    return Column(children: <Widget>[
      SafeArea(
        child: Container(
          child: ColumnBuilder(
              itemCount: addTilesManager.length,
              itemBuilder: (context, i) => addTilesManager[i]),
        ),
      ),
      addTile(context)
    ]);
  }
}
