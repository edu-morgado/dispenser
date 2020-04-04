import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class InventoryAdd extends StatefulWidget {
  InventoryAdd({Key key, this.title}) : super(key: key);
  final String title;

  @override
  InventoryAddState createState() => new InventoryAddState();
}

class InventoryAddState extends State<InventoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _typeNode = FocusNode();
  int _myActivity;
  int _myActivityResult;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');

  Widget nameInput(context) {
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Name",
        focusColor: Colors.grey[300]
      ),
      focusNode: _nameNode,
      controller: _nameController,
      textInputAction: TextInputAction.next,
    );
  }

  @override
  void initState() {
    super.initState();
    _myActivity = 1;
    _myActivityResult = 1;
  }

  _saveForm() {
    setState(() {
      _myActivityResult = _myActivity;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameNode.dispose();
    _typeController.dispose();
    _typeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
              Container(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                
                child: Center(
                  child: nameInput(context)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: DropDownFormField(
                  titleText: 'Type Of Inventory',
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
                  dataSource: [
                    {
                      "display": "Fridge",
                      "value": 1,
                    },
                    {
                      "display": "Freezer",
                      "value": 2,
                    },
                    {
                      "display": "Storage",
                      "value": 3,
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text("$_myActivityResult"),
              ),  
            ]),
          ),
        ),
      ),
    );
  }
}
