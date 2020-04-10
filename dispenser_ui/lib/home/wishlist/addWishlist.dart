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
  final TextEditingController _nameController = TextEditingController();
  Manager manager;
  _AddProductState(this.manager);
  final FocusNode _nameNode = FocusNode();


  num _defaultValue = 1;
  List<String> categories = [
    "category 1",
    "category 2",
    "category 3",
    "category 4",
    " category 5",
    "category 6",
    "category 7"
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

  Widget counter() {
    return Counter(
      initialValue: _defaultValue,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        print("onChanged beeing called");
        setState(() {
          _defaultValue = value;
          print("default value -> $_defaultValue");
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
                //IF ELSE PARA TIRAR E POR DA CATEGORIA SELECIONADA
              });
            }),
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
          ObjFoodItem newFoodItem = ObjFoodItem(1, _nameController.text, _defaultValue );
          manager.foodItems.foodItems.add(newFoodItem);
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
              child: addProductToWishListButton(context),
            ),
          ),
        ],
      ),
    );
  }
}

class AddCategoryWishlist extends StatefulWidget {
final Manager manager;

  AddCategoryWishlist(this.manager,{Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState(manager);
}

class _AddCategoryState extends State<AddCategoryWishlist> {
  final formKey = new GlobalKey<FormState>();
  Manager manager;
 
 _AddCategoryState(this.manager);

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
          ObjWishlist newWishlist = ObjWishlist(1, _nameController.text);
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
