import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/homepage.dart';

class KYCPage extends StatefulWidget {
  Map userData;
  KYCPage(this.userData);
  @override
  _KYCPageState createState() => _KYCPageState(this.userData);
}

class _KYCPageState extends State<KYCPage> {
  Map<dynamic,dynamic> user;
  File adhaar, voterId, drivingLicense, passport;
  final picker = ImagePicker();
  int uploads = 0;
  bool uploading = false;
  _KYCPageState(this.user);

  initState() {
    super.initState();
    getUserId();
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

  Future getImage(type) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (type == 'adhaar' && (pickedFile != null)) {
      if (adhaar == null) {
        uploads += 1;
      }
      setState(() {
        adhaar = File(pickedFile.path);
      });
    } else if (type == 'voterId' && (pickedFile != null)) {
      if (voterId == null) {
        uploads += 1;
      }
      setState(() {
        voterId = File(pickedFile.path);
      });
    } else if (type == 'drivingLicense' && (pickedFile != null)) {
      if (drivingLicense == null) {
        uploads += 1;
      }
      setState(() {
        drivingLicense = File(pickedFile.path);
      });
    } else if (type == 'passport' && (pickedFile != null)) {
      if (passport == null) {
        uploads += 1;
      }
      setState(() {
        passport = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            decoration: linerGradient,
            child: ListView(
              children: [
                SizedBox(height: height * 0.05),
                logo,
                SizedBox(
                  height: height * 0.04,
                ),
                Stack(
                  children: [
                    Container(
                        width: width,
                        constraints: BoxConstraints(minHeight: height * 0.8),
                        decoration: roundedBox,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.05),
                                Text('KYC', style: kHeading2Style),
                                Text(
                                  '(Please Upload atleast 2 of the below document to complete your KYC)',
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImage('adhaar');
                                      },
                                      child: Container(
                                          decoration: inputFieldDecoration,
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.idCard,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Text('Adhaar Card',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )),
                                    ),
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: (adhaar != null)
                                          ? Image.file(adhaar,
                                              width: height * 0.15,
                                              height: height * 0.1,
                                              fit: BoxFit.cover)
                                          : Image.asset('assets/id.png',
                                              height: height * 0.1,
                                              width: height * 0.15,
                                              fit: BoxFit.cover),
                                    )
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImage('voterId');
                                      },
                                      child: Container(
                                          decoration: inputFieldDecoration,
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.idCard,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Text('Voter Card',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )),
                                    ),
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: (voterId != null)
                                          ? Image.file(voterId,
                                              width: height * 0.15,
                                              height: height * 0.1,
                                              fit: BoxFit.cover)
                                          : Image.asset('assets/id.png',
                                              height: height * 0.1,
                                              width: height * 0.15,
                                              fit: BoxFit.cover),
                                    )
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImage('drivingLicense');
                                      },
                                      child: Container(
                                          decoration: inputFieldDecoration,
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.idCard,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Text('Driving License',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )),
                                    ),
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: (drivingLicense != null)
                                          ? Image.file(drivingLicense,
                                              width: height * 0.15,
                                              height: height * 0.1,
                                              fit: BoxFit.cover)
                                          : Image.asset('assets/id.png',
                                              height: height * 0.1,
                                              width: height * 0.15,
                                              fit: BoxFit.cover),
                                    )
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImage('passport');
                                      },
                                      child: Container(
                                          decoration: inputFieldDecoration,
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.idCard,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Text('Passport',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )),
                                    ),
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: (passport != null)
                                          ? Image.file(passport,
                                              width: height * 0.15,
                                              height: height * 0.1,
                                              fit: BoxFit.cover)
                                          : Image.asset('assets/id.png',
                                              height: height * 0.1,
                                              width: height * 0.15,
                                              fit: BoxFit.cover),
                                    )
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                SizedBox(height: height * 0.05),
                                TextButton(
                                  child: Container(
                                    height: height * 0.035,
                                    width: width * 0.9,
                                    child: Center(
                                      child: Text(
                                        "CONTINUE",
                                        style: kButtonText,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    startUpload();
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
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                              ]),
                        )),
                    getNavigationButton(context)
                  ],
                )
              ],
            ),
          ),
          uploading
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
                        center: Text("Uploading...",
                            style:
                                kHeading4Style.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                )
              : Center()
        ],
      ),
    );
  }

  String uid;
  getUserId() {
    final _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;
    uid = user.uid;
    if (uid != null) {
      print(uid);
    } else {
      snackBar('Something went wrong. Please sign in again!!');
      Navigator.pop(context);
    }
  }

  startUpload() async {
      if (uploads >= 2) {
        setState(() {
          uploading = true;
        });
        uploadFile();
      } else {
        snackBar('Please Upload Atleast 2 KYC Documents');
      }
    
  }

  uploadFile() async {
    int uploaded = 0;
    FirebaseStorage storage = FirebaseStorage.instance;
    if (adhaar != null) {
      Reference ref = storage.ref().child("$uid/adhaar");
      ref.putFile(adhaar).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['adhaar'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                navigate();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload Adhaar Card');
            })
          });
    }
    if (voterId != null) {
      Reference ref = storage.ref().child("$uid/voterId");
      ref.putFile(voterId).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['voterId'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                navigate();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload Voter ID');
            })
          });
    }
    if (drivingLicense != null) {
      Reference ref = storage.ref().child("$uid/drivingLicense");
      ref.putFile(drivingLicense).then((data) => {
            data.ref.getDownloadURL().then((url) {
              print(url.toString());
              user['kyc']['drivingLicense'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                navigate();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload Driving License');
            })
          });
    }
    if (passport != null) {
      Reference ref = storage.ref().child("$uid/passport");
      ref.putFile(passport).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['passport'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                navigate();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload Passport');
            })
          });
    }
  }

  

  navigate() async{
    print(user);
    await uploadUserDetails();
    await saveLocally();
    setState(() {
      uploading = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  currentTab: 0,
                )));
  }

  uploadUserDetails() async{
    final CollectionReference userRef = FirebaseFirestore.instance.collection('/users');
    final Map<String, dynamic> userData = Map.from(user);
    await userRef.doc(uid).set(userData).catchError((e){
      print(e);
    });
  }

  saveLocally() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMap=jsonEncode(user);
    await prefs.setString('userDetailsLocal', userMap);
    await prefs.setString('UserID', uid);
  }
}
