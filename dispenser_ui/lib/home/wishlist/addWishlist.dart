import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';
import 'package:dispenser_ui/ObjManager.dart';

class AddCategoryWishlist extends StatefulWidget {
final Manager manager;

  AddCategoryWishlist(this.manager,{Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState(manager);
}

class _AddCategoryState extends State<AddCategoryWishlist> {
  final formKey = new GlobalKey<FormState>();
  Manager manager;
  int _myActivity;
 
 _AddCategoryState(this.manager);

  @override
  void initState() {
    _myActivity = 1;
    super.initState();
  }

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descNode = FocusNode();

  Widget nameInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _nameNode,
        textInputAction: TextInputAction.done,
        controller: _passwordController,
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


  Widget addCategoryButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
           FocusScope.of(context).unfocus();
          ObjFoodItem newFoodRepository = ObjFoodItem(1,"ei", 3);
          manager.foodItems.foodItems.add(newFoodRepository);
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
              child: addCategoryButton(context),
            ),
          ),
        ],
      ),
    );
  }
}
