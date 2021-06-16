import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/create/createEvent.dart';
import 'package:timeshare/drawer/drawer.dart';
import 'package:timeshare/events/events.dart';
import 'package:timeshare/appointments/closeEvents.dart';
import 'package:timeshare/profile/profile.dart';
import 'package:timeshare/appointments/schedule.dart';

import 'notifications/notifications.dart';

class HomePage extends StatefulWidget {
  int currentTab;
  HomePage({@required this.currentTab});
  @override
  _HomePageState createState() => _HomePageState(currentIndex: currentTab);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentIndex;
  _HomePageState({this.currentIndex});
  List<Widget> tabs = [
    EventsListPage(),
    SchedulePage(),
    CreateEventPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer.getDrawer(context, height, width),
      body: Container(
        decoration: linerGradient,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: tabs[currentIndex],
            ),
            Positioned(
                top: height * 0.06,
                left: width * 0.05,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                      height: height * 0.05,
                      width: height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height),
                          color: Colors.white),
                      child: Center(
                          child: FaIcon(FontAwesomeIcons.bars, color: blue3))),
                )),
            Positioned(
              top: height * 0.92,
              child: Container(
                  height: height * 0.08,
                  width: width,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(
                                  Icons.home,
                                  size: height * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text('Home',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(Icons.event_available,
                                    size: height * 0.04, color: Colors.white),
                              ),
                            ),
                            Text('Appointments',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(Icons.queue,
                                    size: height * 0.04, color: Colors.white),
                              ),
                            ),
                            Text('Create',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(Icons.notifications_active,
                                    size: height * 0.04, color: Colors.white),
                              ),
                            ),
                            Text('Notifications',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 4;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(Icons.person,
                                    size: height * 0.04, color: Colors.white),
                              ),
                            ),
                            Text('Profile',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
