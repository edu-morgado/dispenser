import 'package:flutter/material.dart';
import 'registerManager.dart';

/*import 'package:frontend_maratona/MarathonApi.dart';
import 'forgotPassword.dart';
import '../styles/textStyles.dart';
*/
class LogIn extends StatefulWidget {
  LogIn();

  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  final GlobalKey<FormState> _loginFormKey =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');

  _LogInState();

  /* void loadHomePage(BuildContext context) async {
    if (_loginFormKey.currentState.validate()) {
      var json =
          await Requests.login(_emailController.text, _passwordController.text);
      if (json != null) {
        print("login: $json");
        clearLogIn(json);
      } else {
        _error = true;
      }
    }
    setState(() {
      _autoValidate = true;
    });
  }


  void loadRegisterPage(BuildContext context) {
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
          RegisterManager(_emailController, _passwordController),
    );
    Navigator.of(context).push(route);
  }

  void loadForgotPasswordPage(BuildContext context) {
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => ForgotPassword(),
    );
    Navigator.of(context).push(route);
  }
  */
  Widget emailInput(context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextFormField(
        focusNode: _emailNode,
        controller: _emailController,
        textInputAction: TextInputAction.next,
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Enter Valid Email';
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_passNode);
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
        focusNode: _passNode,
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        validator: (value) {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          //loadHomePage(context);
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

  Widget loginButton(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          FocusScope.of(context).unfocus();
          //loadHomePage(context);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
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
          //   loadRegisterPage(context);
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
    );
  }

  Widget forgotMyPassword(BuildContext context) {
    return InkWell(
      child: Container(child: Text("Esqueci-me da password.")),
      hoverColor: Colors.red,
      // onTap: () => loadForgotPasswordPage(context),
    );
  }

  Widget centeredWidget(BuildContext context, Widget widget) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.1,
        alignment: Alignment.topLeft,
        child: widget,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  alignment: Alignment.center,
                  child: Image.asset('assets/logotipoCorrida.png'),
                ),
                Container(height: MediaQuery.of(context).size.height * 0.03),
                centeredWidget(context, emailInput(context)),
                Container(height: MediaQuery.of(context).size.height * 0.02),
                centeredWidget(context, passwordInput(context)),
                Container(height: MediaQuery.of(context).size.height * 0.025),
                centeredWidget(context, loginButton(context)),
                Container(height: MediaQuery.of(context).size.height * 0.02),
                centeredWidget(context, registerButton(context)),
                centeredWidget(context, forgotMyPassword(context)),
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
