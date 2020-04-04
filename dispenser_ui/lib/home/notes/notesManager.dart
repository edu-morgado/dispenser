import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}

class NotesState extends State<Notes> {
  List<String> NotesItem = [
    "fridge",
    "freezer",
    "storage",
  ];

  @override
  Widget build(BuildContext context) {
    print(NotesItem.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Page"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: ListView.builder(
        itemCount: NotesItem.length,
        itemBuilder: (context, i) => Column(
          children: [
            Divider(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
