import 'package:Sarwaya/styles/styles.dart';
import 'package:Sarwaya/widges/booking_widget.dart';
import 'package:Sarwaya/widges/edit_profile_widget.dart';
import 'package:Sarwaya/widges/homepage_widget.dart';
import 'package:Sarwaya/widges/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Urls {
  static const BASE_API_URL = "http://159.203.176.243/api";
  static const TOKEN =
      "SarwayaBearerToken eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9leGFtcGxlLm9yZyIsImF1ZCI6Imh0dHA6XC9cL2V4YW1wbGUuY29tIiwiaWF0IjoxMzU2OTk5NTI0LCJuYmYiOjEzNTcwMDAwMDAsImRhdGEiOnsiY3VzdG9tZXJfaWQiOiIyIiwiY3VzdG9tZXJfbmFtZSI6IjA3ODI4MTY1OTciLCJjdXN0b21lcl9waG9uZSI6IjA3ODI4MTY1OTciLCJjdXN0b21lcl9lbWFpbCI6InZhbkBnbWFpbC5jb20ifX0.3aklHnp9QaPGoiZTrQK0ks8BE-xcIm4HCxrGj-7rcQo";
      
}

void main() => runApp(
      MaterialApp(
        title: 'Sarwaya',
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        theme: CustomStyles.appTheme,
        routes: {
          '/home': (BuildContext context) => HomePageWidget(),
          '/booking': (BuildContext context) => BookingPageWidget(),
          '/profile': (BuildContext context) => EditProfileWidget(),
        },
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: LoginWidget(),
    );
  }
}
