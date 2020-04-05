import 'package:dispenser_ui/home/notes/noteItem.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}

class NotesState extends State<Notes> {
  List<String> notesItem = [
    "fridge",
    "freezer",
    "storage",
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Page"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: ListView.builder(
        itemCount: notesItem.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => NoteItem())),
          child: Container(
            child: Text(notesItem[i]),
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
