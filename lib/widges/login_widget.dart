import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/widges/forget_credentials_widget.dart';
import 'package:Sarwaya/widges/homepage_widget.dart';
import 'package:Sarwaya/widges/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:Sarwaya/styles/CustomShapeClipper.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/ensure_visible.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[LoginTopWidget(), LoginBottomWidget()],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

class LoginTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginTopWidget();
  }
}

class _LoginTopWidget extends State<LoginTopWidget> {
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
        'Login bellow',
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

GestureDetector _createAccountWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignUpWidget(),
          ));
    },
    child: Text(
      'Sign up',
      style: TextStyle(color: CustomStyles.buttonColor, fontSize: 16.0),
    ),
  );
}

GestureDetector _forgetPasswordWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ForgetCredentialsWidget(),
          ));
    },
    child: Text(
      'Forget password? click here!!',
      style: TextStyle(color: CustomStyles.buttonColor, fontSize: 16.0),
    ),
  );
}

class LoginBottomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginBottomWidget();
  }
}

class _LoginBottomWidget extends State<LoginBottomWidget> {
  bool isLoading = false;
  final TextEditingController _textPhone = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();

  Widget _buildTextPhoneNumber() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
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
        validator: (String value) {
          if (value.isEmpty) {
            return "Phone number is required";
          }
        },
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
          _buildTextPhoneNumber(),
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
                        child: Text('Login'),
                        textColor: Colors.white,
                        onPressed: () async {
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
                              "phone": _textPhone.text,
                              "password": _textPassword.text
                            };
                            setState(
                              () {
                                isLoading = true;
                              },
                            );

                            ApiService.loginCustomer(data).then(
                              (val) async {
                                //Create an instance if shared Preferences
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (val != null) {
                                  List customerData = val;
                                  for (var item in customerData) {
                                    final customerID = item["customer_id"];
                                    final customerPhone =
                                        item["customer_phone"];
                                    final customerEmail =
                                        item["customer_email"];
                                    final customerName = item["customer_name"];
                                    //Check if customerID is saved in sharedPreferences
                                    final checkCustomerID =
                                        prefs.getString('customerID') ?? 0;
                                    final checkCustomerName =
                                        prefs.getString('customerName') ?? 0;
                                    final checkCustomerEmail =
                                        prefs.getString('customerEmail') ?? 0;
                                    final checkcustomerPhone =
                                        prefs.getString('customerPhone') ?? 0;
                                    if (checkCustomerID != null &&
                                        checkCustomerName != null &&
                                        checkcustomerPhone != null &&
                                        checkCustomerEmail != null) {
                                      //save in sharedPreferences and set values;
                                      prefs.setString('customerID', customerID);
                                      prefs.setString(
                                          'customerPhone', customerPhone);
                                      prefs.setString(
                                          'customerEmail', customerEmail);
                                      prefs.setString(
                                          'customerName', customerName);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePageWidget(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePageWidget(),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  showDialog(
                                      builder: (context) => AlertDialog(
                                            title: Text("Error"),
                                            content: Text(
                                                "Either authentication failed, or check your internet connection"),
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
                    _createAccountWidget(context),
                  ],
                ),
          SizedBox(
            height: 30.0,
          ),
          _forgetPasswordWidget(context),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
