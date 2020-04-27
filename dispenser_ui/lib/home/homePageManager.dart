import 'package:dispenser_ui/home/homer/HomeManager.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dispenser_ui/home/inventory/addInventory.dart';
import 'package:dispenser_ui/home/inventory/inventoryManager.dart';
import 'package:dispenser_ui/home/wishlist/wishListManager.dart';
import 'package:dispenser_ui/home/wishlist/addWishList.dart';
import 'package:dispenser_ui/home/notes/notePage.dart';
import 'package:dispenser_ui/home/notes/StaggeredPage.dart';

import 'package:dispenser_ui/objects/Home.dart';
import 'package:dispenser_ui/objects/Note.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/WishList.dart';
import 'package:dispenser_ui/objects/Inventory.dart';
import 'package:provider/provider.dart';

import 'package:dispenser_ui/ObjManager.dart';

import '../Request.dart';

enum viewType { List, Staggered }

class Home extends StatefulWidget {
  final Manager manager;

  Home(this.manager);
  @override
  State<StatefulWidget> createState() {
    return TabBarPage(this.manager);
  }
}

class TabBarPage extends State<Home> with SingleTickerProviderStateMixin {
  List<Widget> tabs;
  bool dialVisible = true;
  bool needsLogIn;
  var notesViewType;
  ScrollController scrollController;
  TabController _tabController;
  Manager manager;

  TabBarPage(this.manager) {
    tabs = [
      HomeManager(manager),
      Inventory(manager),
      WishListManager(manager),
      StaggeredGridPage(notesViewType: notesViewType),
    ];
  }

  static const List<IconData> wishListFloatingbuttonIcons = const [
    Icons.sms,
    Icons.mail,
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: 0);
    _tabController.addListener(floatingButton);
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    notesViewType = viewType.Staggered;

    // ObjFoodItem item1 = ObjFoodItem("leite", 6, 12);
    // ObjFoodItem item2 = ObjFoodItem("badjoraz", 2, 12);
    // ObjFoodItem item3 = ObjFoodItem("degnue", 7, 12);
    // ObjFoodItem item4 = ObjFoodItem("carne", 12, 12);
    // ObjFoodItem item5 = ObjFoodItem("peixe", 11, 12);
    // ObjFoodItem item6 = ObjFoodItem("bolachas", 8, 12);
    // ObjFoodItem item7 = ObjFoodItem("dengues", 4, 12);
    // ObjFoodItem item8 = ObjFoodItem("batatas", 3, 12);
    // ObjNote note1 = ObjNote(
    //     1,
    //     "nota one dengue",
    //     "some note juicy ass content fo yo ass",
    //     DateTime(2000, 1, 1, 1, 1),
    //     DateTime(2000, 1, 1, 1, 1),
    //     Colors.red);
    // ObjNote note2 = ObjNote(
    //     2,
    //     "nota dois dengue",
    //     "some mo juicy ass content fo yo ass",
    //     DateTime(2000, 1, 1, 1, 1),
    //     DateTime(2000, 1, 1, 1, 1),
    //     Colors.blue);
    // ObjNote note3 = ObjNote(
    //     3,
    //     "nota one dengue",
    //     "wake yo fatass traca fatigated master youre sleeping behind me right now",
    //     DateTime(2000, 1, 1, 1, 1),
    //     DateTime(2000, 1, 1, 1, 1),
    //     Colors.green);

    // manager.inventories.inventories.add(ObjInventory(1, 3, "Items Not Stored"));
    // manager.inventories.inventories.add(ObjInventory(2, 1, "Fridge"));
    // manager.inventories.inventories.add(ObjInventory(3, 2, "Freezer"));
    // manager.inventories.inventories.add(ObjInventory(4, 3, "Storage"));
    // manager.wishlists.wishlists.add(ObjWishList(1, "All Items"));
    // manager.inventories.inventories[0].foodItems.add(item1);
    // manager.inventories.inventories[0].foodItems.add(item2);
    // manager.inventories.inventories[0].foodItems.add(item3);
    // manager.inventories.inventories[1].foodItems.add(item1);
    // manager.inventories.inventories[1].foodItems.add(item4);
    // manager.inventories.inventories[1].foodItems.add(item7);
    // manager.inventories.inventories[2].foodItems.add(item8);
    // manager.inventories.inventories[2].foodItems.add(item6);
    // manager.inventories.inventories[2].foodItems.add(item5);
    // manager.inventories.inventories[3].foodItems.add(item3);
    // manager.inventories.inventories[3].foodItems.add(item6);
    // manager.inventories.inventories[3].foodItems.add(item5);
    // manager.wishlists.wishlists[0].foodItems.add(item1);
    // manager.wishlists.wishlists[0].foodItems.add(item3);
    // manager.wishlists.wishlists[0].foodItems.add(item2);
    // manager.notes.notes.add(note1);
    // manager.notes.notes.add(note2);
    // manager.notes.notes.add(note3);

    //manager.requestFoodItems();
    //manager.inventories.inventories = [];

    // CREATE / UPDATE / DELETE WISHLIST IN DB
    // ObjWishList wishlist = ObjWishList("dengue name");
    // Requests.createWishList(wishlist).then((bool created) {
    //   wishlist.name = "updating the name dengue";
    //   Requests.updateWishList(wishlist).then( (dynamic s) {
    //      Requests.deleteWishList(wishlist);
    //   });
    //  });

    // CREATE / UPDATE / DeleteINVENTORY IN DB
    // ObjInventory newInventory =
    //     ObjInventory("Ivnentorio dengado", 2, DateTime.now(), DateTime.now());
    // Requests.createInventory(newInventory).then((bool createdSucceful) {
    //   newInventory.name = "updating from dengue meu drena";
    //   Requests.updateInventory(newInventory).then((dynamic denuge) {
    //     Requests.deleteInventory(newInventory);
    //   });
    // });

    // CREATE / UPDATE / DELETE FoodItem IN DB
    // ObjFoodItem item1 = ObjFoodItem("badjras item meu dengue", 6, "dengeu");
    // Requests.createFoodItem(item1).then((bool dengue) {
    //   item1.name = "updating from dengue meu dengue";
    //   Requests.updateFoodItem(item1).then((dynamic dengue) {
    //     Requests.deleteFoodItem(item1);
    //   });
    // });

    //GET HOME


    manager.deleteFoodItems();
    manager.deleteHomes();
    manager.deleteWishLists();
    manager.deleteInventories();
    manager.loadHomesFromFile().then((bool hasFile) {
      this.needsLogIn = !hasFile;
      print("does it need login? ->$needsLogIn");
      setState(() {});
    });

    // manager.getWishlists();
    // manager.getFoodItems();
  }

  /*  
  
  */

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void loadAddProductInventoryPage(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => AddProductToInventory());
    Navigator.of(context).push(route);
  }

  void loadAddInventoryPage(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => AddInventoryPage());
    Navigator.of(context).push(route);
  }

  void loadAddProductWishlistPage(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => AddProductToWishList());
    Navigator.of(context).push(route);
  }

  void loadAddWishlistPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddWishList());
    Navigator.of(context).push(route);
  }

  Widget floatingButton() {
    setState(() {});
    if (_tabController.index == 1)
      return inventoryListFloatingButton();
    else if (_tabController.index == 2)
      return wishListFloatingButton();
    else if (_tabController.index == 3) return notesListSpeedDial();
    return null;
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget notesListSpeedDial() {
    return FloatingActionButton(
      tooltip: 'add',
      heroTag: "notes",
      onPressed: () => print("supose to add new note"),
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget inventoryListFloatingButton() {
    return FloatingActionButton(
      tooltip: 'add',
      heroTag: "inventory",
      onPressed: () => loadAddInventoryPage(context),
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget wishListFloatingButton() {
    return FloatingActionButton(
      tooltip: 'add',
      heroTag: "wishList",
      onPressed: () => loadAddWishlistPage(context),
      child: Icon(Icons.add, color: Colors.white),
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
        new ObjNote(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
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

  logIn() {
    manager.getEntireHomeInformation(manager.homes.homes[0], manager.homes.homes[0].id);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (manager.homes == null)
      return NoHomeIsSelected(manager, logIn);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: godfathersTextStyle("DISPENSER")),
        backgroundColor: Colors.purple[200],
        elevation: 20.0,
        bottom: TabBar(
          controller: _tabController,
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.title,
              icon: Icon(choice.icon),
            );
          }).toList(),
        ),
      ),
      body: SafeArea(
          child: TabBarView(
        controller: _tabController,
        children: tabs,
      )),
      floatingActionButton: floatingButton(),
    );
  }
}

class NoHomeIsSelected extends StatelessWidget {
  final Manager manager;
  final Function updateParent;
  NoHomeIsSelected(this.manager, this.updateParent);

  final TextEditingController homeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Container(
                child: Center(
                    child: Text(
                        "You dont Own a home yet. Please provide you home id to join it.")))),
        Center(
          child: Container(
            width: 250,
            child: TextFormField(
              controller: homeController,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            manager
                .getHomeInfo(
                    ObjHome.getExistingHome(), int.parse(homeController.text))
                .then((bool loadedHome) {
                  loadedHome? print("home sucessfully loaded") : print("Couldnt fine a home with that id");
                  updateParent();
                });
          },
          child: Container(
            height: 70,
            width: 150,
            color: Colors.blue,
            child: Center(child: Text("Get Your home button")),
          ),
        ),
      ]),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Inventories', icon: Icons.kitchen),
  const Choice(title: 'Wishlists', icon: Icons.add_shopping_cart),
  const Choice(title: 'Notes', icon: Icons.message),
];
