import 'package:dispenser_ui/home/homer/HomeManager.dart';
import 'package:dispenser_ui/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dispenser_ui/home/inventory/addInventory.dart';
import 'package:dispenser_ui/home/inventory/inventoryManager.dart';
import 'package:dispenser_ui/home/wishlist/wishListManager.dart';
import 'package:dispenser_ui/home/wishlist/addWishList.dart';
import 'package:dispenser_ui/home/notes/notePage.dart';
import 'package:dispenser_ui/home/notes/StaggeredPage.dart';

import 'package:dispenser_ui/objects/Home.dart';
import 'package:dispenser_ui/objects/Note.dart';
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
  bool needsLogIn = true;
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

    manager.loadHomesFromFile().then((bool exists) {
      if (!exists) {
        print("doenst have a home and needs join or create home");

        needsLogIn = true;
      } else {
        needsLogIn = false;

        manager.loadFoodItemsFromFile().then((bool exists) {
          manager.loadInventoriesFromFile().then((bool exists) {
            manager.loadWishListsFromFile().then((bool exists) {
              manager.loadNotesFromFile().then((bool exists) {
                setState(() {
                  print("loaded everything from file");
                });
              });
            });
          });
        });
      }
    });
  }

  /*  
  
  */

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void loadAddInventoryPage(BuildContext context) {
    var route = MaterialPageRoute(
        builder: (BuildContext context) => AddInventoryPage());
    Navigator.of(context).push(route);
  }

  void updateHomePage() {
    setState(() {});
  }

  void loadAddWishlistPage(BuildContext context) {
    var route =
        MaterialPageRoute(builder: (BuildContext context) => AddWishListPage());
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
    needsLogIn = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (needsLogIn == true) return NoHomeIsSelected(manager, logIn);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0), // here the desired height
        child: AppBar(
          elevation: 20.0,
          titleSpacing: 10.0,
          //  title: Center(child: godfathersTextStyle("DISPENSER")),
          backgroundColor: Colors.purple[200],
          title: TabBar(
            controller: _tabController,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        alignment: Alignment.bottomCenter,
        child: TabBarView(
          controller: _tabController,
          children: tabs,
        ),
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
            ObjHome newHome = ObjHome.getExistingHome();
            manager
                .getEntireHomeInformation(
                    newHome, int.parse(homeController.text))
                .then((bool loadedHome) {
              print("ola");
              if (loadedHome)
                updateParent();
              else
                print("coulndt load this existing home");
            });
          },
          child: Container(
            height: 70,
            width: 150,
            color: Colors.blue,
            child: Center(child: Text("Join a home button")),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Container(child: Center(child: Text("Or create a new one."))),
        ),
        Container(child: Text("what name do you want for your home?")),
        Center(
          child: Container(
            width: 250,
            child: TextFormField(
              controller: homeController,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            ObjHome newHome = ObjHome(homeController.text);
            Requests.createHome(newHome).then((bool created) {
              if (created)
                updateParent();
              else
                print("not able to create home");
            });
          },
          child: Container(
            height: 70,
            width: 150,
            color: Colors.blue,
            child: Center(child: Text("Create a home button")),
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
