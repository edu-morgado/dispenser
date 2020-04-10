import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:dispenser_ui/home/inventory/addInventory.dart';
import 'package:dispenser_ui/home/inventory/inventoryManager.dart';
import 'package:dispenser_ui/home/wishlist/wishlistCategories.dart';
import 'package:dispenser_ui/home/testingnotes/Models/Note.dart';
import 'package:dispenser_ui/home/testingnotes/ViewControllers/notePage.dart';
import 'package:dispenser_ui/home/testingnotes/ViewControllers/StaggeredView.dart';
import 'package:dispenser_ui/home/wishlist/addWishlist.dart';
import 'package:dispenser_ui/objects/FoodRepository.dart';
import 'package:dispenser_ui/ObjManager.dart';
import 'package:dispenser_ui/home/addProduct.dart';

enum viewType { List, Staggered }

class Home extends StatefulWidget {
  final Manager manager = Manager();

  @override
  State<StatefulWidget> createState() {
    return TabBarPage(manager);
  }
}

class TabBarPage extends State<Home> with SingleTickerProviderStateMixin {
  Manager manager;

  List<Widget> tabs;
  bool dialVisible = true;

  var notesViewType;
  ScrollController scrollController;
  TabController _tabController;

  List<Tab> _bottomBarItems = [
    Tab(icon: Icon(Icons.note, size: 40)),
    Tab(icon: Icon(Icons.home, size: 40)),
    Tab(icon: Icon(Icons.add_shopping_cart, size: 40)),
  ];

  TabBarPage(this.manager) {
    manager.foodRepositories.repositories.add(ObjFoodRepository(3,1,"ola"));
    manager.foodRepositories.repositories.add(ObjFoodRepository(3,2,"ola"));
    manager.foodRepositories.repositories.add(ObjFoodRepository(3,3,"ola"));

    tabs = [
      Container(child: StaggeredGridPage(notesViewType: notesViewType)),
      Inventory(manager),
      WishListCategories(manager),
    ];
  }

  static const List<IconData> wishListFloatingbuttonIcons = const [
    Icons.sms,
    Icons.mail,
  ];

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: 2);
    _tabController.addListener(floatingButton);
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    notesViewType = viewType.Staggered;

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadAddProductWishlistPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddProduct(manager));
    Navigator.of(context).push(route);
  }

  void loadAddCategoryWishlistPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddCategoryWishlist(manager));
    Navigator.of(context).push(route);
  }

  void loadAddProductInventoryPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddProduct(manager));
    Navigator.of(context).push(route);
  }

  void loadAddInventoryInventoryPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddInventoryInventoryPage(manager));
    Navigator.of(context).push(route);
  }

   void loadAddProductNotesPage(BuildContext context) {
  //   var route =
  //      MaterialPageRoute(builder: (BuildContext context) => AddProductInventoryPage());  //AddProductNotePage());
  //  Navigator.of(context).push(route);
  }

  void loadAddNotesNotesPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddInventoryInventoryPage(manager));//AddNotesNotePage());
    Navigator.of(context).push(route);
  }


  Widget floatingButton() {
    setState(() {});
    if (_tabController.index == 0)
      return notesListSpeedDial();
    else if (_tabController.index == 1)
      return inventoryListSpeedDial();
    else if (_tabController.index == 2) return wishListSpeedDial();
    return null;
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget notesListSpeedDial() {
    return SpeedDial(
      tooltip: 'add',
      heroTag: "notes",
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddProductWishlistPage(context),
          label: 'Add a product',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddCategoryWishlistPage(context),
          label: 'Add a Category',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  Widget inventoryListSpeedDial() {
   return SpeedDial(
      tooltip: 'add',
      heroTag: "inventory",
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddProductInventoryPage(context),
          label: 'Add a Product',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddInventoryInventoryPage(context),
          label: 'Add a Inventory',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  Widget wishListSpeedDial() {
    return SpeedDial(
      tooltip: 'add',
      heroTag: "wishList",
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddProductWishlistPage(context,),
          label: 'Add a Product',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => loadAddCategoryWishlistPage(context),
          label: 'Add a Wishlist',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  AppBar _notesAppBar() {
    return AppBar(
      brightness: Brightness.light,
      actions: _appBarActions(),
      elevation: 1,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Notes"),
    );
  }

  List<Widget> _appBarActions() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => _toggleViewType(),
            child: Icon(
              notesViewType == viewType.List
                  ? Icons.developer_board
                  : Icons.view_headline,
              color: Color(0xff595959),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(
            "New Note\n",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _newNoteTapped(context),
        )
      ],
    );
  }

  void _newNoteTapped(BuildContext ctx) {
    // "-1" id indicates the note is not new
    var emptyNote =
        new Note(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
    Navigator.push(
        ctx, MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }

  void _toggleViewType() {
    setState(() {
      // CentralStation.updateNeeded = true;
      if (notesViewType == viewType.List) {
        notesViewType = viewType.Staggered;
      } else {
        notesViewType = viewType.List;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _tabController.index == 0 ? _notesAppBar() : null,
      body: SafeArea(
          child: TabBarView(controller: _tabController, children: tabs)),
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
      bottomSheet: _tabController.index == 0 ? _bottomBar() : null,
      floatingActionButton: floatingButton(),
    );
  }
}
