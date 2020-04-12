import 'package:dispenser_ui/objects/Wishlist.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';
import 'package:dispenser_ui/ObjManager.dart';


class AddProductToWishList extends StatefulWidget {
  final Manager manager;
  AddProductToWishList(this.manager,{Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState(manager);
}

class _AddProductState extends State<AddProductToWishList> {
  Manager manager;

  _AddProductState(this.manager);


  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();


  num quantity = 1;
  num section=1;
  List<bool> isSelected = List<bool>();

  void initializeIsSelected(int size){
    if(isSelected.length == 0)
      for(int i =0 ; i< size ; i++) isSelected.add(false);
  }

  void setEverythingToSelected(){
    for(int i = 0 ; i < isSelected.length ; i++) isSelected[i] = true;
  }

  void setEverythingToNotSelected(){
    for(int i = 0 ; i < isSelected.length ; i++) isSelected[i] = false;
  }


  Widget counter() {
    return Counter(
      initialValue: quantity,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        setState(() {
          quantity = value;
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

  Widget chooseWishLists(List<ObjWishList> wishlists) {
    return ListView.builder(
      itemCount: wishlists.length,
      itemBuilder: (context, i) => ListTile(
        leading: Text(manager.wishlists.wishlists[i].name),
        trailing: Checkbox(
            value: isSelected[i],
            onChanged: (bool value) {
              selected(i);
            }),
      ),
    );
  }

  void selected(int i) {

    setState(() {
       if (isSelected[i]) {
        print("INDEX -> $i not selected ");
        isSelected[i] = false;
      } else {
        isSelected[i] = true;
        print("INDEX -> $i  selected");
      }
    });

  }

Widget chooseSection(List<ObjWishList> wishlists) {
    return ListView.builder(
      itemCount: wishlists.length,
      itemBuilder: (context, i) => ListTile(
        leading: Text(manager.wishlists.wishlists[i].name),
      ),
    );
  }

  Widget addProductToWishListButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          ObjFoodItem newFoodItem = ObjFoodItem(1, _nameController.text, quantity, section);
          manager.foodItems.foodItems.add(newFoodItem);
          for(int i = 0; i < manager.wishlists.wishlists.length; i++){
            if(isSelected[i])
            {
              print("item $i is checked ???");
              manager.wishlists.wishlists[i].foodItems.add(newFoodItem);
            }
          }
          Navigator.of(context).pop();
        },
        child: Text(
          "Add",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ObjWishList> wishlists = manager.wishlists.wishlists;
    initializeIsSelected(wishlists.length);

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
                    "Product",
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
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.topCenter,
              child: chooseWishLists(wishlists),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.topCenter,
              child: chooseSection(wishlists),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topCenter,
              child: addProductToWishListButton(context),
            ),
          ),
        ],
      ),
    );
  }
}

class AddWishList extends StatefulWidget {
final Manager manager;

  AddWishList(this.manager,{Key key}) : super(key: key);

  @override
  _AddWishListState createState() => _AddWishListState(manager);
}

class _AddWishListState extends State<AddWishList> {
  final formKey = new GlobalKey<FormState>();
  Manager manager;
 
 _AddWishListState(this.manager);

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
          if (value.length < 3) {
            return ' Name must be at least 3 characters long';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
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


  Widget addWishlistButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
           FocusScope.of(context).unfocus();
          ObjWishList newWishlist = ObjWishList(1, _nameController.text);
          manager.wishlists.wishlists.add(newWishlist);
          Navigator.of(context).pop();
        },
        child: Text(
          "Add",
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
                      "Wishlist",
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
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.topLeft,
              child: addWishlistButton(context),
            ),
          ),
        ],
      ),
    );
  }
}
