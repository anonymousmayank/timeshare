import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:timeshare/constants.dart';

import '../customDatatypes/notificationDatatype.dart';

class NotificationsPage extends StatefulWidget {
  String uid;
  Map user;
  NotificationsPage({this.uid, this.user});
  @override
  _NotificationsPageState createState() => _NotificationsPageState(user:user, uid:uid);
}

class _NotificationsPageState extends State<NotificationsPage> {
  String uid;
  Map user;
  _NotificationsPageState({this.user, this.uid});
  bool gettingNotifications=true;
  List notifications;
  // List notifications = [
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: false,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: true,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: false,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: true,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: false,
  //       accepted: false,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  //   NotificationData(
  //       myMeeting: true,
  //       accepted: true,
  //       sender: 'Mr. Rakesh Sharma',
  //       id: '123456',
  //       date: '10/06/2021'),
  // ];

  @override
  void initState() {
    getNotifications();
    super.initState();
  }
  
  Widget createNotificationList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notifications.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(height: height * 0.1),
                userDetailsSection(user['firstName']+' '+ user['lastName'], uid, user['profilePic']),
                SizedBox(
                  height: height * 0.03,
                )
              ],
            );
          } else if (index <= notifications.length) {
            index=notifications.length-index;
            Map notification=notifications[index];
            return Card(
                child: Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.1),
                        color: notification['myMeeting']?yellow:notification['accepted']?green:red),
                    height: height * 0.07,
                    width: width * 0.012,
                  ),
                  SizedBox(
                    width: height * 0.01,
                  ),
                  notification['myMeeting']
                      ? FaIcon(FontAwesomeIcons.exclamationCircle, color:yellow)
                      : notification['accepted']
                          ? FaIcon(FontAwesomeIcons.solidCheckCircle, color:green)
                          : FaIcon(FontAwesomeIcons.solidTimesCircle, color:red),
                  SizedBox(
                    width: height * 0.015,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification['sender'],
                            style: kHeading5Style.copyWith(color: blue3),
                          ),
                          Row(
                            children: [
                              SingleChildScrollView(
                                child: Text(
                                  (notification['myMeeting'] && notification['accepted'])?
                                  'Pl acknowledge his request for joining':
                                  (notification['myMeeting'] && !notification['accepted'])?
                                  'Is unable to join the meeting':
                                  (!notification['myMeeting'] && notification['accepted'])?
                                  'Accepted your meeting request':
                                  'Declined your meeting request',
                                  style: kInputLabelStyle.copyWith(
                                      color: Colors.blueGrey),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text('X',
                                      style: TextStyle(
                                          color: blue3,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: height * 0.01,
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Text('Meeting - '+notification['meetingCategory'].toString(), style:TextStyle(fontSize: height*0.015)),
                              Spacer(),
                              Text('Meeting-Date - '+notification['date'].split('-').reversed.join('-'), style:TextStyle(fontSize: height*0.015))
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ));
          } else {
            return SizedBox(height: height * 0.1);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        gettingNotifications?Container(
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
              : Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: createNotificationList(height, width)),
      ],
    );
  }

  getNotifications() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      userData = DocumentSnapshot.data();
      notifications=userData['notifications'];
      // print(userData);
    }).whenComplete(() =>setState(() {
      gettingNotifications=false;
    }));
    
    
  }
}
