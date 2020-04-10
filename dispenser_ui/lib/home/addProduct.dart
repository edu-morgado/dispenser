import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';

class AddProduct extends StatefulWidget {
  final Manager manager;
  AddProduct(this.manager, {Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState(manager);
}

class _AddProductState extends State<AddProduct> {

  Manager manager;
  _AddProductState(this.manager);

  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameNode = FocusNode();  

  List<String> categories = [
    "fridge",
    "freeze",
    "storage",
    "custom"
  ];

  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  num value = 1;

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

  Widget chooseCategories() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, i) => ListTile(
        leading: Text(categories[i]),
        trailing: Checkbox(
            value: isChecked[i],
            onChanged: (bool value) {
              setState(() {
                isChecked[i] = value;
              });
            }),
      ),
    );
  }

  Widget addProductInventoryButton(BuildContext context) {
    List<ObjFoodItem> items = manager.foodItems.foodItems;
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          items.add(ObjFoodItem(1, _nameController.text,value ));
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
                    "Add a Product",
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
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.5,
              alignment: Alignment.topCenter,
              child: chooseCategories(),
            ),
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