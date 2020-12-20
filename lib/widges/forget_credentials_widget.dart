import 'package:Sarwaya/services/api.dart';
import 'package:flutter/material.dart';
import 'package:Sarwaya/styles/CustomShapeClipper.dart';
import 'package:Sarwaya/styles/styles.dart';

import 'helpers/ensure_visible.dart';
import 'login_widget.dart';

class ForgetCredentialsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ForgetCredentialsTopWidget(),
            ForgetCredentialsBottomWidget()
          ],
        ),
      ),
    );
  }
}

class ForgetCredentialsTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgetCredentialsTopWidget();
  }
}

class _ForgetCredentialsTopWidget extends State<ForgetCredentialsTopWidget> {
  final _titleFocusNode = FocusNode();

  Widget _buildTextTitle() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: Text(
        'Welcome on recovery page\nEnter your email bellow?',
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

class ForgetCredentialsBottomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgetCredentialsBottomWidget();
  }
}

class _ForgetCredentialsBottomWidget
    extends State<ForgetCredentialsBottomWidget> {
  bool isLoading = false;
  final TextEditingController _textEmail = TextEditingController();
  Widget _buildEmailAddress() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
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

  GestureDetector _createAccountWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginWidget(),
            ));
      },
      child: Text(
        'Login here',
        style: TextStyle(color: CustomStyles.buttonColor, fontSize: 16.0),
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
          SizedBox(
            height: 30.0,
          ),
          _buildEmailAddress(),
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
                        child: Text('Recover'),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_textEmail.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(
                              new SnackBar(
                                content: new Text("Email address is required"),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          } else {
                            final data = {"email": _textEmail.text};
                            setState(
                              () {
                                isLoading = true;
                              },
                            );

                            ApiService.recoverPasword(data).then(
                              (val) async {
                                if (val != null) {
                                  showDialog(
                                      builder: (context) => AlertDialog(
                                            title: Text("Success"),
                                            content: Text(
                                                "We sent you a recovery link your email , Check it and add new password"),
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
                                } else {
                                  showDialog(
                                      builder: (context) => AlertDialog(
                                            title: Text("Error"),
                                            content: Text(
                                                "Failed to send a link on email, Try again"),
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
                      ),
                    ),
                    Spacer(),
                    _createAccountWidget(context),
                  ],
                ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
