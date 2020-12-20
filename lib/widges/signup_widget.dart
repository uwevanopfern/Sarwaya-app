import 'package:Sarwaya/services/api.dart';
import 'package:flutter/material.dart';
import 'package:Sarwaya/styles/CustomShapeClipper.dart';
import 'package:Sarwaya/styles/styles.dart';

import 'helpers/ensure_visible.dart';
import 'login_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[SignUpTopWidget(), SignUpBottomWidget()],
        ),
      ),
    );
  }
}

class SignUpTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpTopWidget();
  }
}

class _SignUpTopWidget extends State<SignUpTopWidget> {
  final _titleFocusNode = FocusNode();

  Widget _buildTextTitle() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: Text(
        'Welcome on Sarwaya, Where would you\nlike to go?',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTextTitleLogin() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: Text(
        'Create account bellow',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            color: CustomStyles.customShapeClipperColor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: CustomStyles.iconSize,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     print("Account icon is tapped");
                      //   },
                      Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: CustomStyles.iconSize,
                      ),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                _buildTextTitle(),
                SizedBox(
                  height: 70.0,
                ),
                _buildTextTitleLogin(),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpBottomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpBottomWidget();
  }
}

class _SignUpBottomWidget extends State<SignUpBottomWidget> {
  bool isLoading = false;
  final TextEditingController _textUsername = TextEditingController();
  final TextEditingController _textPhone = TextEditingController();
  final TextEditingController _textEmail = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();

  Widget _buildTextUserName() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      child: TextFormField(
        controller: _textUsername,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          hintText: "Enter your username",
        ),
      ),
    );
  }

  Widget _buildTextPhone() {
    return Material(
      elevation: 2.0,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _textPhone,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          hintText: "Enter your phone number",
        ),
      ),
    );
  }

  Widget _buildTextUserEmail() {
    return Material(
      elevation: 2.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _textEmail,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          hintText: "Enter your email",
        ),
      ),
    );
  }

  Widget _buildTextPassword() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10.0),
      ),
      child: TextField(
        obscureText: true,
        controller: _textPassword,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
            border: InputBorder.none,
            hintText: "Enter your password"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.85;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTextUserName(),
          _buildTextPhone(),
          _buildTextUserEmail(),
          _buildTextPassword(),
          SizedBox(
            height: 30.0,
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: CustomStyles.buttonColor,
                        elevation: 5.0,
                        child: Text('Create Account'),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_textPhone.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(
                              new SnackBar(
                                content: new Text("Phone number is required"),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          } else if (_textPassword.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(
                              new SnackBar(
                                content: new Text("Password is required"),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          } else {
                            final data = {
                              "name": _textUsername.text,
                              "email": _textEmail.text,
                              "phone": _textPhone.text,
                              "password": _textPassword.text
                            };
                            setState(
                              () {
                                isLoading = true;
                              },
                            );
                            ApiService.createCustomer(data).then(
                              (val) {
                                if (val != null) {
                                  showDialog(
                                      builder: (context) => AlertDialog(
                                            title: Text("Result"),
                                            content: Text(val),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          LoginWidget(),
                                                    ),
                                                  );
                                                },
                                                child: Text('OK'),
                                              )
                                            ],
                                          ),
                                      context: context);
                                } else {
                                  showDialog(
                                      builder: (context) => AlertDialog(
                                            title: Text("Error"),
                                            content: Text(val),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK'),
                                              )
                                            ],
                                          ),
                                      context: context);
                                  setState(
                                    () {
                                      isLoading = false;
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginWidget(),
                            ));
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(
                            color: CustomStyles.buttonColor, fontSize: 16.0),
                      ),
                    )
                  ],
                ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
