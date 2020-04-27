
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/objects/WishList.dart';
import 'package:dispenser_ui/Request.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:dispenser_ui/customizedwidgets/inventoryWishListTopBar.dart';

class AddWishListPage extends StatefulWidget {
  @override
  WishListAddState createState() => new WishListAddState();
}

class WishListAddState extends State<AddWishListPage> {
  final formKey = new GlobalKey<FormState>();

  WishListAddState();

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

  void initializeChoices(List<ObjWishList> wishlists) {
    for (int i = 0; i < wishlists.length; i++) {
      choices.add({
        'display': wishlists[i].name,
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
            child: FindDropdown(
              items: ["Custom","Fridge", "Freezer", "Storage"],
              label: "Type of WishList",
              onChanged: (String item) => print(item),
              selectedItem: "Custom",
            ),
          ),
        ],
      ),
    );
  }

  Widget addWishList(BuildContext context, Manager manager) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.purple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          ObjWishList newWishList =
              ObjWishList(_nameController.text, DateTime.now(), DateTime.now());
          
          manager.wishlists.wishlists.add(newWishList);
          Requests.createWishList(newWishList).then((bool created) {
            print("WishList created? -> $created");
          });
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

   void update() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final Manager manager = Provider.of<Manager>(context);

    initializeChoices(manager.wishlists.wishlists);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              color: Colors.purple[100],
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
          TopBar(update, manager, context, [] , "Add new WishList"),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: nameInput(context),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.topLeft,
                child: dropDownFormField()),
          ),
          SizedBox(height:100),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: addWishList(context, manager),
            ),
          ),
        ],
      ),
    );
  }
}
