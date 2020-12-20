import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:Sarwaya/styles/CustomShapeClipper.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: CustomStyles.themeColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SettingTopWidget(),
            SettingBottomWidget(),
          ],
        ),
      ),
    );
  }
}

class SettingTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingTopWidget();
  }
}

class _SettingTopWidget extends State<SettingTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 160.0,
            color: CustomStyles.customShapeClipperColor,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Manage account',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          Text(
                            'Change password or disable account',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        child: Icon(
                      Icons.settings,
                      color: CustomStyles.iconColor,
                      size: 32.0,
                    )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SettingBottomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingBottomWidget();
  }
}

Future<String> getCurrentLoggedInCustomerID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerID = prefs.getString('customerID') ?? 0;

  return customerID;
}

class _SettingBottomWidget extends State<SettingBottomWidget> {
  bool isLoading = false;
  String _customerID = "";

  final TextEditingController _textOldPassword = TextEditingController();
  final TextEditingController _textNewPassword = TextEditingController();
  final TextEditingController _textConfirmPassword = TextEditingController();

  @override
  void initState() {
    getCurrentLoggedInCustomerID().then(getCustomerID);
    super.initState();
  }

  void getCustomerID(String customerID) {
    setState(() {
      this._customerID = customerID;
    });
  }

  Widget _buildTextOldPassword() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      child: TextField(
        obscureText: true,
        controller: _textOldPassword,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          hintText: "Enter old password",
        ),
      ),
    );
  }

  Widget _buildTextNewPassword() {
    return Material(
      elevation: 2.0,
      child: TextField(
        obscureText: true,
        controller: _textNewPassword,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          hintText: "Enter new passowrd",
        ),
      ),
    );
  }

  Widget _buildTextConfirmPassword() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10.0),
      ),
      child: TextField(
        obscureText: true,
        controller: _textConfirmPassword,
        cursorColor: CustomStyles.customShapeClipperColor,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
            border: InputBorder.none,
            hintText: "Confirm new password"),
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
            height: 50.0,
          ),
          _buildTextOldPassword(),
          _buildTextNewPassword(),
          _buildTextConfirmPassword(),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ButtonTheme(
                minWidth: 150.0,
                height: 50.0,
                child: RaisedButton(
                  color: CustomStyles.buttonColor,
                  elevation: 5.0,
                  child: Text('Change Password'),
                  textColor: Colors.white,
                  onPressed: () {
                    final data = {
                      "password": _textOldPassword.text,
                      "new_password": _textNewPassword.text,
                    };
                    setState(
                      () {
                        isLoading = true;
                      },
                    );
                    if (_textOldPassword.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please enter old password"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else if (_textNewPassword.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please enter new password"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else if (_textNewPassword.text !=
                        _textConfirmPassword.text) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content:
                              new Text("Password do not match, Try again!!"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else {
                      ApiService.changePassword(data, _customerID).then(
                        (val) {
                          if (val != null) {
                            showDialog(
                                builder: (context) => AlertDialog(
                                      title: Text("Result"),
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
