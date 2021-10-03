import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';
import '../customDatatypes/eventDatatype.dart';
import '../customDatatypes/scheduleDatatype.dart';
import 'myEventRequests.dart';

class SchedulePage extends StatefulWidget {
  List meetings;
  Map user;
  String uid;
  SchedulePage({this.meetings, this.user, this.uid});
  @override
  _SchedulePageState createState() =>
      _SchedulePageState(meetings: meetings, user: user, uid: uid);
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;
  bool fetchingMeetings=true;
  List meetings;
  Map user;
  String uid;
  _SchedulePageState({this.meetings, this.user, this.uid});


  @override
  void initState() {
    super.initState();
    getUserDetails();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List scheduledEvents = [
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: true,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: false,
        joined: true,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Inhouse Ludo',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: false,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ]),
    ScheduledEvents(
        fromTime: '12:30 p.m',
        toTime: '2:30 p.m',
        date: '24-April-2021',
        category: 'Chess Championship',
        hostName: ' Mr. Rakesh Sharma',
        address: 'Crossings Republik',
        city: 'Ghaziabad',
        pending: true,
        joined: false,
        attendees: [
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif'),
          Attendee(name: 'Mr. ABC', image: 'assets/profile.jfif')
        ])
  ];
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

  Widget makeJoinedEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: joinedMeetings.length + 1,
        itemBuilder: (context, index) {
          if (index < joinedMeetings.length) {
            Map meeting=joinedMeetings[index]['data'];
            List requestsId=[],attendeesId=[];
            meeting['requests'].forEach((element)=>{
              requestsId.add(element['id'])
            });
            meeting['attendees'].forEach((element)=>{
              attendeesId.add(element['id'])
            });
            return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.003),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(width * 0.016),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              width: width* 0.18,
                              height:height * 0.1,
                              imageUrl: meeting['hostProfilePic'],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                              LinearProgressIndicator(
                                  backgroundColor: blue3,
                                  valueColor: AlwaysStoppedAnimation<Color>(blue1),
                                  value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                            ),
                            
                            SizedBox(
                              width: width * 0.02,
                            ),
                            SizedBox(
                                width: width * 0.62,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text('Date - '+meeting['date'].split('-').reversed.join('/')+', '+meeting['time'],
                                        style: kHeading5Style.copyWith(
                                            color: Colors.black45, fontWeight: FontWeight.w500)),
                                      Spacer(),
                                      FaIcon(
                                          FontAwesomeIcons.clock,
                                          size: height * 0.018,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: width * 0.005),
                                        Text(meeting['duration'],
                                            style: kHeading6Style.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black45))
                                    ],),
                                    
                                    Text(meeting['category'],
                                        style: kHeading2Style.copyWith(
                                            fontWeight: FontWeight.w500),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,),
                                    Row(
                                      children: [
                                        Text('HOST - ',
                                            style: kHeading6Style.copyWith(
                                                color: Colors.black45)),
                                        Text(meeting['hostName'],
                                            style: kHeading5Style.copyWith(
                                                color: blue3))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: height * 0.018,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: width * 0.015),
                                        Expanded(
                                          child: Text(
                                              meeting['address']+', '+meeting['city'],
                                              style: kHeading6Style.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black45)),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: blue3,
                        ),
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.05),
                                      color: blue3.withOpacity(0.5)),
                                  child: Row(
                                      children: makeAttendeeCircles(
                                          height, width, meeting['attendees'])),
                                ),
                                Spacer(),
                                TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: new Text(
                                requestsId.contains(uid)
                                    ? "Pending"
                                    : attendeesId.contains(uid)
                                        ? "Joined"
                                        : "Declined",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            onPressed: null,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  requestsId.contains(uid)
                                      ? Colors.white
                                      : attendeesId.contains(uid)
                                          ? Color(0xFF00e600)
                                          : Colors.red),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.015),
                          (requestsId.contains(uid) ||
                                  attendeesId.contains(uid))
                              ? TextButton(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    child: new Text(
                                      "Cancel",
                                      style: TextStyle(fontSize: height * 0.02),
                                    ),
                                  ),
                                  onPressed: (){
                                    cancelRequest(joinedMeetings[index]['id'], joinedMeetings[index]['data']);
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                )
                              : Center()
                              ]),
                        ),
                      ],
                    ),
                  ))
                  );
          } else {
            return SizedBox(height: height * 0.08);
          }
        });
  }

  Widget makeMyEventList(height, width) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: myMeetings.length + 1,
        itemBuilder: (context, index) {
          if (index < myMeetings.length) {
            Map meeting=myMeetings[index]['data'];
            String meetingID=myMeetings[index]['id'];
            return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.003),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(width * 0.016),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              width: width* 0.18,
                              height:height * 0.1,
                              imageUrl: meeting['hostProfilePic'],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                              LinearProgressIndicator(
                                  backgroundColor: blue3,
                                  valueColor: AlwaysStoppedAnimation<Color>(blue1),
                                  value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                            ),
                            
                            SizedBox(
                              width: width * 0.02,
                            ),
                            SizedBox(
                                width: width * 0.62,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text('Date - '+meeting['date'].split('-').reversed.join('/')+', '+meeting['time'],
                                        style: kHeading5Style.copyWith(
                                            color: Colors.black45, fontWeight: FontWeight.w500)),
                                      Spacer(),
                                      FaIcon(
                                          FontAwesomeIcons.clock,
                                          size: height * 0.018,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: width * 0.005),
                                        Text(meeting['duration'],
                                            style: kHeading6Style.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black45))
                                    ],),
                                    
                                    Text(meeting['category'],
                                        style: kHeading2Style.copyWith(
                                            fontWeight: FontWeight.w500),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,),
                                    Row(
                                      children: [
                                        Text('HOST - ',
                                            style: kHeading6Style.copyWith(
                                                color: Colors.black45)),
                                        Text(meeting['hostName'],
                                            style: kHeading5Style.copyWith(
                                                color: blue3))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: height * 0.018,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(width: width * 0.015),
                                        Expanded(
                                          child: Text(
                                              meeting['address']+', '+meeting['city'],
                                              style: kHeading6Style.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black45)),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: blue3,
                        ),
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.05),
                                      color: blue3.withOpacity(0.5)),
                                  child: Row(
                                      children: makeAttendeeCircles(
                                          height, width, meeting['attendees'])),
                                ),
                                Spacer(),
                                TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: new Text(
                                "Requests",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventRequestPage(meeting:meeting,
                                          meetingID: meetingID)));
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
                          ),
                          // SizedBox(width: width * 0.015),
                          // TextButton(
                          //         child: Padding(
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: width * 0.02),
                          //           child: new Text(
                          //             "Cancel",
                          //             style: TextStyle(fontSize: height * 0.02),
                          //           ),
                          //         ),
                          //         onPressed: null,
                          //         style: ButtonStyle(
                          //           foregroundColor:
                          //               MaterialStateProperty.all<Color>(
                          //                   Colors.white),
                          //           backgroundColor:
                          //               MaterialStateProperty.all<Color>(
                          //                   Colors.red),
                          //           shape: MaterialStateProperty.all(
                          //             RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(30.0),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                              ]),
                        ),
                      ],
                    ),
                  ))
                  );
          } else {
            return SizedBox(height: height * 0.1);
          }
        });
  }

  List<Widget> makeAttendeeCircles(height, width, attendees) {
    List<Widget> circles = [];
    for (int i = 0; i < attendees.length; i++) {
      if (i < 3) {
        circles.add(
          Container(
            height: height * 0.04,
            width: height * 0.04,
            child: Card(
              elevation: 0,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                imageUrl: attendees[i]['image'],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(
                        backgroundColor: blue3,
                        valueColor: AlwaysStoppedAnimation<Color>(blue1),
                        value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height),
              ),
            ),
          ),
        );
      } else {
        circles.add(Positioned(
          left: height * 0.08,
          top: height * 0.0125,
          child: Text('+' + (attendees.length - 3).toString(),
              style: kHeading4Style),
        ));
        break;
      }
    }
    return circles;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              userDetailsSection(user['firstName']+' '+ user['lastName'], uid, user['profilePic']),
              SizedBox(
                height: height * 0.02,
              ),
              TabBar(
                  labelStyle: TextStyle(
                      fontSize: height * 0.03, fontWeight: FontWeight.w500),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.black,
                  indicatorWeight: 2,
                  controller: _controller,
                  tabs: [Tab(text: 'Joined Events'), Tab(text: 'My Events')]),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.7,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    makeJoinedEventList(height, width),
                    makeMyEventList(height, width)
                  ],
                ),
              ),
              //
            ],
          ),
        ),
        fetchingMeetings
              ? Container(
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
              : Center()
      ],
    );
  }

  List joinedMeetings = [];
  List myMeetings = [];
  List joinedMeetingsId, myMeetingsId;

  getUserDetails() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      userData = DocumentSnapshot.data();
      joinedMeetingsId = userData['joinedMeetings'];
      myMeetingsId = userData['myMeetings'];
      getJoinedMeetingsData(joinedMeetingsId);
      getMyMeetingsData(myMeetingsId);
    }).whenComplete(() => {
          setState(() {
            fetchingMeetings = false;
          }),
        });

    
  }

  getJoinedMeetingsData(joinedMeetingsId) async {

    meetings.forEach((element) {
      if (joinedMeetingsId.contains(element['id'])) {
        joinedMeetings.add(element);
      }
    });
  }

  getMyMeetingsData(myMeetingsId) {
    meetings.forEach((element) {
      if (myMeetingsId.contains(element['id'])) {
        myMeetings.add({
          'id':element['id'],
          'data':element['data']
          });
      }
    });
  }

  cancelRequest(cancelId, data) async{
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      userData = DocumentSnapshot.data();
      userData['joinedMeetings']
          .removeWhere((item) => item == cancelId);
    });
    await userRef.doc(uid).set(userData).catchError((e) {
      print(e);
    });
    await sendNotificationtoHost(data, cancelId);
    setState(() {
      joinedMeetings.removeWhere((item) => item['id'] == cancelId);
    });
  }

  sendNotificationtoHost(data, cancelID) async{
    final hostRef = FirebaseFirestore.instance.collection('/users');
    Map hostData;
    print(data['hostUID']);
    await hostRef.doc(data['hostUID']).get().then((DocumentSnapshot) {
      hostData = DocumentSnapshot.data();
      print(hostData['notifications'].length);
      hostData['notifications'].add({
        'myMeeting': true,
        'accepted': false,
        'sender': user['firstName'] + ' ' + user['lastName'],
        'meetingID': cancelID,
        'meetingCategory': data['category'],
        'senderID': uid,
        'date': data['date']
      });
      
    });
    print(hostData['notifications'].length);
    await hostRef.doc(data['hostUID']).set(hostData).catchError((e) {
      print(e);
    });
  }

  removeUseronCancel(cancelId) async{
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');
    Map meetingData;
    await meetingRef.doc(cancelId).get().then((DocumentSnapshot) {
      meetingData = DocumentSnapshot.data();
      meetingData['attendees']
          .removeWhere((item) => item['id'] == uid);
    });
    // await sendNotificationToRequester(request['id'], false);
    await meetingRef.doc(uid).set(meetingData).catchError((e) {
      print(e);
    });
  }


}
