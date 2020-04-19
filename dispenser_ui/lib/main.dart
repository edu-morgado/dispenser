import 'package:dispenser_ui/home/homePageManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dispenser_ui/ObjManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Manager manager = new Manager();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => manager,
      child: Consumer<Manager>(builder: (context, manager, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue, secondaryHeaderColor: Colors.white),
          home: Home(manager),
        );
      }),
    );
  }
}
