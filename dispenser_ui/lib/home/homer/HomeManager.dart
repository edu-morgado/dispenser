import 'package:dispenser_ui/ObjManager.dart';
import 'package:flutter/services.dart';
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

  userName() {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * 0.1,
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

  List<Category> categories = [
    const Category(title: 'Meat'),
    const Category(title: 'Fish'),
    const Category(title: 'Drink'),
    const Category(title: 'Fruit'),
    const Category(title: 'Vegetables'),
    const Category(title: 'Carbohydrates'),
    const Category(title: 'Cleaning'),
    const Category(title: 'Clothes'),
  ];

  updateHome() {
    setState(() {});
  }

  _category(index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(30.0)),
      child: Center(
        child: usersNameStyle(categories[index].title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //r  alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                userName(),
                userDescription(),
                Container(
                  height: MediaQuery.of(context).size.height*0.05,
                  child:
                      smallTextStyle("This are your custom Categories:"),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, i) => _category(i)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class Category {
  const Category({this.title});
  final String title;
}
