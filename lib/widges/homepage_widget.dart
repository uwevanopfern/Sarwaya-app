import 'package:Sarwaya/services/api.dart';
import 'package:Sarwaya/styles/CustomAppBottomBar.dart';
import 'package:Sarwaya/styles/styles.dart';
import 'package:Sarwaya/widges/login_widget.dart';
import 'package:Sarwaya/widges/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/CustomShapeClipper.dart';
import 'agency_details_widget.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomePageWidgetTopPart(),
            SizedBox(
              height: 20.0,
            ),
            HomepPageWidgetBottomPart(),
          ],
        ),
      ),
    );
  }
}

class HomePageWidgetTopPart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageWidgetTopPart();
  }
}

Future<String> getCurrentLoggedInCustomerName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customerName = prefs.getString('customerName') ?? 0;

  return customerName;
}

class _HomePageWidgetTopPart extends State<HomePageWidgetTopPart> {
  String _customerName = "";

  @override
  void initState() {
    getCurrentLoggedInCustomerName().then(getCustomerName);
    super.initState();
  }

  void getCustomerName(String customerName) {
    setState(() {
      this._customerName = customerName;
    });
  }

  Widget _buildTextTitle() {
    return Text(
      'Welcome on Sarwaya, Where would you\nlike to go?',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextDescription() {
    return Text(
      'Click on agency and book a ticket',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.account_circle,
                          color: Colors.white, size: CustomStyles.iconSize),
                      Text(
                        '@$_customerName',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingWidget(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: CustomStyles.iconSize,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWidget(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: CustomStyles.iconSize,
                        ),
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
                _buildTextDescription(),
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

class HomePageWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 1.0 : deviceWidth * 1.0;
    final double targetPadding = deviceWidth - targetWidth;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: ApiService.getAllAgencies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final agency = snapshot.data;
                print(agency);
                return RefreshIndicator(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: agency == null ? 0 : agency.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AgencyDetailWidget(
                                        agency[index]["agency_id"]),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              border:
                                  Border.all(color: CustomStyles.borderColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: targetPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              agency[index]["agency_name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  color: CustomStyles
                                                      .bigTitleColor),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4.0,
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: -8.0,
                                        children: <Widget>[
                                          HomePageWidgetDetailChip(
                                              Icons.location_on,
                                              "Location:" +
                                                  agency[index]
                                                      ["agency_location"]),
                                          HomePageWidgetDetailChip(
                                              Icons.directions_car,
                                              "Total locations: " +
                                                  agency[index]
                                                          ["total_locations"]
                                                      .toString()),
                                          HomePageWidgetDetailChip(
                                              Icons.arrow_right, ''),
                                        ],
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
                  ),
                  onRefresh: () {},
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomePageWidgetDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  HomePageWidgetDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: CustomStyles.iconColor, fontSize: 14.0),
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

class HomepPageWidgetBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              "Current registered agencies",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomStyles.mediumTitleColor,
                  fontSize: 16.0),
            ),
          ),
          HomePageWidgetCard()
        ],
      ),
    );
  }
}
