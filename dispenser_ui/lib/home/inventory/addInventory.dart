import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';

class AddProductToInventory extends StatefulWidget {
  final Manager manager;
  AddProductToInventory(this.manager, {Key key}) : super(key: key);

  @override
  _AddProductToInventoryState createState() => _AddProductToInventoryState(manager);
}

class _AddProductToInventoryState extends State<AddProductToInventory> {

  Manager manager;
  _AddProductToInventoryState(this.manager);
   final formKey = new GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode(); 



  List<dynamic> choices = [
    {
      "display": "Freezer",
      "value": 1,
    },
    {
      "display": "Fridge",
      "value": 2,
    },
    {
      "display": "Storage",
      "value": 3,
    },
  ];

  num value = 1;
  int _myActivity = 1;

  List<bool> isChecked = List<bool>() ;
  
  Widget counter() {
    return Counter(
      initialValue: value,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        print("onChanged beeing called");
        setState(() {
          value = value;
          print("default value -> $value");
        });
      },
    );
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
              value: _myActivity,
              onSaved: (value) {
                setState(() {
                  _myActivity = value;
                  print(value);
                });
              },
              onChanged: (value) {
                setState(() {
                  _myActivity = value;
                  print(value);
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

  Widget addProductInventoryButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          manager.foodItems.foodItems.add(ObjFoodItem(1, _nameController.text,value ));
          Navigator.of(context).pop();
        },
        child: Text(
          "Add Product",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i< manager.foodRepositories.repositories.length ; i++) 
      isChecked.add(false);
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
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: nameInput(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Text("How many to add")),
              SizedBox(
                width: 30,
              ),
              counter(),
            ],
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
              alignment: Alignment.topCenter,
              child: addProductInventoryButton(context),
            ),
          ),
        ],
      ),
    );
  }
}




class AddInventoryInventoryPage extends StatefulWidget {
  
  final Manager manager;
  final String title;

  AddInventoryInventoryPage(this.manager, {Key key, this.title}) : super(key: key);

  @override
  InventoryAddState createState() => new InventoryAddState(manager);
}

class InventoryAddState extends State<AddInventoryInventoryPage> {
   final formKey = new GlobalKey<FormState>();
   Manager manager;

 InventoryAddState(this.manager);
 
  int _myActivity = 1;
 


  List<dynamic> choices = [
    {
      "display": "Freezer",
      "value": 1,
    },
    {
      "display": "Fridge",
      "value": 2,
    },
    {
      "display": "Storage",
      "value": 3,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descNode = FocusNode();

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
              value: _myActivity,
              onSaved: (value) {
                setState(() {
                  _myActivity = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _myActivity = value;
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

  Widget addInventoryButton(BuildContext context) {

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          //loadHomePage(context);
        },
        child: Text(
          "Add",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

   Widget addFoodRepositoryButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          ObjFoodRepository newFoodRepository = ObjFoodRepository(1, 3,"ei");
          manager.foodRepositories.repositories.add(newFoodRepository);
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
          SizedBox(height: 10,),
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
              child: addFoodRepositoryButton(context),
            ),
          ),
        ],
      ),
    );
  }
}
