import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:Sarwaya/widges/payment_widget.dart';
import 'package:flutter/material.dart';
import '../styles/CustomShapeClipper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookingPageWidget();
  }
}

Future<String> getCurrentLoggedInCustomerID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerID = prefs.getString('customerID') ?? 0;

  return customerID;
}

class _BookingPageWidget extends State<BookingPageWidget> {
  String _customerID = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text(
          "Booking room",
        ),
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
                                    'You booking history',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                                child: Icon(
                              Icons.directions_car,
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
                      "List of your bookings",
                      style: TextStyle(
                          color: CustomStyles.mediumTitleColor, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: ApiService.getCustomerBookings(_customerID),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final bookings = snapshot.data;
                            return SingleChildScrollView(
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    bookings == null ? 0 : bookings.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 16.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            border: Border.all(
                                                color:
                                                    CustomStyles.borderColor),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: BoxDecoration(
                                                        color: CustomStyles
                                                            .rawChipColor,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        bookings[index]
                                                            ['agency_name'],
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomStyles
                                                                .bigTitleColor),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: BoxDecoration(
                                                        color: CustomStyles
                                                            .rawChipColor,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        bookings[index][
                                                                'customer_date'] +
                                                            "/" +
                                                            bookings[index][
                                                                'customer_time'],
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomStyles
                                                                .bigTitleColor),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        bookings[index]
                                                            ['isPaid'],
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomStyles
                                                                .textRedColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (bookings[index][
                                                            "booking_status"] ==
                                                        "Confirmed" &&
                                                    bookings[index]["isPaid"] ==
                                                        "UNPAID")
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton.icon(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext context) => PaymentWidget(
                                                                bookings[index][
                                                                    "booking_id"],
                                                                bookings[index][
                                                                    "agency_name"],
                                                                bookings[index][
                                                                    "customer_time"],
                                                                bookings[index][
                                                                    "booking_date"],
                                                                bookings[index][
                                                                    "customer_date"],
                                                                bookings[index][
                                                                    "booking_status"],
                                                                bookings[index][
                                                                    "booking_uuid"],
                                                                bookings[index][
                                                                    "ticket_cost"]),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.payment,
                                                        color: CustomStyles
                                                            .textWhiteColor,
                                                        size: 20.0,
                                                      ),
                                                      label:
                                                          Text("Buy a ticket"),
                                                      color: CustomStyles
                                                          .themeColor,
                                                      textColor: CustomStyles
                                                          .textWhiteColor,
                                                      shape:
                                                          new RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else if (bookings[index]
                                                            ["isPaid"] ==
                                                        "PAID" &&
                                                    bookings[index]
                                                            ["paymentStatus"] ==
                                                        "Success")
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton.icon(
                                                      onPressed: null,
                                                      icon: Icon(
                                                        Icons.info,
                                                        color: CustomStyles
                                                            .themeColor,
                                                        size: 20.0,
                                                      ),
                                                      label: Text(
                                                        "Ticket already sold",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: CustomStyles
                                                                .themeColor),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton.icon(
                                                      onPressed: null,
                                                      icon: Icon(
                                                        Icons.warning,
                                                        color: CustomStyles
                                                            .themeColor,
                                                        size: 20.0,
                                                      ),
                                                      label: Text(
                                                        "Pending booking",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: CustomStyles
                                                                .themeColor),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
