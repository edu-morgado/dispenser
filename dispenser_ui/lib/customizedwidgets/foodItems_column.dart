import 'package:flutter/material.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';
import 'package:dispenser_ui/customizedwidgets/columnBuilder.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';

import '../Request.dart';

class FoodItemColumn extends StatefulWidget {
  final Function updateParentState;
  final dynamic repository;
  FoodItemColumn(this.updateParentState, this.repository);

  @override
  State<StatefulWidget> createState() {
    return FoodItemColumnState();
  }
}

class FoodItemColumnState extends State<FoodItemColumn> {
  num quantity = 1;
  int openedTile = -1;
  List<bool> isChecked = List<bool>();
  List<dynamic> products = [];
  List<Widget> addTilesManager = new List<Widget>();

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameNode = FocusNode();

  void updateRepository() {
    for (int i = 0; i < widget.repository.foodItems.length; i++) {
      ObjFoodItem foodItem = widget.repository.foodItems[i];
      if (products[i]['name'] != foodItem.name ||
          products[i]['quantity'] != foodItem.quantity) {
        print("updating repository");
        foodItem.name = products[i]['name'];
        foodItem.quantity = products[i]['quantity'];
        Requests.updateFoodItem(foodItem);
      }
    }

    for(int i =  widget.repository.foodItems.length; i < products.length ; i++) {
      ObjFoodItem newProduct = ObjFoodItem(products[i]['name'], products[i]['quantity'], "categoria dengada furira", DateTime.now(), DateTime.now());
      widget.repository.foodItems.add(newProduct);
      Requests.createFoodItemForInventory(newProduct, widget.repository.id);
    }
  }

  void initializeAddTilesManager(BuildContext context) {
    if (addTilesManager.length == 0) {
      addTilesManager.add(Divider(
          thickness:
              3)); // cute UI feature that fucks the indexes up (not best way to do probably)

      for (int i = 0; i < widget.repository.foodItems.length; i++) {
        products.add({
          'name': widget.repository.foodItems[i].name,
          'quantity': widget.repository.foodItems[i].quantity
        });
        addTilesManager.add(addClosedTile(products[i], i + 1, context));
      }

      addTilesManager.add(Container(
          child: ListTile(
            onTap: () => addTileToTiles(context),
            title: Text(
              "Add ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat'),
            ),
          ),
          decoration: BoxDecoration(color: Colors.black12)));
    }
  }

  void addTileToTiles(BuildContext context) {
    if (products.length != 0 && openedTile != -1) {
      products[openedTile - 1] = {
        'name': _nameController.text,
        'quantity': quantity,
      };
      updateRepository();
      addTilesManager[openedTile] =
          addClosedTile(products[openedTile - 1], openedTile, context);
    }
    //save previous countent and turns it into a closed tile (about to open a tile and its a new one)

    quantity = 1;
    _nameController.text = "New Product";
    products.add({'name': _nameController.text, 'quantity': quantity});
    addTilesManager.add(addTile(context));
    // adding a new product element for new input information, adding an ADD tile to the end of widget list

    addTilesManager[addTilesManager.length - 2] = addOpenedTile(
        products[products.length - 1], addTilesManager.length - 2, context);
    // making the before-than-last tile the opened Tile using the last element of
    // information because last tile is the add button (doesnt neeed information)

    openedTile = addTilesManager.length - 2;
    // opened tile before-than-last in widget list is now opened Tile
    widget.updateParentState();
  }

  Widget addTile(BuildContext context) {
    return Container(
        child: ListTile(
          onTap: () => addTileToTiles(context),
          title: Text(
            'Add',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                fontFamily: 'Montserrat'),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
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
                products[openedTile - 1] = {
                  'name': _nameController.text,
                  'quantity': quantity,
                };
                updateRepository();

                addTilesManager[ownIndex] =
                    addClosedTile(products[openedTile - 1], ownIndex, context);
                openedTile = -1;
              });
            },
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.cyan[300],
              borderRadius: BorderRadius.circular(30.0)),
          child: Center(child: counter(tileInfo['quantity'])),
        ),
        SizedBox(height: 20)
      ],
    );
  }

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
          if (openedTile != -1) {
            products[openedTile - 1] = {
              'name': _nameController.text,
              'quantity': quantity,
            };
            updateRepository();

            addTilesManager[openedTile] =
                addClosedTile(products[openedTile - 1], openedTile, context);
            addTilesManager[newIndex] =
                addOpenedTile(products[newIndex - 1], newIndex, context);
            _nameController.text = products[newIndex - 1]["name"];
            quantity = products[newIndex - 1]["quantity"];
          } else {
            addTilesManager[newIndex] =
                addOpenedTile(products[newIndex - 1], newIndex, context);
          }
          openedTile = newIndex;
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
            onPressed: () => print("need to delete it"),
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  Widget counter(int initialValue) {
    return Counter(
      initialValue: initialValue,
      selectedValue: initialValue,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        quantity = value;
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeAddTilesManager(context);
    return SafeArea(
      child: ColumnBuilder(
          itemCount: addTilesManager.length,
          itemBuilder: (context, i) => addTilesManager[i]),
    );
  }
}
