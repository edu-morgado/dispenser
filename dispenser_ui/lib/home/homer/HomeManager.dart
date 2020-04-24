import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/home/homer/category_column.dart';
import 'package:dispenser_ui/customizedwidgets/inventoryWishListTopBar.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:flutter/material.dart';

class HomeManager extends StatefulWidget {
  final Manager manager;
  HomeManager(this.manager);

  @override
  _HomeManagerState createState() => _HomeManagerState(this.manager);
}

class _HomeManagerState extends State<HomeManager> {
  Manager manager;
  final FocusNode _descNode = FocusNode();
  _HomeManagerState(this.manager);

  _doesN() {}

 
  userName() {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height*0.1,
      child: usersNameStyle("User: Dengue"),
    );
  }
   userDescription() {
    return Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.grey[200],
        child: smallTextStyle("House id:#c24983ibjdwc"),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.grey[200],
        child: smallTextStyle("User Description: Lisboa, 23"),
      ),
    ]);
  }


  categoryColumn() {
    return Column(
      children: <Widget>[
         smallTextStyle("Choose your Products Categories"),

          smallTextStyle(" according to your local Supermarket:"),
        Expanded(
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, i) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Center(
                          child: godfathersNameStyle(categories[i].title)),
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          border: Border.all(color: Colors.black87)),
                    ))),
      ],
    );
  }

  List<Category> categories = [
    const Category(title: 'Meat'),
    const Category(title: 'Fish'),
    const Category(title: 'Drinks'),
    const Category(title: 'Freezed Meals'),
    const Category(title: 'Clothes'),
  ];

  updateHome() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
          //r  alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    userName(),
                    userDescription(),
                  ],
                )),
          ),
          Expanded(
                      child: Container(
              width: MediaQuery.of(context).size.width,
              child: categoryColumn(),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  const Category({this.title});
  final String title;
}
