import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeshare/appointments/closeEvents.dart';

import 'package:timeshare/constants.dart';
import 'package:timeshare/contactus.dart';
import 'package:timeshare/home.dart';
import 'package:timeshare/login/login.dart';

import '../homepage.dart';

class AppDrawer {
  static Widget getDrawer(context, height, width) {
    return Drawer(
      child: Container(
        color:Colors.white,
        child: Column(
          children: <Widget>[
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Container(decoration: linerGradient, child: logo)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(currentTab: 0)));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "Home",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(currentTab: 4)));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "My Profile",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(currentTab: 1)));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "My Appointments",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(currentTab: 2)));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "Create Meeting",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(currentTab: 3)));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "Notifications",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CloseEventsPage()));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: blue3)),
                      Text(
                        "Close Meetings",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: blue3)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Spacer(),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: Colors.black)),
                      Text(
                        "Contact Us",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Home(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          height: height * 0.05,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              color: Colors.black)),
                      Text(
                        "Logout",
                        style: kHeading4Style,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01)
          ],
        ),
      ),
    );
  }
}
