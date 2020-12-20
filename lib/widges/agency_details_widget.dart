import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:flutter/material.dart';
import '../styles/CustomShapeClipper.dart';
import 'car_details_widget.dart';

class AgencyDetailWidget extends StatefulWidget {
  final String agencyID;

  AgencyDetailWidget(this.agencyID);

  @override
  State<StatefulWidget> createState() {
    return _AgencyDetailWidget();
  }
}

class _AgencyDetailWidget extends State<AgencyDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 1.0;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      appBar: AppBar(
        title: Text(
          "Agency Cars",
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
                                    'Agency',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Locations',
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "List of available locations",
                      style: TextStyle(
                          color: CustomStyles.mediumTitleColor, fontSize: 18.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Stack(
                          children: <Widget>[
                            FutureBuilder(
                                future: ApiService.getAgencyLocations(
                                    widget.agencyID),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final location = snapshot.data;
                                    print(location);
                                    return SingleChildScrollView(
                                      child: ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: location == null
                                            ? 0
                                            : location.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(location[index]
                                                  ["location_id"]);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      CarDetailsWidget(
                                                          location[index]
                                                              ["location_id"],
                                                          location[index]
                                                              ["agency_id"]),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                border: Border.all(
                                                    color: CustomStyles
                                                        .borderColor),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: targetPadding),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Wrap(
                                                            spacing: 8.0,
                                                            runSpacing: -8.0,
                                                            children: <Widget>[
                                                              AgencyWidgetDetailChip(
                                                                  Icons
                                                                      .location_on,
                                                                  "" +
                                                                      location[
                                                                              index]
                                                                          [
                                                                          "from"] +
                                                                      " -> " +
                                                                      location[
                                                                              index]
                                                                          [
                                                                          "to"]),
                                                              AgencyWidgetDetailChip(
                                                                  Icons.payment,
                                                                  "Cost: " +
                                                                      location[
                                                                              index]
                                                                          [
                                                                          "location_cost"] +
                                                                      " RWF"),
                                                              AgencyWidgetDetailChip(
                                                                  Icons
                                                                      .arrow_right,
                                                                  ''),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
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
        color: CustomStyles.iconColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
