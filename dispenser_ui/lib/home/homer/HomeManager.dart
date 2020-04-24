import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/customizedwidgets/inventoryWishListTopBar.dart';
import 'package:flutter/material.dart';

class HomeManager extends StatefulWidget {
  final Manager manager;
  HomeManager(this.manager);

  @override
  _HomeManagerState createState() => _HomeManagerState(this.manager);
}

class _HomeManagerState extends State<HomeManager> {
Manager manager;
_HomeManagerState(this.manager);

_doesN(){

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(direction: Axis.vertical, children: [
        TopBar(_doesN(), manager, context,[], "Home"),
      ]),
    );
  }
}