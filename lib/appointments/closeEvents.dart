import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
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
  bool gettingMeetings=true, gettingUnclosedMeetings=true;
  double rating;
  String feedback=' ';
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

  initState(){
    getMeetings();
    super.initState();
  }
  
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
    print(unclosedMeetings.length);
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: unclosedMeetings.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                userDetailsSection(userData['firstName']+' '+ userData['lastName'], uid, userData['profilePic']),
                SizedBox(height: height * 0.03),
                Text(
                  'Unclosed Events',
                  style: kHeading3Style,
                ),
                SizedBox(height: height * 0.01),
              ],
            );
          } else if (index <= unclosedMeetings.length) {
            index -= 1;
            Map meeting=unclosedMeetings[index]['data'];
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
                                            onRated: (v) {
                                              rating=v;
                                            },
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
                                                onChanged: (input){
                                                  feedback=input;
                                                },
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
                                            closeMeeting(unclosedMeetings[index]['id']);
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
                              ]),
                        ),
                      ],
                    ),
                  ))
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
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer.getDrawer(context, height, width),
        body: (!gettingMeetings && !gettingUnclosedMeetings)?Container(
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
            )):Container(
              decoration: linerGradient,
              child: Container(
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
                          style: kHeading4Style.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            
            );
  }
  Map userData;
  List unclosedMeetings=[];
  List meetings;
  String uid=FirebaseAuth.instance.currentUser.uid;

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
    print(meetings);
    setState(() {
      gettingMeetings = false;
    });
    getUserDetails();
  }


  getUserDetails() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    
    List joinedMeetingsId, myMeetingsId;
    await userRef.doc(uid).get().then((DocumentSnapshot) async{
      userData = DocumentSnapshot.data();
      joinedMeetingsId = userData['joinedMeetings'];
      myMeetingsId = userData['myMeetings'];
      
      
    }).whenComplete(() async{
      print(joinedMeetingsId);
      print(myMeetingsId);
      await getJoinedMeetingsData(joinedMeetingsId);
      await getMyMeetingsData(myMeetingsId);
      setState(() {
        gettingUnclosedMeetings=false;
      });
      print(unclosedMeetings);
    }
    
    );
  }
  getJoinedMeetingsData(joinedMeetingsId) async {
    meetings.forEach((element) {
      if (joinedMeetingsId.contains(element['id'])) {
        element['data']['attendees'].forEach((att){
          if(att['id']==uid && att['closed']==false && DateTime.parse(element['data']['date']).isBefore(DateTime.now())){
            unclosedMeetings.add(element);
          }
        });
      }
    });
  }

  getMyMeetingsData(myMeetingsId) {
    meetings.forEach((element) {
      if (myMeetingsId.contains(element['id'])) {
        element['data']['attendees'].forEach((att){
          if(att['id']==uid && att['closed']==false && DateTime.parse(element['data']['date']).isBefore(DateTime.now())){
            unclosedMeetings.add(element);
          }
        });
      }
    });
  }

  closeMeeting(meetingID) async{
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');
    Map meetingData;
    await meetingRef.doc(meetingID).get().then((DocumentSnapshot) {
      meetingData = DocumentSnapshot.data();
      meetingData['attendees'].forEach((att){
        if(att['id']==uid){
          att['closed']=true;
          att['starRating']=rating;
          att['feedback']=feedback;
        }
      });
    });
    print(meetingData);
    await meetingRef.doc(meetingID).set(meetingData).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
    });
    setState(() {
      gettingUnclosedMeetings=true;
      gettingMeetings=true;
    });
    unclosedMeetings=[];
    getMeetings();
  }
}
