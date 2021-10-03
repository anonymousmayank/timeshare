import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeshare/constants.dart';

class CreateEventPage extends StatefulWidget {
  Map user;
  String uid;
  List<String> categories;
  CreateEventPage({this.user, this.uid, this.categories});
  @override
  _CreateEventPageState createState() => _CreateEventPageState(user:user, userID: uid, categories: categories);
}

class _CreateEventPageState extends State<CreateEventPage> {
  Map user;
  String userID;
  List<String> categories; 
  _CreateEventPageState({this.user, this.userID, this.categories});
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  
  bool checkedValue = false;
  String category = 'Select Category of Meeting', date, time, duration;
  int guests = 0;
  bool uploadingMeeting=false;
  String hours='Hours (HH)',minutes='Minutes (MM)';
  Map<String, dynamic> meeting = {
    'date': '',
    'time': '',
    'duration': '',
    'category': '',
    'hostName': '',
    'hostUID': '',
    'hostProfilePic':'',
    'address': '',
    'locality': '',
    'city': '',
    'state': '',
    'guests': 0,
    'pinCode': '',
    'timeStamp': '',
    'attendees': [],
    'requests': []
  };
  @override
  void initState() {
    super.initState();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            userDetailsSection(user['firstName']+' '+ user['lastName'], userID, user['profilePic']),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Create New Meeting',
              style: kHeading3Style,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Meeting Category',
              style: kHeading4Style,
            ),
            SizedBox(height: height * 0.008),
            Card(
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.005),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Padding(
                      padding: EdgeInsets.all(height * 0.01),
                      child: Text(category),
                    ),
                    isExpanded: true,
                    items: categories.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (input) {
                      setState(() {
                        category = input;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              'Date & Time of Meeting',
              style: kHeading4Style,
            ),
            SizedBox(height: height * 0.008),
            Card(
              child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.005),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: DateTimePicker(
                    
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().add(Duration(days: 1)).toString(),
                    firstDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Time",
                    use24HourFormat: false,
                    autovalidate: true,
                    style: TextStyle(fontSize: height * 0.02),
                    onChanged: (val) {
                      print(val);
                      date = val.substring(0, 10);
                      int hrs = int.parse(val.substring(11, 13));
                      if(hrs==0){
                        time=hrs.toString() + val.substring(13,16) + ' a.m';
                      }
                      else if(hrs<12){
                        time=hrs.toString() + val.substring(13,16) + ' a.m';
                      }
                      else if(hrs==12){
                        time=hrs.toString() + val.substring(13,16) + ' p.m';
                      }
                      else{
                        hrs-=12;
                        time=hrs.toString() + val.substring(13,16) + ' p.m';
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              'Duration of Meeting',
              style: kHeading4Style,
            ),
            SizedBox(height: height * 0.008),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.005),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: EdgeInsets.all(height * 0.01),
                            child: Text(hours),
                          ),
                          isExpanded: true,
                          items: ['01','02','03','04','05','06'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (input) {
                            setState(() {
                              hours = input;
                            });
                              
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
              child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.005),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Padding(
                        padding: EdgeInsets.all(height * 0.01),
                        child: Text(minutes),
                      ),
                      isExpanded: true,
                      items: ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (input) {
                        setState(() {
                          minutes = input;
                        });
                      },
                    ),
                  ),
              ),
            ),
                ),
              ],
            ),
            // Card(
            //   child: Container(
            //     decoration: new BoxDecoration(
            //         borderRadius: BorderRadius.circular(height * 0.005),
            //         color: Colors.white),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: height * 0.01),
            //       child: TextField(
            //         controller: textEditingController1,
            //         keyboardType: TextInputType.datetime,
            //         decoration: InputDecoration(
            //             border: InputBorder.none,
            //             hintText: 'Enter Duration (HH:MM)'),
            //         onChanged: (input) {
            //           duration = input;
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              'Number of Guests (Max 6)',
              style: kHeading4Style,
            ),
            SizedBox(height: height * 0.008),
            Card(
              child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.005),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: height * 0.01),
                  child: TextField(
                    controller: textEditingController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Maximum Guests Invited'),
                    onChanged: (input) {
                      guests = int.parse(input);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            TextButton(
              child: Container(
                height: height * 0.035,
                width: width * 0.9,
                child: Center(
                  child: Text(
                    "CREATE",
                    style: kButtonText,
                  ),
                ),
              ),
              onPressed: () {
                createEvent();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
          ],
        )),
        uploadingMeeting
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
                        center: Text("Creating...",
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

  String uid;
  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('userDetailsLocal') ?? '';
    uid = prefs.getString('UserID');
    if (userDetailsString != null) {
      Map userSavedDetails = json.decode(userDetailsString);
      return userSavedDetails;
    } else {
      snackBar('Something went wrong. Please sign in again!!');
      Navigator.pop(context);
      return '';
    }
  }

  createEvent() async {
    Map savedUserDetails = await getUserDetails();
    if (validate()) {
      setState(() {
        uploadingMeeting=true;
      });
      meeting['date'] = date;
      meeting['time'] = time;
      meeting['duration'] = duration;
      meeting['category'] = category;
      meeting['guests'] = guests;
      meeting['hostName'] =
          savedUserDetails['firstName'] + ' ' + savedUserDetails['lastName'];
      meeting['hostUID'] = uid;
      meeting['hostProfilePic'] = user['profilePic'];
      meeting['address'] = savedUserDetails['address'];
      meeting['locality'] = savedUserDetails['locality'];
      meeting['city'] = savedUserDetails['city'];
      meeting['state'] = savedUserDetails['state'];
      meeting['pinCode'] = savedUserDetails['pinCode'];
      meeting['timeStamp'] = DateTime.now().millisecondsSinceEpoch;
      meeting['attendees'] = [
        {
          'id': uid,
          'name': savedUserDetails['firstName'] +
              ' ' +
              savedUserDetails['lastName'],
          'image': savedUserDetails['profilePic'],
          'address': savedUserDetails['address'] +
              ', ' +
              savedUserDetails['locality'] +
              ', ' +
              savedUserDetails['city'] +
              ', ' +
              savedUserDetails['state'] +
              ', ' +
              savedUserDetails['pinCode'],
          'closed':false,
          'starRating':0,
          'feedback':' '
        }
      ];

      await uploadMeeting(meeting);
    } else {
      snackBar('Please fill the details correctly');
    }
  }

  bool validate() {
    if (date != null &&
        time != null &&
        hours != 'Hours (HH)' && minutes!='Minutes (MM)' &&
        category != 'Select Category of Meeting' &&
        guests > 0 && guests<=6) {
          duration= hours +':'+minutes;
          return true;
    } else {
      return false;
    }
  }

  uploadMeeting(meeting) async {
    final dbRef = FirebaseFirestore.instance.collection('/meetings');
    final meetingRef = await dbRef.add(meeting).catchError((e) {
      snackBar('Something went Wrong!! Please try again Later');
    });
    String meetingId = meetingRef.id;
    print(meetingId);
    addToMyMeetings(meetingId: meetingId);
  }

  addToMyMeetings({meetingId}) async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    Map userData;
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      userData = DocumentSnapshot.data();
      userData['myMeetings'].add(meetingId);
      // print(userData);
    });
    await userRef.doc(uid).set(userData).catchError((e) {
      print(e);
    });
    setState(() {
      uploadingMeeting=false;
    });
    textEditingController1.clear();
    textEditingController2.clear();
    setState(() {
      category='Select Category of Meeting';
      hours='Hours (HH)';
      minutes='Minutes (MM)';
    });
    snackBar('Meeting Created Successfully');
  }
}
