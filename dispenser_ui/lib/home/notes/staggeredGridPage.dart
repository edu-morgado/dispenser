import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dispenser_ui/objects/Note.dart';
import 'package:dispenser_ui/home/notes/staggeredGridTile.dart';
import 'package:dispenser_ui/customizedwidgets/colorSlider.dart';
import 'package:dispenser_ui/home/homePageManager.dart';
/*
import '../Models/SqliteHandler.dart';
import '../Models/Utility.dart';
import '../Views/StaggeredTiles.dart';
import 'HomePage.dart';
*/

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
      'title': 'Note title',
      'content':
          'The note content has to have beucase to have dengue habing badjoras in the pedarinos',
      'date_created': DateTime(1998, 2, 2, 5),
      'date_last_edited': DateTime(1998, 2, 2, 5),
      'note_color': Colors.black,
      'is_archived': 0,
    },
    {
      'id': 2,
      'title': 'Note title',
      'content':
          'The note content has to have beucase to have dengue habing badjoras in the pedarinos',
      'date_created': DateTime(1998, 2, 2, 5),
      'date_last_edited': DateTime(1998, 2, 2, 5),
      'note_color': Colors.orange,
      'is_archived': 0,
    },
    {
      'id': 3,
      'title': 'Note title',
      'content':
          'The note content has to have beucase to have dengue habing badjoras in the pedarinos',
      'date_created': DateTime(1998, 2, 2, 5),
      'date_last_edited': DateTime(1998, 2, 2, 5),
      'note_color': Colors.red,
      'is_archived': 0,
    },
    {
      'id': 4,
      'title': 'Note title',
      'content':
          'The note content has to have beucase to have dengue habing badjoras in the pedarinos',
      'date_created': DateTime(1998, 2, 2, 5),
      'date_last_edited': DateTime(1998, 2, 2, 5),
      'note_color': Colors.yellow,
      'is_archived': 0,
    }
  ];

  viewType notesViewType ;

  @override
  void initState() {
    super.initState();
     this.notesViewType = widget.notesViewType;
  }

  @override
  void setState(fn) {
    super.setState(fn);
    // this.notesViewType = widget.notesViewType;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _stagKey = GlobalKey();
    //if(CentralStation.updateNeeded) {  retrieveAllNotesFromDatabase();  }
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
      if (widget.notesViewType == viewType.List) { return 1; }
    // for width larger than 600, return 3 irrelevant of the orientation to accommodate more notes horizontally
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
    Note note = Note(
        _allNotesInQueryResult[i]["id"],
        _allNotesInQueryResult[i]["title"] == null
            ? ""
            : utf8.decode(_allNotesInQueryResult[i]["title"]),
        _allNotesInQueryResult[i]["content"] == null
            ? ""
            : utf8.decode(_allNotesInQueryResult[i]["content"]),
        DateTime.fromMillisecondsSinceEpoch(
            _allNotesInQueryResult[i]["date_created"] * 1000),
        DateTime.fromMillisecondsSinceEpoch(
            _allNotesInQueryResult[i]["date_last_edited"] * 1000),
        Color(_allNotesInQueryResult[i]["note_color"]));
    print(note.toString());
    return MyStaggeredTile(note);
  }

/*  void retrieveAllNotesFromDatabase() {
   queries for all the notes from the database ordered by latest edited note. excludes archived notes.
    var _testData = noteDB.testSelect();
    _testData.then((value){
        setState(() {
          this._allNotesInQueryResult = value;
          CentralStation.updateNeeded = false;
        });
    });
  }
*/
}
