import 'package:dispenser_ui/textStyles.dart';
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
  final formKey = new GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
   _nameController.dispose();
   _nameNode.dispose();
    super.dispose();
  }
  final FocusNode _nameNode = FocusNode();

  num quantity = 1;
  num section = 1;
  int inventoryIndex = 1;

  List<bool> isChecked = List<bool>();
  List<dynamic> choices = List<dynamic>();

  List<dynamic> products = [];

  int openedTile = 1;
  List<Widget> addTilesManager = new List<Widget>();

  void initializeAddTilesManager() {
    if (addTilesManager.length == 0) {
      addTilesManager.add(Divider(
          thickness:
              3)); // cute UI feature that fucks the indexes up (not best way to do probably)
      quantity = 1;
      _nameController.text = "New Product";
      products.add({
        'name': _nameController.text,
        'quantity': quantity
      }); // first tile appears already open

      addTilesManager.add(addOpenedTile(products[0]));
      addTilesManager.add(Container(
          child: ListTile(
            onTap: () => addTileToTiles(),
            title: dispenserButton("Add "),
          ),
          decoration: BoxDecoration(color: Colors.black12)));
    }
  }

  void addTileToTiles() {
    if (products.length != 0) {
      products[openedTile - 1] = {
        'name': _nameController.text,
        'quantity': quantity,
      };
      addTilesManager[openedTile] =
          addClosedTile(products[openedTile - 1], openedTile);
    }
    //save previous countent and turns it into a closed tile (about to open a tile and its a new one)

    quantity = 1;
    _nameController.text = "New Product";
    products.add({'name': _nameController.text, 'quantity': quantity});
    addTilesManager.add(addTile());
    // adding a new product element for new input information, adding an ADD tile to the end of widget list

    addTilesManager[addTilesManager.length - 2] =
        addOpenedTile(products[products.length - 1]);
    // making the before-than-last tile the opened Tile using the last element of
    // information because last tile is the add button (doesnt neeed information)

    openedTile = addTilesManager.length - 2;
    // opened tile before-than-last in widget list is now opened Tile
    setState(() {});
  }

  Widget addTile() {
    return Container(
        child: ListTile(
          onTap: () => addTileToTiles(),
          title: dispenserButton(
            "Add ",
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
        ));
  }

  Widget addOpenedTile(dynamic tileInfo) {
    return Column(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.1,
            child: nameInput(
              context,
              tileInfo['name'],
            ),
          ),
        ),
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

  Widget addClosedTile(dynamic tileInfo, int newIndex) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.cyan[100],
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(5.0)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          products[openedTile - 1] = {
            'name': _nameController.text,
            'quantity': quantity,
          };
          addTilesManager[openedTile] =
              addClosedTile(products[openedTile - 1], openedTile);
          addTilesManager[newIndex] = addOpenedTile(products[newIndex - 1]);
          _nameController.text = products[newIndex - 1]["name"];
          quantity = products[newIndex - 1]["quantity"];
          openedTile = newIndex;
          setState(() {});
        },
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dispenserDescription(
                  '${tileInfo['quantity']}x ${tileInfo['name']}')
            ],
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
        children: [
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

    initializeAddTilesManager();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Flex(
        direction: Axis.vertical,
        children: [
          Row(children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: godfathersNameStyle(
                    "Add Product to Inventory",
                  ),
                ))
          ]),
          Expanded(
            child: SafeArea(
              child: ListView.builder(
                  itemCount: addTilesManager.length,
                  itemBuilder: (context, i) => addTilesManager[i]),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topCenter,
              child: addProductInventoryButton(context, manager),
            ),
          ),
          SizedBox(height: 20)
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
  @override
  void dispose() {
   _descNode.dispose();
   _nameNode.dispose();
    super.dispose();
  }

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
        children: [
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
          Row(children: [
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
            children: [
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
