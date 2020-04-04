import 'package:dispenser_ui/home/homePageManager.dart';
import 'package:flutter/material.dart';
import 'loginregister/loginManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.white
      ),
      home: Home(),
    );
  }
}
