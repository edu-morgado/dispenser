import 'package:flutter/material.dart';
import 'package:dispenser_ui/home/inventory/inventoryManager.dart';
import 'package:dispenser_ui/home/profile/profileManager.dart';
import 'package:dispenser_ui/home/wishlist/wishlist.dart';
import 'package:dispenser_ui/home/suggestions/suggestion.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabBarPage();
  }
}

class TabBarPage extends State<Home> {
  List<Widget> tabs;

  List<Tab> _bottomBarItems = [
    Tab(icon: Icon(Icons.add_shopping_cart , size: 40)),
    Tab(icon: Icon(Icons.home, size: 40)),
    Tab(icon: Icon(Icons.add_shopping_cart , size: 40)),
    Tab(icon: Icon(Icons.person, size: 40)),

  ];

  TabBarPage() {
    tabs = [
      Suggestions(),
      Inventory(),
      WishList(),
      Profile(), 
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(children: tabs),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 50.0,
          child: TabBar(
            tabs: _bottomBarItems,
            unselectedLabelColor: Colors.black,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
