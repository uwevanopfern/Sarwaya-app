import 'package:Sarwaya/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomBarItems = [];

  final bottomNavigationBarItemStyle =
      TextStyle(fontStyle: FontStyle.normal, color: Colors.black);

  CustomAppBottomBar(BuildContext context) {
    bottomBarItems.add(
      BottomNavigationBarItem(
        icon: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Icon(
            Icons.home,
            color: CustomStyles.themeColor,
            size: 30.0,
          ),
        ),
        title: Text("Home",
            style: bottomNavigationBarItemStyle.copyWith(
                color: CustomStyles.themeColor, fontSize: 12.0)),
      ),
    );
    bottomBarItems.add(
      new BottomNavigationBarItem(
        icon: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/booking');
          },
          child: Icon(
            Icons.directions_car,
            color: CustomStyles.themeColor,
            size: 30.0,
          ),
        ),
        title: Text(
          "Your booking",
          style: bottomNavigationBarItemStyle.copyWith(
              color: CustomStyles.themeColor, fontSize: 12.0),
        ),
      ),
    );
    bottomBarItems.add(
      new BottomNavigationBarItem(
        icon: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Icon(
            Icons.account_circle,
            color: CustomStyles.themeColor,
            size: 30.0,
          ),
        ),
        title: Text(
          "Edit profile",
          style: bottomNavigationBarItemStyle.copyWith(
              color: CustomStyles.themeColor, fontSize: 12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
