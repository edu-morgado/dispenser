import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InventoryAdd extends StatefulWidget {
  InventoryAdd({Key key, this.title}) : super(key: key);
  final String title;

  @override
  InventoryAddState createState() => new InventoryAddState();
}

class InventoryAddState extends State<InventoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _typeNode = FocusNode();

  final GlobalKey<FormState> _loginFormKey =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');

  Widget nameInput(context) {
    return TextFormField(
      focusNode: _nameNode,
      controller: _nameController,
      textInputAction: TextInputAction.next,
    );
  }

  Widget typeInput(context) {
    return TextFormField(
      focusNode: _typeNode,
      controller: _typeController,
      textInputAction: TextInputAction.next,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameNode.dispose();
    _typeController.dispose();
    _typeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          color: Theme.of(context).secondaryHeaderColor,
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: MediaQuery.of(context).size.height * 0.1),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.25,
                    alignment: Alignment.center,
                    child: Center(child: nameInput(context)),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Center(child: typeInput(context)),
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
