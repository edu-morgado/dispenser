import 'package:flutter/material.dart';
//import 'package:frontend_maratona/MarathonApi.dart';

class RegisterManager extends StatefulWidget {
  final TextEditingController _loginEmailController;
  final TextEditingController _logInPasswordController;

  RegisterManager(this._loginEmailController, this._logInPasswordController);

  @override
  State<StatefulWidget> createState() {
    return RegisterState(_loginEmailController, _logInPasswordController);
  }
}

class RegisterState extends State<RegisterManager> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _loginEmailController;
  final TextEditingController _loginPasswordController;

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  final GlobalKey<FormState> _registerFormKey =
      GlobalKey<FormState>(debugLabel: '_registerScreenkey');

  bool _autoValidate = false;
  bool _error = false;

  RegisterState(this._loginEmailController, this._loginPasswordController);

  void backToLogIn(context) async {
    if (_registerFormKey.currentState.validate()) {

    }
    else {
    }
    setState(() {
      _autoValidate = true;
    });
  }

  Widget centeredWidget(BuildContext context, Widget widget) {
    return new Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.11,
        alignment: Alignment.topLeft,
        child: widget,
      ),
    );
  }

  Widget firstNameInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _firstNameNode,
        controller: _firstNameController,
        textInputAction: TextInputAction.next,
        autovalidate: _autoValidate,
        validator: (value) {
          if (value.isEmpty) {
            return 'First name can\'t be empty';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_lastNameNode);
        },
        decoration: new InputDecoration(
          labelText: 'First name',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget lastNameInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _lastNameNode,
        controller: _lastNameController,
        textInputAction: TextInputAction.next,
        autovalidate: _autoValidate,
        validator: (value) {
          if (value.isEmpty) {
            return 'Last name can\'t be empty';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_emailNode);
        },
        decoration: new InputDecoration(
          labelText: 'Last name',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget emailInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _emailNode,
        controller: _emailController,
        textInputAction: TextInputAction.next,
        autovalidate: _autoValidate,
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Enter Valid Email';
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_passwordNode);
        },
        decoration: new InputDecoration(
          labelText: 'Email',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget passwordInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        obscureText: true,
        focusNode: _passwordNode,
        controller: _passwordController,
        textInputAction: TextInputAction.next,
        autovalidate: _autoValidate,
        validator: (value) {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_confirmPasswordNode);
        },
        decoration: new InputDecoration(
          labelText: 'Password',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget confirmPasswordInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        obscureText: true,
        focusNode: _confirmPasswordNode,
        controller: _confirmPasswordController,
        textInputAction: TextInputAction.done,
        autovalidate: _autoValidate,
        validator: (value) {
          if (value != _passwordController.text) {
            return 'Passwords must be the same';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          backToLogIn(context);
        },
        decoration: new InputDecoration(
          labelText: 'Confirm Password',
          focusColor: Colors.grey[300],
        ),
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          backToLogIn(context);
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Register"),
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                centeredWidget(context, firstNameInput(context)),
                centeredWidget(context, lastNameInput(context)),
                centeredWidget(context, emailInput(context)),
                centeredWidget(context, passwordInput(context)),
                centeredWidget(context, confirmPasswordInput(context)),
                Container(height: 10.0),
                (_error)
                    ? Container( width: MediaQuery.of(context).size.width * 0.8,
                                          child: Text(
                          "Email already registered (or no internet conection)"),
                    )
                    : Container(height: 10.0,),
                centeredWidget(context, registerButton(context)),
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
