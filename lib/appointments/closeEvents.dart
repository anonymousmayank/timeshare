import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:timeshare/constants.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';
import 'package:timeshare/drawer/drawer.dart';
import '../customDatatypes/eventDatatype.dart';

class CloseEventsPage extends StatefulWidget {
  @override
  _CloseEventsPageState createState() => _CloseEventsPageState();
}

class _CloseEventsPageState extends State<CloseEventsPage> {
  List events = [
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ]),
    Event(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        attendees: [
          Attendee(
              name: 'Mr. Ramesh Sharma',
              image: 'assets/profile.jfif',
              id: '4',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Ritik Kaushik',
              image: 'assets/profile.jfif',
              id: '5',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Lalit Mohan',
              image: 'assets/profile.jfif',
              id: '6',
              address: 'Crossings Republik')
        ],
        requests: [
          Attendee(
              name: 'Ms. Ritika Malik',
              image: 'assets/profile.jfif',
              id: '1',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Ms. Richa Srivastava',
              image: 'assets/profile.jfif',
              id: '2',
              address: 'Crossings Republik'),
          Attendee(
              name: 'Mr. Tanuj Yadav',
              image: 'assets/profile.jfif',
              id: '3',
              address: 'Crossings Republik')
        ])
  ];

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget makeEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: events.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                userDetails,
                SizedBox(height: height * 0.03),
                Text(
                  'Unclosed Events',
                  style: kHeading3Style,
                ),
                SizedBox(height: height * 0.01),
              ],
            );
          } else if (index <= events.length) {
            index -= 1;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.003),
              child: Card(
                  child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.005),
                    color: Colors.white.withOpacity(0.9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              events[index].fromTime +
                                  ' - ' +
                                  events[index].toTime,
                              style: kHeading5Style),
                          Spacer(),
                          Text(events[index].date, style: kHeading5Style)
                        ],
                      ),
                      Text(events[index].category,
                          style:
                              kHeading2Style.copyWith(fontFamily: 'PoorStory')),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Text('HOST - ', style: kHeading4Style),
                          Text(events[index].hostName,
                              style: kHeading4Style.copyWith(color: blue3))
                        ],
                      ),
                      Text(events[index].address + ', ' + events[index].city,
                          style: kHeading5Style.copyWith(
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: height * 0.005),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.051,
                            width: width * 0.3,
                            child: Stack(
                                children: makeAttendeeCircles(
                                    height, width, events[index].attendees)),
                          ),
                          Spacer(),
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: new Text(
                                "Close",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            onPressed: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                    height: height * 0.45,
                                    child: Column(
                                      children: [
                                        SizedBox(height: height * 0.02),
                                        Text('Close Meeting',
                                            style: kHeading3Style.copyWith(
                                                color: blue3)),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Text(
                                            'Overall Experience of the meeting',
                                            style: kHeading4Style),
                                        SmoothStarRating(
                                            allowHalfRating: false,
                                            onRated: (v) {},
                                            starCount: 5,
                                            rating: 0,
                                            size: 40.0,
                                            color: blue3,
                                            borderColor: blue3,
                                            spacing: 0.0),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Text(
                                            'Anything else you would like to say',
                                            style: kHeading4Style),
                                        Card(
                                          child: Container(
                                            width: width * 0.9,
                                            decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        height * 0.005),
                                                color: Colors.white),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.01),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.multiline,
                                                minLines: 5,
                                                maxLines: 7,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter Feedback'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.04),
                                        TextButton(
                                          child: Container(
                                            height: height * 0.035,
                                            width: width * 0.9,
                                            child: Center(
                                              child: Text(
                                                "CLOSE",
                                                style: kButtonText,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            snackBar('Meeting Closed');
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(blue3),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
            );
          } else {
            return SizedBox(height: height * 0.01);
          }
        });
  }

  List<Widget> makeAttendeeCircles(height, width, attendees) {
    List<Widget> circles = [];
    for (int i = 0; i < attendees.length; i++) {
      if (i < 3) {
        circles.add(Positioned(
          left: height * i / 100,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jfif'),
            radius: height * 0.025,
          ),
        ));
      } else {
        circles.add(Positioned(
          left: height * 0.08,
          top: height * 0.0125,
          child: Text('+' + (attendees.length - 3).toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: height * 0.025)),
        ));
        break;
      }
    }
    return circles;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer.getDrawer(context, height, width),
        body: Container(
            decoration: linerGradient,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Stack(
              children: [
                makeEventList(height, width),
                Positioned(
                    top: height * 0.06,
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
                              child:
                                  FaIcon(FontAwesomeIcons.bars, color: blue3))),
                    )),
              ],
            )));
  }
}
