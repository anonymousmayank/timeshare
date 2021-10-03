import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:timeshare/constants.dart';

class EventPage extends StatefulWidget {
  List meetings;
  Map meeting;
  String meetingID, uid;
  Map user;

  EventPage({this.meetings, this.meeting, this.meetingID, this.user, this.uid});
  @override
  _EventPageState createState() => _EventPageState(
      meetings: meetings,
      meeting: meeting,
      meetingID: meetingID,
      user: user,
      uid: uid);
}

class _EventPageState extends State<EventPage> {
  List meetings;
  Map meeting;
  Map user;
  String meetingID, uid;
  String hostProfilePicURL;
  bool joiningMeeting = false,
      addingToJoinedMeeting = false,
      gettingHostProfilePic = true;
  bool joinedStatus = false;
  _EventPageState(
      {this.meetings, this.meeting, this.meetingID, this.user, this.uid});

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  checkJoiningStatus() {
    if (meeting['attendees'].length >= meeting['guests']) {
      setState(() {
        joinedStatus = true;
      });
    } 
    else {
      print(meeting);
      for (var map in meeting['attendees']) {
        if (map.containsKey("id")) {
          if (map["id"] == uid) {
            setState(() {
              joinedStatus = true;
            });
          }
        }
      }
      for (var map in meeting['requests']) {
      if (map.containsKey("id")) {
        // print(map["id"]+" , "+uid);
        if (map["id"] == uid) {
          setState(() {
            joinedStatus = true;
          });
        }
      }
    }
    }
    
  }

  makeAttendeeList(height, width, attendees) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: attendees.length - 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 70,
                color: blue3,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      width: 70,
                      height: 70,
                      child: CachedNetworkImage(
                        width: width * 0.1,
                        imageUrl: attendees[index + 1]['image'],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                LinearProgressIndicator(
                                    backgroundColor: blue3,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(blue1),
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(attendees[index + 1]['name'],
                              style:
                                  kHeading4Style.copyWith(color: Colors.white)),
                          Text(attendees[index + 1]['address'],
                              style: TextStyle(color: Colors.white70))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    getHostData(meeting['hostUID']);
    getUserDetails();
    checkJoiningStatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (joiningMeeting || addingToJoinedMeeting || gettingHostProfilePic)
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
                    center: Text("Joining...",
                        style: kHeading4Style.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            )
          : Container(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.25,
                        color: Color(0xFF70A6EF),
                        child: Center(
                            child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: height * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ScaleAnimatedText(meeting['category']),
                              WavyAnimatedText(meeting['category']),
                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        )),
                      ),
                      SizedBox(height: height * 0.005),
                      Row(
                        children: [
                          Container(width: width * 0.35),
                          Expanded(
                              child: Center(
                                  child: Text('Guest Status',
                                      style: kHeading2Style))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(width: width * 0.35),
                          Column(
                            children: [
                              Card(
                                color: Color(0xFF70A6EF),
                                child: Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  child: Center(
                                    child: Text(
                                      meeting['guests'].toString(),
                                      style: TextStyle(
                                          fontSize: height * 0.05,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'PoorStory'),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Required',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                color: Color(0xFF70A6EF),
                                child: Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  child: Center(
                                    child: Text(
                                      (meeting['attendees'].length - 1)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: height * 0.05,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'PoorStory'),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Joined',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                color: Color(0xFF70A6EF),
                                child: Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  child: Center(
                                    child: Text(
                                      (meeting['guests']-meeting['attendees'].length+1).toString(),
                                      style: TextStyle(
                                          fontSize: height * 0.05,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'PoorStory'),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Available',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meeting['hostName'],
                              style: TextStyle(
                                  fontSize: height * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                                meeting['address'] +
                                    ', ' +
                                    meeting['locality'] +
                                    ', ' +
                                    meeting['city'] +
                                    ', ' +
                                    meeting['state'] +
                                    ', ' +
                                    meeting['pinCode'],
                                style: TextStyle(fontSize: height * 0.023)),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: Text(
                                meeting['date'].split('-').reversed.join('-'),
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: Text(
                                    meeting['time'],
                                    style: TextStyle(
                                        fontSize: height * 0.023,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * 0.004,
                                    decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                          colors: [
                                            Color(0xFF70A6EF),
                                            Color(0xFFCFE4FD),
                                            Color(0xFFCFE4FD),
                                            Color(0xFF70A6EF)
                                          ],
                                          begin: FractionalOffset(0.0, 0.0),
                                          end: FractionalOffset(1.0, 0.0),
                                          stops: [0.0, 0.3, 0.6, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: Text(
                                    meeting['duration'],
                                    style: TextStyle(
                                        fontSize: height * 0.023,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Center(
                              child: TextButton(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.3),
                                  child: Text(
                                    joinedStatus ? "JOINED" : "JOIN",
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        letterSpacing: 2),
                                  ),
                                ),
                                onPressed: joinedStatus
                                    ? () {}
                                    : () {
                                        if (unclosedMeetings.length == 0) {
                                          setState(() {
                                            joiningMeeting = true;
                                            addingToJoinedMeeting = true;
                                          });
                                          addToMyJoinedMeetings();
                                        } else {
                                          print(unclosedMeetings.length);
                                          snackBar(
                                              'You have '+unclosedMeetings.length.toString()+' Pending Meetings to close');
                                        }
                                      },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.01),
                                      side: BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              'Attendees : ',
                              style: kHeading3Style.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.25,
                              child: makeAttendeeList(
                                  height, width, meeting['attendees']),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: height * 0.2,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        width: width * 0.3,
                        height: height * 0.15,
                        imageUrl: hostProfilePicURL,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                LinearProgressIndicator(
                                    backgroundColor: blue3,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(blue1),
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.only(left: width * 0.05),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Map meetingData;

  List unclosedMeetings = [];
  getUserDetails() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    List joinedMeetingsId, myMeetingsId;
    await userRef.doc(uid).get().then((DocumentSnapshot) async {
      userData = DocumentSnapshot.data();
      joinedMeetingsId = userData['joinedMeetings'];
      myMeetingsId = userData['myMeetings'];
    }).whenComplete(() async {
      print(joinedMeetingsId);
      print(myMeetingsId);
      await getJoinedMeetingsData(joinedMeetingsId);
      await getMyMeetingsData(myMeetingsId);
      print(unclosedMeetings);
    });
  }

  getHostData(hostUID) async {
    print(hostUID);
    final hostRef = FirebaseFirestore.instance.collection('/users');
    await hostRef.doc(hostUID).get().then((DocumentSnapshot) {
      hostProfilePicURL = DocumentSnapshot.data()['profilePic'];
    }).whenComplete(() => setState(() {
          gettingHostProfilePic = false;
        }));
  }

  getJoinedMeetingsData(joinedMeetingsId) async {
    meetings.forEach((element) {
      print('meeting');
      if (joinedMeetingsId.contains(element['id'])) {
        element['data']['attendees'].forEach((att) {
          // print(att);
          // print(DateTime.parse(element['data']['date']).isBefore(DateTime.now()));
          if (att['id'] == uid &&
              att['closed'] == false &&
              DateTime.parse(element['data']['date'])
                  .isBefore(DateTime.now())) {
            unclosedMeetings.add(element['data']);
          }
        });
      }
    });
  }

  getMyMeetingsData(myMeetingsId) {
    meetings.forEach((element) {
      if (myMeetingsId.contains(element['id'])) {
        element['data']['attendees'].forEach((att) {
          if (att['id'] == uid &&
              att['closed'] == false &&
              DateTime.parse(element['data']['date'])
                  .isBefore(DateTime.now())) {
            unclosedMeetings.add(element['data']);
          }
        });
      }
    });
  }

  addToMyJoinedMeetings() async {
    await updateMeetingRequests();
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      userData = DocumentSnapshot.data();
      userData['joinedMeetings'].add(meetingID);
      // print(userData);
    });
    await userRef.doc(uid).set(userData).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
      setState(() {
        addingToJoinedMeeting = false;
      });
    });
    setState(() {
      addingToJoinedMeeting = false;
    });
    snackBar('On confirmation by Host '+ meeting['hostName']+', you will receive notification.');
    Navigator.pop(context);
  }

  updateMeetingRequests() async {
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');

    await meetingRef.doc(meetingID).get().then((DocumentSnapshot) {
      meetingData = DocumentSnapshot.data();

      meetingData['requests'].add({
        'id': uid,
        'name': user['firstName'] + ' ' + user['lastName'],
        'image': user['profilePic'],
        'address': user['address'] +
            ', ' +
            user['locality'] +
            ', ' +
            user['city'] +
            ', ' +
            user['state'] +
            ', ' +
            user['pinCode'],
      });
    });
    await sendNotificationToHost(meetingData['hostUID']);
    await meetingRef.doc(meetingID).set(meetingData).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
      setState(() {
        joiningMeeting = false;
      });
    });
    setState(() {
      joiningMeeting = false;
    });
  }

  sendNotificationToHost(hostUID) async {
    print(hostUID);
    final hostRef = FirebaseFirestore.instance.collection('/users');
    Map hostData;
    await hostRef.doc(hostUID).get().then((DocumentSnapshot) {
      hostData = DocumentSnapshot.data();
      hostData['notifications'].add({
        'myMeeting': true,
        'accepted': true,
        'sender': user['firstName'] + ' ' + user['lastName'],
        'meetingID': meetingID,
        'meetingCategory': meetingData['category'],
        'senderID': uid,
        'date': meetingData['date']
      });
    });
    await hostRef.doc(hostUID).set(hostData).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
    });
  }
}
