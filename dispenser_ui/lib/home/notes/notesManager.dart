import 'package:dispenser_ui/home/notes/noteItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';

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

  Widget _buildFloatingActionButton() {
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
      onAction: _onSpeedDialAction,
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    print('$selectedActionIndex Selected');
  }

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
