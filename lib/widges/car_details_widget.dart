import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/CustomShapeClipper.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CarDetailsWidget extends StatefulWidget {
  final String agencyID, locationID;

  CarDetailsWidget(this.locationID, this.agencyID);

  @override
  State<StatefulWidget> createState() {
    return _CarDetailsWidget();
  }
}

class _CarDetailsWidget extends State<CarDetailsWidget> {
  bool isLoading = false;

  final format = DateFormat("yyyy-MM-dd");
  final TextEditingController _textDateTime = TextEditingController();

  Widget _buildDateTimeWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: DateTimeField(
        controller: _textDateTime,
        decoration: InputDecoration(
          labelText: 'Tap here and select date',
          hasFloatingPlaceholder: false,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          return showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text(
          "Cars Details",
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: CustomStyles.themeColor,
      ),
      body: SingleChildScrollView(
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
                                    'Cars',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20.0,
                                  ),
                                  Text(
                                    'List',
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
                  _buildDateTimeWidget(),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "List of times of agency",
                      style: TextStyle(
                          color: CustomStyles.mediumTitleColor, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: <Widget>[
                            FutureBuilder(
                                future: ApiService.getAgencyTimeTable(
                                    widget.agencyID),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final schedule = snapshot.data;
                                    print(schedule);
                                    return SingleChildScrollView(
                                      child: ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: schedule == null
                                            ? 0
                                            : schedule.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              border: Border.all(
                                                  color:
                                                      CustomStyles.borderColor),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Wrap(
                                                          spacing: 8.0,
                                                          runSpacing: -8.0,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            AgencyWidgetDetailChip(
                                                                Icons
                                                                    .time_to_leave,
                                                                "Agency Name: " +
                                                                    schedule[
                                                                            index]
                                                                        [
                                                                        "agencyName"]),
                                                            AgencyWidgetDetailChip(
                                                                Icons
                                                                    .access_time,
                                                                "Agency Time: " +
                                                                    schedule[
                                                                            index]
                                                                        [
                                                                        "time"]),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 4.0,
                                                          ),
                                                          FlatButton.icon(
                                                            onPressed:
                                                                () async {
                                                              final SharedPreferences
                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              final checkCustomerID =
                                                                  prefs.getString(
                                                                          'customerID') ??
                                                                      0;

                                                              if (_textDateTime
                                                                  .text
                                                                  .isEmpty) {
                                                                showDialog(
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Oops, Empty field"),
                                                                              content: Text("Date and time is empty, tap in textfield and select date and time"),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text('OK'),
                                                                                )
                                                                              ],
                                                                            ),
                                                                    context:
                                                                        context);
                                                              } else {
                                                                final data = {
                                                                  "agencyID": widget
                                                                      .agencyID,
                                                                  "locationID":
                                                                      widget
                                                                          .locationID,
                                                                  "customerID":
                                                                      checkCustomerID,
                                                                  "customerDate":
                                                                      _textDateTime
                                                                          .text,
                                                                  "customerTime":
                                                                      schedule[
                                                                              index]
                                                                          [
                                                                          "time"]
                                                                };
                                                                ApiService
                                                                        .addAnonymousBooking(
                                                                            data)
                                                                    .then(
                                                                        (val) {
                                                                  if (val !=
                                                                      null) {
                                                                    showDialog(
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Result"),
                                                                              content: Text(val),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pushNamed(context, '/booking');
                                                                                  },
                                                                                  child: Text('OK'),
                                                                                )
                                                                              ],
                                                                            ),
                                                                        context:
                                                                            context);
                                                                  } else {
                                                                    showDialog(
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Error"),
                                                                              content: Text("Failed to add booking, Try again!"),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text('OK'),
                                                                                )
                                                                              ],
                                                                            ),
                                                                        context:
                                                                            context);
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons.date_range,
                                                              color: CustomStyles
                                                                  .textWhiteColor,
                                                              size: 20.0,
                                                            ),
                                                            label: Text(
                                                                "Book on this time"),
                                                            color: CustomStyles
                                                                .themeColor,
                                                            textColor: CustomStyles
                                                                .textWhiteColor,
                                                            shape:
                                                                new RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AgencyWidgetDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  AgencyWidgetDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      backgroundColor: CustomStyles.rawChipColor,
      avatar: Icon(
        iconData,
        size: 14.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
