import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InventoryState();
  }
}

class InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Divider(
              height: 10.0,
            ),
            InkWell(
              onTap: () => () {
                print("hello");
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.center,
                color: Colors.black,
                /*
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: getValidImage(manager.ipsss.getIPSS(i).image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  */
              ),
            ),
          ],
        ),
      ),
    );
  }
}
