import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:dispenser_ui/objects/Note.dart';
import 'package:dispenser_ui/home/notes/CentralStation.dart';
import 'package:dispenser_ui/home/notes/StaggeredTilesItem.dart';
import 'package:dispenser_ui/ObjManager.dart';

import 'package:dispenser_ui/home/homePageManager.dart';

class StaggeredGridPage extends StatefulWidget {
  final notesViewType;
  const StaggeredGridPage({Key key, this.notesViewType}) : super(key: key);
  @override
  _StaggeredGridPageState createState() => _StaggeredGridPageState();
}

class _StaggeredGridPageState extends State<StaggeredGridPage> {
  // var  noteDB = NotesDBHandler();
 
  viewType notesViewType;

  @override
  void initState() {
    super.initState();
    this.notesViewType = widget.notesViewType;
  }

  @override
  void setState(fn) {
    super.setState(fn);
    this.notesViewType = widget.notesViewType;
  }

  @override
  Widget build(BuildContext context) {
    final Manager manager = Provider.of<Manager>(context);

    List<ObjNote> notes= manager.notes.notes;
    GlobalKey _stagKey = GlobalKey();

    print("update needed?: ${CentralStation.updateNeeded}");
    if (CentralStation.updateNeeded) {
      //retrieveAllNotesFromDatabase();
      print("retrieveng All notes from data base");
    }
    return Container(
        child: Padding(
      padding: _paddingForView(context),
      child: new StaggeredGridView.count(
        key: _stagKey,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: _colForStaggeredView(context),
        children: List.generate(notes.length, (i) {
          return _tileGenerator(i, notes);
        }),
        staggeredTiles: _tilesForView(notes),
      ),
    ));
  }

  int _colForStaggeredView(BuildContext context) {
    if (widget.notesViewType == viewType.List) return 1;
    // for width larger than 600 on grid mode, return 3 irrelevant of the orientation to accommodate more notes horizontally
    return MediaQuery.of(context).size.width > 600 ? 3 : 2;
  }

  List<StaggeredTile> _tilesForView(List<ObjNote> notes) {
    // Generate staggered tiles for the view based on the current preference.
    return List.generate(notes.length, (index) {
      return StaggeredTile.fit(1);
    });
  }

  EdgeInsets _paddingForView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding;
    double top_bottom = 8;
    if (width > 500) {
      padding = (width) * 0.05; // 5% padding of width on both side
    } else {
      padding = 8;
    }
    return EdgeInsets.only(
        left: padding, right: padding, top: top_bottom, bottom: top_bottom);
  }

  MyStaggeredTile _tileGenerator(int i, List<ObjNote> notes) {
    return MyStaggeredTile(ObjNote(
        notes[i].id,
        notes[i].title == null
            ? ""
            : notes[i].title,
        notes[i].title == null
            ? ""
            : notes[i].title,
        notes[i].date_created,
        notes[i].date_last_edited,
        notes[i].note_color));
  }

/*
  void retrieveAllNotesFromDatabase() {
  // queries for all the notes from the database ordered by latest edited note. excludes archived notes.
    var _testData = noteDB.selectAllNotes();
    _testData.then((value){
        setState(() {
          this.notes = value;
          CentralStation.updateNeeded = false;
        });
    });
  }
  */

}
