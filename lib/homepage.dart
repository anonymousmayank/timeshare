import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/create/createEvent.dart';
import 'package:timeshare/drawer/drawer.dart';
import 'package:timeshare/events/events.dart';
import 'package:timeshare/appointments/closeEvents.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  bool gettingMeetings = true, gettingUserDetails=true, gettingCategories=true;
  int currentIndex;
  List meetings = [];
  List<String> meetingCategories=['Select Category of Meeting'];
  String uid;
  Map userSavedDetails={};
  
  
  _HomePageState({this.currentIndex});
  
  Future<void> _handleRefresh() async {
    setState(() {
      gettingMeetings=true;
      gettingUserDetails=true;
    });
    await getMeetings();
    await getUserDetails();
    
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void initState() {
    getMeetings();
    getUserDetails();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
    EventsListPage(meetings:meetings,meetingsCopy: meetings, categories:meetingCategories, user:userSavedDetails, uid:uid),
    SchedulePage(meetings:meetings, user:userSavedDetails, uid:uid),
    CreateEventPage(user:userSavedDetails, uid: uid, categories:meetingCategories),
    NotificationsPage(user:userSavedDetails, uid:uid),
    ProfilePage(user:userSavedDetails, uid:uid)
  ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer.getDrawer(context, height, width),
      body: Container(
        decoration: linerGradient,
        child: Stack(
          children: [
            
            (gettingMeetings || gettingUserDetails || gettingCategories)?Container(
                  height: height,
                  width: width,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                    child: Container(
                      height: height * 0.2,
                      width: height * 0.2,
                      child: LiquidCircularProgressIndicator(
                        value: 0.5, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(
                            blue3), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors.transparent,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text("Loading...",
                            style:
                                kHeading4Style.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                )
              : LiquidPullToRefresh(
              color: blue1,
              springAnimationDurationInMilliseconds: 500,
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              showChildOpacityTransition: false,
              child: Container(height: height, child: tabs[currentIndex]),
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
            ),
          ],
        ),
      ),
    );
  }
  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('userDetailsLocal') ?? '';
    uid = prefs.getString('UserID');
    if (userDetailsString != null) {
      userSavedDetails = json.decode(userDetailsString);
       setState(() {
        gettingUserDetails=false;
      });
    } else {
      snackBar('Something went wrong. Please sign in again!!');
      Navigator.pop(context);
    }
  }

  getMeetings() async {
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');
    meetings=[];
    List snapshots;
    await meetingRef.get().then((querySnapshot) {
      snapshots = querySnapshot.docs;
    });
    
    snapshots.forEach((element) {
      meetings.add({'id': element.id, 'data': element.data()});
    });
    print(meetings);
    meetings.sort((a, b) => (b['data']['timeStamp']).compareTo(a['data']['timeStamp']));
    meetings.sort((a, b) => (a['data']['category']).compareTo(b['data']['category']));
    print(meetings);
    setState(() {
      gettingMeetings = false;
    });
  }

  getCategories() async {
    final categoryRef = FirebaseFirestore.instance.collection('/meetingCategories');
    List snapshots;
    await categoryRef.get().then((querySnapshot) {
      snapshots = querySnapshot.docs;
    });
    snapshots.forEach((element) {
      meetingCategories.add(element['categoryName'].toString());
    });
    print(meetingCategories);
    setState(() {
      gettingCategories=false;
    });
  }
}
