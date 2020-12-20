import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:flutter/material.dart';
import '../styles/CustomShapeClipper.dart';

class PaymentWidget extends StatefulWidget {
  final String bookingID,
      agencyName,
      bookingDate,
      customerTime,
      customerDate,
      ticketCost,
      bookingStatus,
      bookingUUID;

  PaymentWidget(
      this.bookingID,
      this.agencyName,
      this.customerTime,
      this.bookingDate,
      this.customerDate,
      this.bookingStatus,
      this.bookingUUID,
      this.ticketCost);
  @override
  State<StatefulWidget> createState() {
    return _PaymentWidget();
  }
}

class _PaymentWidget extends State<PaymentWidget> {
  bool isLoading = false;
  final TextEditingController _textPhone = TextEditingController();
  Widget _buildTextPhoneNumber() {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _textPhone,
        cursorColor: CustomStyles.customShapeClipperColor,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: CustomStyles.bigTitleColor),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          border: InputBorder.none,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.phone_iphone, color: CustomStyles.bigTitleColor),
          ),
          prefixText: '+250',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.85;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text("Payment room"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: CustomStyles.themeColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Stack(
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
                      height: 20.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      elevation: 10.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 22.0),
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
                                    'Payment page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20.0,
                                  ),
                                  Text(
                                    'MoMo number is required bellow',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                                child: Icon(
                              Icons.payment,
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
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Booking details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomStyles.mediumTitleColor,
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics:
                        ClampingScrollPhysics(), //allow all screen to be scrollable
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Agency Name',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Customer Time',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Booking Date',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Customer Date',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Ticket Cost',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Booking Status',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Booking ID',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          widget.agencyName,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.customerTime,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.bookingDate,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.customerDate,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.ticketCost + " RWF",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.bookingStatus,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          widget.bookingUUID,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: CustomStyles.bigTitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    color: Colors.grey,
                    height: 30.0,
                  ),
                  Text(
                    "* Enter MTN MoMo Number and make payment",
                    style: TextStyle(
                        color: CustomStyles.textRedColor, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildTextPhoneNumber(),
                  SizedBox(
                    height: 10.0,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : RaisedButton(
                          color: CustomStyles.buttonColor,
                          elevation: 5.0,
                          child: Text('Make payment'),
                          textColor: Colors.white,
                          onPressed: () {
                            final data = {
                              "bookingID": widget.bookingID,
                              "paymentPhone": "250" + _textPhone.text,
                              "paymentCost": widget.ticketCost,
                            };
                            if (_textPhone.text.isEmpty) {
                              Scaffold.of(context).showSnackBar(
                                new SnackBar(
                                  content: new Text(
                                      "Password do not match, Try again!!"),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {
                                      // Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              setState(
                                () {
                                  isLoading = true;
                                },
                              );
                              ApiService.buyTicket(data).then(
                                (val) {
                                  if (val != null) {
                                    showDialog(
                                        builder: (context) => AlertDialog(
                                              title: Text("Result"),
                                              content: Text(val),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/booking');
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
                              borderRadius: new BorderRadius.circular(10.0)),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
