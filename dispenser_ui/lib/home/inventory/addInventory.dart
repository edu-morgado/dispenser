import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/Inventory.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';

class AddProductToInventory extends StatefulWidget {
  @override
  _AddProductToInventoryState createState() => _AddProductToInventoryState();
}

class _AddProductToInventoryState extends State<AddProductToInventory> {
  _AddProductToInventoryState();

  final formKey = new GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode();

  num quantity = 1;
  num section = 1;
  int inventoryIndex = 1;

  List<bool> isChecked = List<bool>();
  List<dynamic> choices = List<dynamic>();

  List<dynamic> products = [];

  int openedTile = -1;
  List<Widget> addTilesManager = new List<Widget>();

  @override
  void initState() {
    addTilesManager.add(ListTile(
      onTap: () => addTileToTiles(),
      title: Text(
        "Add ",
        textAlign: TextAlign.center,
      ),
    ));
    super.initState();
  }

  Widget addTile() {
    return ListTile(
      onTap: () => addTileToTiles(),
      title: Text(
        "Add ",
        textAlign: TextAlign.center,
      ),
    );
  }

  void addTileToTiles() {
    //save previous countent
    
    if (products.length != 0) {
      products[openedTile] = {
        'name': _nameController.text,
        'quantity': quantity,
      };
        addTilesManager[openedTile] = addClosedTile(products[openedTile], openedTile);
    }
    products.add({'name': "", 'quantity': 1});
    quantity = 1;
    addTilesManager.add(addTile());
    addTilesManager[addTilesManager.length - 2] =
        addOpenedTile(products[products.length - 1], addTilesManager.length);

    openedTile = addTilesManager.length - 2;

    setState(() {});
  }

  Widget addOpenedTile(dynamic tileInfo, int index) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(child: counter(tileInfo['quantity'])),
        ),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.05,
          child: nameInput(
            context,
            tileInfo['name'],
          ),
        ))
      ],
    );
  }

  Widget addClosedTile(dynamic tileInfo, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: InkWell(
        onTap: () {
          products[openedTile] = {
          'name': _nameController.text,
          'quantity': quantity,
          };
          addTilesManager[openedTile] = addClosedTile(products[openedTile], openedTile);
          addTilesManager[index] = addOpenedTile(products[index], index);

          openedTile = index;
          setState(() {});
        },
        child: ListTile(
          title: Row(
            children: [
              Text('Name:${tileInfo['name']} Quantity${tileInfo['quantity']}')
            ],
          ),
        ),
      ),
    );
  }

  void initializeChoices(List<ObjInventory> inventories) {
    for (int i = 0; i < inventories.length; i++) {
      choices.add({
        'display': inventories[i].name,
        'value': i,
      });
    }
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
        print("onChanged beeing called");
        quantity = value;
        print("quantity -> $quantity");
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

  Widget dropDownFormField() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: DropDownFormField(
              titleText: 'Choose a type',
              hintText: 'Please choose one',
              value: inventoryIndex,
              onSaved: (value) {
                setState(() {
                  inventoryIndex = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  inventoryIndex = value;
                });
              },
              dataSource: choices,
              textField: 'display',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget chooseSection(List<ObjInventory> repository) {
    return ListView.builder(
      itemCount: repository.length,
      itemBuilder: (context, i) => ListTile(
        leading: Text(repository[i].name),
      ),
    );
  }

  Widget addProductInventoryButton(BuildContext context, Manager manager) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          ObjFoodItem newItem =
              ObjFoodItem(1, _nameController.text, quantity, section);
          manager.foodItems.foodItems.add(newItem);
          manager.inventories.inventories[inventoryIndex].foodItems
              .add(newItem);
          print(manager.inventories.inventories[inventoryIndex].foodItems[0]
              .toString());
          Navigator.of(context).pop();
        },
        child: Text(
          "Add Products",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Manager manager = Provider.of<Manager>(context);

    List<ObjInventory> inventories = manager.inventories.inventories;
    initializeChoices(inventories);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Flex(
        direction: Axis.vertical,
        children: [
          Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.15,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
          Row(children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Add Product to Inventory",
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ]),
          Expanded(
            child: ListView.builder(
                itemCount: addTilesManager.length,
                itemBuilder: (context, i) => addTilesManager[i]),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topCenter,
              child: addProductInventoryButton(context, manager),
            ),
          ),
          Container(
            height: 90,
          )
        ],
      ),
    );
  }
}

class AddInventoryPage extends StatefulWidget {
  @override
  InventoryAddState createState() => new InventoryAddState();
}

class InventoryAddState extends State<AddInventoryPage> {
  final formKey = new GlobalKey<FormState>();

  InventoryAddState();

  int ttype = 1;

  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descNode = FocusNode();

  List<dynamic> choices = List<dynamic>();

  void initializeChoices(List<ObjInventory> inventories) {
    for (int i = 0; i < inventories.length; i++) {
      choices.add({
        'display': inventories[i].name,
        'value': i,
      });
    }
  }

  Widget nameInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _nameNode,
        textInputAction: TextInputAction.done,
        controller: _nameController,
        validator: (value) {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          //loadHomePage(context);
        },
        decoration: new InputDecoration(
          labelText: 'Name',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget descriptionInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _descNode,
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          //loadHomePage(context);
        },
        decoration: new InputDecoration(
          labelText: 'Description',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
        ),
      ),
    );
  }

  Widget dropDownFormField() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: DropDownFormField(
              titleText: 'Choose a type',
              hintText: 'Please choose one',
              value: ttype,
              onSaved: (value) {
                setState(() {
                  ttype = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  ttype = value;
                });
              },
              dataSource: choices,
              textField: 'display',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget addFoodRepositoryButton(BuildContext context, Manager manager) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          ObjInventory newFoodRepository = ObjInventory(1, ttype, "ei");
          manager.inventories.inventories.add(newFoodRepository);
          Navigator.of(context).pop();
        },
        child: Text(
          "Add Food Repository",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Manager manager = Provider.of<Manager>(context);

    initializeChoices(manager.inventories.inventories);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.15,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
          Row(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Inventory",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: nameInput(context),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: descriptionInput(context),
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.topLeft,
                child: dropDownFormField()),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: addFoodRepositoryButton(context, manager),
            ),
          ),
        ],
      ),
    );
  }
}
