import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';


class InventoryAdd extends StatefulWidget {
  
  final Manager manager;
  final String title;

  InventoryAdd(this.manager, {Key key, this.title}) : super(key: key);

  @override
  InventoryAddState createState() => new InventoryAddState(manager);
}

class InventoryAddState extends State<InventoryAdd> {
  Manager manager;

  InventoryAddState(this.manager);

  final FocusNode _nameNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  int _type;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');

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

  Widget nameInput(context) {
    return TextFormField(
      decoration:
          new InputDecoration(labelText: "Name", focusColor: Colors.grey[300]),
      focusNode: _nameNode,
      controller: _nameController,
      textInputAction: TextInputAction.next,
    );
  }

  Widget dropDownFormField() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: DropDownFormField(
              titleText: 'Choose a type',
              hintText: 'Please choose one',
              value: _type,
              onSaved: (value) {
                setState(() {
                  _type = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _type = value;
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
          ObjFoodRepository newFoodRepository = ObjFoodRepository(1, _type, _nameController.text);
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
  void initState() {
    super.initState();
    _type = 1;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add somgt"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: nameInput(context),
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.15,
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
