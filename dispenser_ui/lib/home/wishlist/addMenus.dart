import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  num _counter = 0;
  num _defaultValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add smtg"),
      ),
      body: Container(),
    );
  }
}

class AddCategory extends StatefulWidget {
  AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  num _counter = 0;
  num _defaultValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add somgt"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Container(child: Icon(Icons.note, size: 40)),
              Counter(
                key: ValueKey(2),
                initialValue: _defaultValue,
                minValue: 0,
                maxValue: 10,
                step: 0.5,
                decimalPlaces: 1,
                onChanged: (value) {
                  // get the latest value from here
                  setState(() {
                    _defaultValue = value;
                  });
                },
              ),
            ],
          )),
    );
  }
}
