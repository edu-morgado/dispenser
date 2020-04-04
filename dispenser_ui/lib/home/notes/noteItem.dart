import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  NoteItem({Key key}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Page"),
        centerTitle: true,
        elevation: 9.0,
        automaticallyImplyLeading: true,
      ),
    );
  
  }
}