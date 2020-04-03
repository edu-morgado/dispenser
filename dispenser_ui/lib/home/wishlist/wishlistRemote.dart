import 'package:flutter/material.dart';

class RemoteWishlist extends StatefulWidget {
  RemoteWishlist({Key key}) : super(key: key);

  @override
  RemoteWishlistState createState() => RemoteWishlistState();
}

class RemoteWishlistState extends State<RemoteWishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Importing a Wishlist"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: ClipOval(
        child: Material(
          color: Colors.blue, // button color
          child: InkWell(
            splashColor: Colors.red, // inkwell color
            child: SizedBox(width: 56, height: 56, child: Icon(Icons.perm_contact_calendar)),
            onTap: () {},
          ),
        ),
      ),
      
    );
  }
}
