import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ColorSlider.dart';

enum moreOptions { delete, share, copy }

class MoreOptionsSheet extends StatefulWidget {
  final Color color;
  final DateTime date_last_edited;
  final void Function(Color) callBackColorTapped;

  final void Function(moreOptions) callBackOptionTapped;

  const MoreOptionsSheet(
      {Key key,
      this.color,
      this.date_last_edited,
      this.callBackColorTapped,
      this.callBackOptionTapped})
      : super(key: key);

  @override
  _MoreOptionsSheetState createState() => _MoreOptionsSheetState();
}

class _MoreOptionsSheetState extends State<MoreOptionsSheet> {
  var note_color;

  @override
  void initState() {
    note_color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.note_color,
      child: new Wrap(
        children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.delete),
              title: new Text('Delete permanently'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(moreOptions.delete);
              }),
          new ListTile(
              leading: new Icon(Icons.content_copy),
              title: new Text('Duplicate'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(moreOptions.copy);
              }),
          new ListTile(
              leading: new Icon(Icons.share),
              title: new Text('Share'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(moreOptions.share);
              }),
          new Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: ColorSlider(
                callBackColorTapped: _changeColor,
                // call callBack from notePage here
                noteColor: note_color, // take color from local variable
              ),
            ),
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 44,
                child: Center(
                    child: Text(stringForDatetime(
                        widget.date_last_edited))),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          new ListTile()
        ],
      ),
    );
  }

  void _changeColor(Color color) {
    setState(() {
      this.note_color = color;
      widget.callBackColorTapped(color);
    });
  }

    static String stringForDatetime(DateTime dt) {
    var dtInLocal = dt.toLocal();
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var now = DateTime.now().toLocal();
    var dateString = "Edited ";

    var diff = now.difference(dtInLocal);

    if (now.day == dtInLocal.day) {
      // creates format like: 12:35 PM,
      var todayFormat = DateFormat("h:mm a");
      dateString += todayFormat.format(dtInLocal);
    } else if ((diff.inDays) == 1 ||
        (diff.inSeconds < 86400 && now.day != dtInLocal.day)) {
      var yesterdayFormat = DateFormat("h:mm a");
      dateString += "Yesterday, " + yesterdayFormat.format(dtInLocal);
    } else if (now.year == dtInLocal.year && diff.inDays > 1) {
      var monthFormat = DateFormat("MMM d");
      dateString += monthFormat.format(dtInLocal);
    } else {
      var yearFormat = DateFormat("MMM d y");
      dateString += yearFormat.format(dtInLocal);
    }

    return dateString;
  }
}
