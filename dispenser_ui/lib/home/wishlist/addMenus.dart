import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add somgt"),
        
      ),
      body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width ,),

    );
  }
}

class AddCategory extends StatefulWidget {
  AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add somgt"),

      ),
      body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width ,),

    );
  }
}