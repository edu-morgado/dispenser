import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Models/Note.dart';
import '../Models/Utility.dart';
import '../Views/StaggeredTiles.dart';
import 'package:dispenser_ui/home/homePageManager.dart';

class StaggeredGridPage extends StatefulWidget {
  final notesViewType;
  const StaggeredGridPage({Key key, this.notesViewType}) : super(key: key);
  @override
  _StaggeredGridPageState createState() => _StaggeredGridPageState();
}

class _StaggeredGridPageState extends State<StaggeredGridPage> {
  // var  noteDB = NotesDBHandler();
  List<Map<String, dynamic>> _allNotesInQueryResult = [
    {
      'id': 1,
      'title': "note one dengue",
      'content': "contentand more andore more denguebfsdf",
      'date_created': DateTime(2000, 1, 1, 1, 1),
      'date_last_edited': DateTime(2000, 1, 1, 1, 1),
      'note_color': Colors.red,
      'is_archived': 1
    },
  ];
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
        children: List.generate(_allNotesInQueryResult.length, (i) {
          return _tileGenerator(i);
        }),
        staggeredTiles: _tilesForView(),
      ),
    ));
  }

  int _colForStaggeredView(BuildContext context) {
    if (widget.notesViewType == viewType.List) return 1;
    // for width larger than 600 on grid mode, return 3 irrelevant of the orientation to accommodate more notes horizontally
    return MediaQuery.of(context).size.width > 600 ? 3 : 2;
  }

  List<StaggeredTile> _tilesForView() {
    // Generate staggered tiles for the view based on the current preference.
    return List.generate(_allNotesInQueryResult.length, (index) {
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

  MyStaggeredTile _tileGenerator(int i) {
    return MyStaggeredTile(Note(
        _allNotesInQueryResult[i]["id"],
        _allNotesInQueryResult[i]["title"] == null
            ? ""
            : _allNotesInQueryResult[i]["title"],
        _allNotesInQueryResult[i]["content"] == null
            ? ""
            : _allNotesInQueryResult[i]["content"],
        _allNotesInQueryResult[i]["date_created"],
        _allNotesInQueryResult[i]["date_last_edited"],
        _allNotesInQueryResult[i]["note_color"]));
  }

/*
  void retrieveAllNotesFromDatabase() {
  // queries for all the notes from the database ordered by latest edited note. excludes archived notes.
    var _testData = noteDB.selectAllNotes();
    _testData.then((value){
        setState(() {
          this._allNotesInQueryResult = value;
          CentralStation.updateNeeded = false;
        });
    });
  }
  */

}
