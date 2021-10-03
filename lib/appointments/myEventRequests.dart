import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';

class EventRequestPage extends StatefulWidget {
  Map meeting;
  String meetingID;
  EventRequestPage({this.meeting, this.meetingID});

  @override
  _EventRequestPageState createState() =>
      _EventRequestPageState(meeting: meeting, meetingID: meetingID);
}

class _EventRequestPageState extends State<EventRequestPage> {
  Map meeting;
  String meetingID;
  _EventRequestPageState({this.meeting, this.meetingID});

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget makeRequestsList(height, width) {
    return ListView.builder(
        itemCount: meeting['requests'].length + meeting['attendees'].length-1,
        itemBuilder: (context, index) {
          if (index < meeting['requests'].length) {
            Map request = meeting['requests'][index];
            print(request);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.005),
              child: Card(
                  child: Container(
                padding: EdgeInsets.all(height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      request['name'],
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      request['address'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: new Text(
                                "Accept",
                                style: TextStyle(fontSize: height * 0.025),
                              ),
                            ),
                            onPressed: () {
                              accept(request);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
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
                          SizedBox(width: width * 0.01),
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: new Text(
                                "Decline",
                                style: TextStyle(fontSize: height * 0.025),
                              ),
                            ),
                            onPressed: () {
                              decline(request);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(height * 0.01),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
            );
          } else {
            List attendees = meeting['attendees'];
            index -= meeting['requests'].length;
            index+=1;
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: width * 0.05),
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
                          imageUrl: attendees[index]['image'],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  LinearProgressIndicator(
                                      backgroundColor: blue3,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(blue1),
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(attendees[index]['name'],
                                style: kHeading4Style.copyWith(
                                    color: Colors.white)),
                            Text(attendees[index]['address'],
                                style: TextStyle(color: Colors.white70))
                          ],
                        ),
                      ),
                      FaIcon(FontAwesomeIcons.solidCheckCircle, color:Colors.white),
                      SizedBox(width: width*0.03,)
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  decoration: linerGradient,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.07),
                      Text(
                        meeting['category'],
                        style: kHeading1Style.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: Text(
                          meeting['date'].split('-').reversed.join('-'),
                          style: TextStyle(
                              fontSize: height * 0.025,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Text(
                                meeting['time'],
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * 0.004,
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD)
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: Center(child: makeRequestsList(height, width)),
                )
              ],
            ),
            Positioned(
              top: height * 0.26,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Card(
                          color: Colors.black,
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
                          color: Colors.black,
                          child: Container(
                            height: height * 0.06,
                            width: height * 0.06,
                            child: Center(
                              child: Text(
                                (meeting['attendees'].length - 1).toString(),
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
                          color: Colors.black,
                          child: Container(
                            height: height * 0.06,
                            width: height * 0.06,
                            child: Center(
                              child: Text(
                                meeting['requests'].length.toString(),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Map meetingData;
  accept(request) async {
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');
    await meetingRef.doc(meetingID).get().then((DocumentSnapshot) {
      meetingData = DocumentSnapshot.data();
      request['closed'] = false;
      request['starRating'] = 0;
      request['feedback'] = ' ';
      meetingData['attendees'].add(request);
      meetingData['requests']
          .removeWhere((item) => item['id'] == request['id']);
    });
    await sendNotificationToRequester(request['id'], true);
    await meetingRef.doc(meetingID).set(meetingData).catchError((e) {
      print(e);
    });
    setState(() {
      // meeting['requests'].forEach((item)=>{
      //   if(item['id']==request['id']){
      //     meeting['attendees'].add(item)
      //   }
      // });
      request['closed'] = false;
      request['starRating'] = 0;
      request['feedback'] = ' ';
      meeting['attendees'].add(request);
      meeting['requests'].removeWhere((item) => item['id'] == request['id']);
    });
    snackBar('Request Accepted');
  }

  decline(request) async {
    final meetingRef = FirebaseFirestore.instance.collection('/meetings');
    await meetingRef.doc(meetingID).get().then((DocumentSnapshot) {
      meetingData = DocumentSnapshot.data();
      meetingData['requests']
          .removeWhere((item) => item['id'] == request['id']);
    });
    await sendNotificationToRequester(request['id'], false);
    await meetingRef.doc(meetingID).set(meetingData).catchError((e) {
      print(e);
    });
    setState(() {
      meeting['requests'].removeWhere((item) => item['id'] == request['id']);
    });
    snackBar('Request Declined');
  }

  sendNotificationToRequester(requestUID, status) async {
    final requesterRef = FirebaseFirestore.instance.collection('/users');
    Map requesterData;
    await requesterRef.doc(requestUID).get().then((DocumentSnapshot) {
      requesterData = DocumentSnapshot.data();
      requesterData['notifications'].add({
        'myMeeting': false,
        'accepted': status,
        'sender': meetingData['hostName'],
        'meetingID': meetingID,
        'meetingCategory': meetingData['category'],
        'senderID': meetingData['hostUID'],
        'date': meetingData['date']
      });
    });
    await requesterRef.doc(requestUID).set(requesterData).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
    });
  }
}
