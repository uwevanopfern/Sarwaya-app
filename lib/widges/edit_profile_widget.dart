import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:Sarwaya/styles/CustomShapeClipper.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_widget.dart';

class EditProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: CustomStyles.themeColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            EditProfileTopWidget(),
            EditProfileBottomWidget(),
          ],
        ),
      ),
    );
  }
}

class EditProfileTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileTopWidget();
  }
}

class _EditProfileTopWidget extends State<EditProfileTopWidget> {
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
                            'Profile page details',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 20.0,
                          ),
                          Text(
                            'Edit your profile',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        child: Icon(
                      Icons.account_circle,
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

Future<String> getCurrentLoggedInCustomerID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerID = prefs.getString('customerID') ?? 0;

  return customerID;
}

Future<String> getCurrentLoggedInCustomerName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerName = prefs.getString('customerName') ?? 0;

  return customerName;
}

Future<String> getCurrentLoggedInCustomerEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerEmail = prefs.getString('customerEmail') ?? 0;

  return customerEmail;
}

Future<String> getCurrentLoggedInCustomerPhone() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerPhone = prefs.getString('customerPhone') ?? 0;

  return customerPhone;
}

class EditProfileBottomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileBottomWidget();
  }
}

class _EditProfileBottomWidget extends State<EditProfileBottomWidget> {
  bool isLoading = false;
  String _customerID = "";
  String _customerName = "";
  String _customerEmail = "";
  String _customerPhone = "";

  final TextEditingController _textUsername = TextEditingController();
  final TextEditingController _textPhone = TextEditingController();
  final TextEditingController _textEmail = TextEditingController();

  @override
  void initState() {
    getCurrentLoggedInCustomerID().then(getCustomerID);
    getCurrentLoggedInCustomerName().then(getCustomerName);
    getCurrentLoggedInCustomerEmail().then(getCustomerEmail);
    getCurrentLoggedInCustomerPhone().then(getCustomerPhone);
    super.initState();
  }

  void getCustomerID(String customerID) {
    setState(() {
      this._customerID = customerID;
    });
  }

  void getCustomerName(String customerName) {
    setState(() {
      this._customerName = customerName;
    });
  }

  void getCustomerEmail(String customerEmail) {
    setState(() {
      this._customerEmail = customerEmail;
    });
  }

  void getCustomerPhone(String customerPhone) {
    setState(() {
      this._customerPhone = customerPhone;
    });
  }

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
          hintText: "Current Username: $_customerName",
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
          hintText: "Current Phone number: $_customerPhone",
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
          hintText: "Current Email: $_customerEmail",
        ),
      ),
    );
  }

  Future<String> getCustomerDetails() {
    return ApiService.getCustomerDetails(_customerID).then((val) async {});
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
          // print(customer);
          SizedBox(
            height: 50.0,
          ),
          _buildTextUserName(),
          _buildTextPhone(),
          _buildTextUserEmail(),
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
                  child: Text('Edit your profile'),
                  textColor: Colors.white,
                  onPressed: () {
                    final data = {
                      "name": _textUsername.text,
                      "email": _textEmail.text,
                      "phone": _textPhone.text,
                    };
                    setState(
                      () {
                        isLoading = true;
                      },
                    );
                    if (_textUsername.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please enter new username"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else if (_textPhone.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please enter new phonenumber"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else if (_textEmail.text.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please enter new email address"),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else {
                      ApiService.updateCustomer(data, _customerID).then(
                        (success) {
                          if (success) {
                            showDialog(
                                builder: (context) => AlertDialog(
                                      title: Text("Success"),
                                      content: Text(
                                          "Account updated with success, Login with new accounts"),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LoginWidget(),
                                              ),
                                            );
                                          },
                                          child: Text('Login'),
                                        )
                                      ],
                                    ),
                                context: context);
                          } else {
                            showDialog(
                                builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Failed to update an account, Try again!!"),
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
