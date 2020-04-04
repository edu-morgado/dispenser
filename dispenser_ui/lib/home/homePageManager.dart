import 'package:flutter/material.dart';
import 'package:dispenser_ui/home/inventory/inventoryManager.dart';
import 'package:dispenser_ui/home/wishlist/wishlistCategories.dart';
import 'package:dispenser_ui/home/notes/notesManager.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dispenser_ui/home/wishlist/addMenus.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabBarPage();
  }
}

class TabBarPage extends State<Home> with SingleTickerProviderStateMixin {
  List<Widget> tabs;
  bool dialVisible = true;

  ScrollController scrollController;
  TabController _tabController;


  List<Tab> _bottomBarItems = [
    Tab(icon: Icon(Icons.note, size: 40)),
    Tab(icon: Icon(Icons.home, size: 40)),
    Tab(icon: Icon(Icons.add_shopping_cart, size: 40)),
  ];


  TabBarPage() {
    tabs = [
      Notes(),
      Inventory(),
      WishListCategories(),
    ];
  }

  static const List<IconData> wishListFloatingbuttonIcons = const [
    Icons.sms,
    Icons.mail,
  ];

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: 1);
    _tabController.addListener(floatingButton);
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadAddProductPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddProduct());
    Navigator.of(context).push(route);
  }

  void loadAddCategoryPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddCategory());
    Navigator.of(context).push(route);
  }

  Widget floatingButton() {
    setState(() {});
    if (_tabController.index == 0 )
      return null;
    else if (_tabController.index == 1 )
      return null;
    else if (_tabController.index == 2 ) 
      return inventoryListSpeedDial();
    return null;
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }


 /* Widget notesListSpeedDial() {
    final icons = [
      SpeedDialAction(child: Icon(Icons.mode_edit)),
      SpeedDialAction(child: Icon(Icons.date_range)),
      SpeedDialAction(child: Icon(Icons.list)),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      // Make sure one of child widget has Key value to have fade transition if widgets are same type.
      childOnFold: Icon(Icons.event_note, key: UniqueKey()),
      childOnUnfold: Icon(Icons.add),
      useRotateAnimation: true,
      onAction: _notesOnSpeedDialAction,
    );
  }
  
  void _notesOnSpeedDialAction(int selectedActionIndex) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddCategory());
    Navigator.of(context).push(route);
  }

  */


  Widget inventoryListSpeedDial() {
    return SpeedDial(
      tooltip: 'add',
      heroTag: null,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => loadAddProductPage(context),
          label: 'Add a product',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => loadAddCategoryPage(context),
          label: 'Add a category',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  
  Widget wishListSpeedDial() {
    
    return SpeedDial(
      tooltip: 'add',
      heroTag: null,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => loadAddProductPage(context),
          label: 'Add a product',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => loadAddCategoryPage(context),
          label: 'Add a category',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: _tabController, children: tabs),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 50.0,
        child: TabBar(
          controller: _tabController,
          tabs: _bottomBarItems,
          unselectedLabelColor: Colors.black,
          labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButton: floatingButton(),
    );
  }
}
