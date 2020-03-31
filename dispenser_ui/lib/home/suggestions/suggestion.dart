import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Suggestions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuggestionsState();
  }
}

class SuggestionsState extends State<Suggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions Page"),
        centerTitle: true,
        elevation: 9.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(),
      ),
    );
  }
}
