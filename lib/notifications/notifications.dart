import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/constants.dart';

import '../customDatatypes/notificationDatatype.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List notifications = [
    NotificationData(
        myMeeting: false,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: false,
        accepted: false,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: true,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: false,
        accepted: false,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: false,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: true,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: false,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: false,
        accepted: false,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
    NotificationData(
        myMeeting: true,
        accepted: true,
        sender: 'Mr. Rakesh Sharma',
        id: '123456',
        date: '10/06/2021'),
  ];

  Widget createNotificationList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notifications.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(height: height * 0.1),
                userDetails,
                SizedBox(
                  height: height * 0.03,
                )
              ],
            );
          } else if (index <= notifications.length) {
            index -= 1;
            return Card(
                child: Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.1),
                        color: notifications[index].myMeeting?yellow:notifications[index].accepted?green:red),
                    height: height * 0.07,
                    width: width * 0.012,
                  ),
                  SizedBox(
                    width: height * 0.01,
                  ),
                  notifications[index].myMeeting
                      ? FaIcon(FontAwesomeIcons.exclamationCircle, color:yellow)
                      : notifications[index].accepted
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
                            notifications[index].sender,
                            style: kHeading5Style.copyWith(color: blue3),
                          ),
                          Row(
                            children: [
                              Text(
                                notifications[index].myMeeting?'Has requested to join your meeting':notifications[index].accepted?'Accepted your meeting request':'Declined your meeting request',
                                style: kInputLabelStyle.copyWith(
                                    color: Colors.blueGrey),
                                overflow: TextOverflow.fade,
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
                              Text('Meeting Id - 123456'),
                              Spacer(),
                              Text('Meeting-Date - 10/06/2021')
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
    return createNotificationList(height, width);
  }
}
