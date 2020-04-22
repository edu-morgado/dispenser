import 'package:dispenser_ui/customizedwidgets/columnBuilder.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_ui/customizedwidgets/counter.dart';

class FoodItemColumn extends StatefulWidget{

  final Function updateParentState;
  FoodItemColumn(this.updateParentState);

  @override
  State<StatefulWidget> createState() {
    return FoodItemColumnState(updateParentState);
  }
}

class FoodItemColumnState extends State<FoodItemColumn> {
  Function updateParentState;

  FoodItemColumnState(this.updateParentState);

  num quantity = 1;
  int openedTile = 1;
  List<bool> isChecked = List<bool>();
  List<dynamic> products = [];
  List<Widget> addTilesManager = new List<Widget>();

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameNode = FocusNode();

  void initializeAddTilesManager(BuildContext context) {
    if (addTilesManager.length == 0) {
      addTilesManager.add(Divider(
          thickness:
              3)); // cute UI feature that fucks the indexes up (not best way to do probably)
      quantity = 1;
      _nameController.text = "New Product";
      products.add({
        'name': _nameController.text,
        'quantity': quantity
      }); // first tile appears already open

      addTilesManager.add(addClosedTile(products[0],openedTile, context));
      addTilesManager.add(Container(
          child: ListTile(
            onTap: () => addTileToTiles(context),
            title: Text(
              "Add ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat'),
            ),
          ),
          decoration: BoxDecoration(color: Colors.black12)));
    }
  }

  void addTileToTiles(BuildContext context) {
    if (products.length != 0) {
      products[openedTile - 1] = {
        'name': _nameController.text,
        'quantity': quantity,
      };
      addTilesManager[openedTile] =
          addClosedTile(products[openedTile - 1], openedTile, context);
    }
    //save previous countent and turns it into a closed tile (about to open a tile and its a new one)

    quantity = 1;
    _nameController.text = "New Product";
    products.add({'name': _nameController.text, 'quantity': quantity});
    addTilesManager.add(addTile(context));
    // adding a new product element for new input information, adding an ADD tile to the end of widget list

    addTilesManager[addTilesManager.length - 2] =
        addOpenedTile(products[products.length - 1], context);
    // making the before-than-last tile the opened Tile using the last element of
    // information because last tile is the add button (doesnt neeed information)

    openedTile = addTilesManager.length - 2;
    // opened tile before-than-last in widget list is now opened Tile
    updateParentState();
  }

  Widget addTile(BuildContext context) {
    return Container(
        child: ListTile(
          onTap: () => addTileToTiles(context),
          title: Text(
            'Add',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                fontFamily: 'Montserrat'),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
        ));
  }

  Widget addOpenedTile(dynamic tileInfo, BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.1,
            child: nameInput(
              context,
              tileInfo['name'],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.cyan[300],
              borderRadius: BorderRadius.circular(30.0)),
          child: Center(child: counter(tileInfo['quantity'])),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  Widget addClosedTile(dynamic tileInfo, int newIndex, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.cyan[100],
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(5.0)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () { 
          if(openedTile != -1) {
            products[openedTile - 1] = {
              'name': _nameController.text,
              'quantity': quantity,
            };
            addTilesManager[openedTile] =
                addClosedTile(products[openedTile - 1], openedTile, context);
            addTilesManager[newIndex] =
                addOpenedTile(products[newIndex - 1], context);
            _nameController.text = products[newIndex - 1]["name"];
            quantity = products[newIndex - 1]["quantity"];
          }
          openedTile = newIndex;
          updateParentState();
        },
        child: ListTile(
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              '${tileInfo['quantity']}x ${tileInfo['name']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ]),
        ),
      ),
    );
  }

  Widget counter(int initialValue) {
    return Counter(
      initialValue: initialValue,
      selectedValue: initialValue,
      minValue: 1,
      maxValue: 1000,
      step: 1,
      decimalPlaces: 0,
      onChanged: (value) {
        print("onChanged beeing called");
        quantity = value;
        print("quantity -> $quantity");
      },
    );
  }

  Widget nameInput(context, String name) {
    _nameController.text = name;
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _nameNode,
        textInputAction: TextInputAction.done,
        controller: _nameController,
        onEditingComplete: () {
          //loadHomePage(context);
        },
        decoration: new InputDecoration(
          hasFloatingPlaceholder: false,
          labelText: 'Product Name',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeAddTilesManager(context);
    return SafeArea(
      child: ColumnBuilder(
          itemCount: addTilesManager.length,
          itemBuilder: (context, i) => addTilesManager[i]),
    );
  }
}
