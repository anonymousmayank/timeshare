import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:timeshare/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeshare/profile/updateMobile.dart';

class UpdateProfilePage extends StatefulWidget {
  String uid;
  UpdateProfilePage({this.uid});
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState(uid: uid);
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  Map user;
  String uid;
  _UpdateProfilePageState({this.uid});
  bool uploading = false, updatingUser = false, gettingUser = true;
  String firstName,
      lastName,
      email,
      secmobile,
      primarymobile,
      bloodGroup = 'Select',
      disease = 'Select',
      adhaar,
      address,
      locality,
      city,
      state,
      pincode,
      dob,
      gender = 'Select',
      highestQualification = 'Select',
      professionalCareer,
      hobbies,
      emergencyContact,
      emergencyName,
      emergencyRelationship;
      List<String> qualifications = [
    'Select',
    'Doctorate',
    'Post-Graduate',
    'Graduate',
    'Non-Graduate'
  ];
  int uploads = 0;
  File adhaarpic, voterId, drivingLicense, passport, profilePic;
  final picker = ImagePicker();

  initState() {
    getUser();
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

  Future getImageGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (profilePic == null) {
      uploads += 1;
    }
    setState(() {
      profilePic = File(pickedFile.path);
      Navigator.pop(context);
    });
  }

  Future getImage(type) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (type == 'adhaar' && (pickedFile != null)) {
      if (adhaarpic == null) {
        uploads += 1;
      }
      setState(() {
        adhaarpic = File(pickedFile.path);
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
    } else if (type == 'profile' && (pickedFile != null)) {
      if (profilePic == null) {
        uploads += 1;
      }
      setState(() {
        profilePic = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (!gettingUser && !updatingUser && !uploading)
          ? Container(
              decoration: linerGradient,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.03),
                  Center(
                    child: Text(
                      'Update Profile',
                      style: kHeading3Style,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                decoration: linerGradient,
                                height: height * 0.2,
                                child: Column(
                                  children: [
                                    SizedBox(height: height * 0.02),
                                    Text('Choose Image Source',
                                        style: kHeading3Style),
                                    SizedBox(
                                      height: height * 0.05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          child: Container(
                                            height: height * 0.035,
                                            width: width * 0.4,
                                            child: Center(
                                              child: Text(
                                                "GALLERY",
                                                style: kButtonText,
                                              ),
                                            ),
                                          ),
                                          onPressed: getImageGallery,
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
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        TextButton(
                                          child: Container(
                                            height: height * 0.035,
                                            width: width * 0.4,
                                            child: Center(
                                              child: Text(
                                                "CAMERA",
                                                style: kButtonText,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            getImage('profile');
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(blue3),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                        child: Container(
                            decoration: inputFieldDecorationWhite,
                            height: height * 0.05,
                            width: width * 0.6,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height * 0.015,
                                ),
                                FaIcon(FontAwesomeIcons.camera,
                                    size: height * 0.02,
                                    color: Color(0xFF70A6EF)),
                                SizedBox(
                                  width: height * 0.01,
                                ),
                                Text('Update Profile Pic',
                                    style: kHeading4Style),
                              ],
                            )),
                      ),
                      Spacer(),
                      Container(
                        height: width * 0.25,
                        width: width * 0.25,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: (user['profilePic'] == '' &&
                                  profilePic == null)
                              ? Image.asset('assets/profile.jfif',
                                  fit: BoxFit.cover)
                              : (profilePic == null)
                                  ? CachedNetworkImage(
                                      imageUrl: user['profilePic'],
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          LinearProgressIndicator(
                                              backgroundColor: blue3,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      blue1),
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Image.file(profilePic, fit: BoxFit.cover),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child:
                                  Text('First Name', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.userAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['firstName']),
                                        onChanged: (input) {
                                          firstName = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Surname', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.userAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['lastName']),
                                        onChanged: (input) {
                                          lastName = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: height * 0.015,
                              vertical: height * 0.001),
                          child: Text('E-mail', style: kInputLabelStyle),
                        ),
                        Container(
                            decoration: inputFieldDecorationWhite,
                            height: height * 0.05,
                            width: width * 0.9,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height * 0.015,
                                ),
                                FaIcon(FontAwesomeIcons.solidEnvelope,
                                    size: height * 0.02, color: blue3),
                                SizedBox(
                                  width: height * 0.01,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: user['email']),
                                    onChanged: (input) {
                                      email = input;
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ]),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Gender', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.transgender,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(user['gender']),
                                          isExpanded: true,
                                          items: ['Male', 'Female']
                                              .map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (input) {
                                            gender = input;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Date of Birth',
                                  style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.solidCalendar,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['dob']
                                                .split('-')
                                                .reversed
                                                .join('/')),
                                        onChanged: (input) {
                                          dob = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child:
                                  Text('Blood Group', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                // height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.tint,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(bloodGroup),
                                          isExpanded: true,
                                          items: [
                                            'A+',
                                            'A-',
                                            'B+',
                                            'B-',
                                            'O+',
                                            'O-',
                                            'AB+',
                                            'AB-'
                                          ].map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (input) {
                                            setState(() {
                                              bloodGroup = input;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Chronic Disease',
                                  style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                // height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.disease,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(disease),
                                          isExpanded: true,
                                          items: [
                                            'None',
                                            'Asthama',
                                            'Blood Pressure',
                                            'Cancer',
                                            'Cholestrol',
                                            'Chronic Obstructive Pulmonary Disease (COPD)'
                                                'Diabetes',
                                            'Heart Diseases',
                                            'PCOD',
                                            'TB'
                                          ].map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (input) {
                                            setState(() {
                                              disease = input;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: height * 0.015,
                              vertical: height * 0.001),
                          child: Text('Adhaar Card Number',
                              style: kInputLabelStyle),
                        ),
                        Container(
                            decoration: inputFieldDecorationWhite,
                            height: height * 0.05,
                            width: width * 0.9,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height * 0.015,
                                ),
                                FaIcon(FontAwesomeIcons.solidAddressCard,
                                    size: height * 0.02, color: blue3),
                                SizedBox(
                                  width: height * 0.01,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            user['adhaar'].substring(0, 4) +
                                                ' - ' +
                                                user['adhaar'].substring(4, 8) +
                                                ' - ' +
                                                user['adhaar'].substring(8)),
                                    onChanged: (input) {
                                      adhaar = input;
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ]),
                  SizedBox(height: height * 0.01),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: height * 0.015,
                                vertical: height * 0.001),
                            child: Text(
                              'Address - House Number / Street',
                              style: kInputLabelStyle,
                            )),
                        Container(
                            decoration: inputFieldDecorationWhite,
                            height: height * 0.05,
                            width: width * 0.9,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height * 0.015,
                                ),
                                FaIcon(FontAwesomeIcons.solidBuilding,
                                    size: height * 0.02, color: blue3),
                                SizedBox(
                                  width: height * 0.01,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: user['address']),
                                    onChanged: (input) {
                                      address = input;
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ]),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Locality', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['locality']),
                                        onChanged: (input) {
                                          locality = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('District/City',
                                  style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.mapMarkedAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['city']),
                                        onChanged: (input) {
                                          city = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('State', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.mapMarkedAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['state']),
                                        onChanged: (input) {
                                          state = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Pin Code', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.mapPin,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['pinCode']),
                                        onChanged: (input) {
                                          pincode = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ],
                  ),


                  SizedBox(height: height * 0.01),

                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text('Highest Qualification',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecorationWhite,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(
                                                      FontAwesomeIcons
                                                          .userGraduate,
                                                      size: height * 0.02,
                                                      color: blue3),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(user['highestQualification']),
                                                        isExpanded: true,
                                                        items: qualifications.map(
                                                                (String value) {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (input) {
                                                          setState(() {
                                                            highestQualification =input;
                                                          });
                                                          
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text(
                                                'Professional Career (Latest)',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecorationWhite,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(
                                                      FontAwesomeIcons
                                                          .briefcase,
                                                      size: height * 0.02,
                                                      color: blue3),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              user['professionalCareer']),
                                                      onChanged: (input) {
                                                        professionalCareer =
                                                            input;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text(
                                                'Hobbies (Use , to seperate multiple Hobbies)',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecorationWhite,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(FontAwesomeIcons.magic,
                                                      size: height * 0.02,
                                                      color: blue3),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              user['hobbies']),
                                                      onChanged: (input) {
                                                        hobbies = input;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                            SizedBox(height:height*0.01),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: height * 0.015,
                                vertical: height * 0.001),
                            child: Text(
                              'Emergency Contact',
                              style: kInputLabelStyle,
                            )),
                        Container(
                            decoration: inputFieldDecorationWhite,
                            height: height * 0.05,
                            width: width * 0.9,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height * 0.015,
                                ),
                                FaIcon(FontAwesomeIcons.phoneAlt,
                                    size: height * 0.02, color: blue3),
                                SizedBox(
                                  width: height * 0.01,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: user['emergencyContact']),
                                    onChanged: (input) {
                                      emergencyContact = input;
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ]),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child: Text('Full Name', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.userAlt,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: user['emergencyName']),
                                        onChanged: (input) {
                                          emergencyName = input;
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                      SizedBox(width: width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.015,
                                  vertical: height * 0.001),
                              child:
                                  Text('Relationship', style: kInputLabelStyle),
                            ),
                            Container(
                                decoration: inputFieldDecorationWhite,
                                height: height * 0.05,
                                width: width * 0.425,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.015,
                                    ),
                                    FaIcon(FontAwesomeIcons.solidHeart,
                                        size: height * 0.02, color: blue3),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(user['emergencyRelation']),
                                          isExpanded: true,
                                          items: [
                                            'Father',
                                            'Mother',
                                            'Brother',
                                            'Sister',
                                            'Spouse',
                                            'Son',
                                            'Daughter',
                                            'Son-in-Law',
                                            'Daughter-in-Law',
                                            'Friend',
                                            'Others'
                                          ].map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (input) {
                                            setState(() {
                                              emergencyRelationship = input;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: TextField(
                                    //     keyboardType: TextInputType.text,
                                    //     decoration: InputDecoration(
                                    //         border: InputBorder.none,
                                    //         hintText:
                                    //             user['emergencyRelation']),
                                    //     onChanged: (input) {
                                    //       emergencyRelationship = input;
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ))
                          ]),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * 0.06),
                            topRight: Radius.circular(height * 0.01),
                            bottomLeft: Radius.circular(height * 0.01),
                            bottomRight: Radius.circular(height * 0.01)),
                        color: Colors.white),
                    padding: EdgeInsets.all(height * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'KYC Docs',
                          style: kHeading4Style,
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: (user['kyc']['adhaar'] == '' &&
                                      adhaarpic == null)
                                  ? Image.asset('assets/id.png',
                                      height: height * 0.1,
                                      width: height * 0.15,
                                      fit: BoxFit.cover)
                                  : (adhaarpic == null)
                                      ? CachedNetworkImage(
                                          imageUrl: user['kyc']['adhaar'],
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              LinearProgressIndicator(
                                                  backgroundColor: blue3,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(blue1),
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.file(adhaarpic,
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
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
                                      Text('Voter ID',
                                          style: TextStyle(
                                              fontSize: height * 0.02,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: (user['kyc']['voterId'] == '' &&
                                      voterId == null)
                                  ? Image.asset('assets/id.png',
                                      height: height * 0.1,
                                      width: height * 0.15,
                                      fit: BoxFit.cover)
                                  : (voterId == null)
                                      ? CachedNetworkImage(
                                          imageUrl: user['kyc']['voterId'],
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              LinearProgressIndicator(
                                                  backgroundColor: blue3,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(blue1),
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.file(voterId,
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: (user['kyc']['drivingLicense'] == '' &&
                                      drivingLicense == null)
                                  ? Image.asset('assets/id.png',
                                      height: height * 0.1,
                                      width: height * 0.15,
                                      fit: BoxFit.cover)
                                  : (drivingLicense == null)
                                      ? CachedNetworkImage(
                                          imageUrl: user['kyc']
                                              ['drivingLicense'],
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              LinearProgressIndicator(
                                                  backgroundColor: blue3,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(blue1),
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.file(drivingLicense,
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
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
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: (user['kyc']['passport'] == '' &&
                                      passport == null)
                                  ? Image.asset('assets/id.png',
                                      height: height * 0.1,
                                      width: height * 0.15,
                                      fit: BoxFit.cover)
                                  : (passport == null)
                                      ? CachedNetworkImage(
                                          imageUrl: user['kyc']['passport'],
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              LinearProgressIndicator(
                                                  backgroundColor: blue3,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(blue1),
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.file(passport,
                                          height: height * 0.1,
                                          width: height * 0.15,
                                          fit: BoxFit.cover),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  TextButton(
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.9,
                      child: Center(
                        child: Text(
                          "UPDATE",
                          style: kButtonText,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (uploads > 0) {
                          uploading = true;
                        }
                        updatingUser = true;
                      });

                      update();
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  // TextButton(
                  //   child: Container(
                  //     height: height * 0.035,
                  //     width: width * 0.9,
                  //     child: Center(
                  //       child: Text(
                  //         "UPDATE MOBILE NUMBER",
                  //         style: kButtonText,
                  //       ),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => UpdateMobilePage()));
                  //   },
                  //   style: ButtonStyle(
                  //     foregroundColor: MaterialStateProperty.all<Color>(blue3),
                  //     backgroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.white),
                  //     shape: MaterialStateProperty.all(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.05,
                  )
                ],
              ),
            )
          : Container(
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

  getUser() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      user = DocumentSnapshot.data();
    }).whenComplete(() => setState(() => gettingUser = false));
  }

  update() async {
    setValues();
    await uploadFile();
  }

  setValues() {
    if (firstName != null) {
      if (gender != 'Select') {
        if (gender == 'Male') {
          user['firstName'] = 'Mr, ' + firstName;
        } else if (gender == 'Female') {
          user['firstName'] = 'Ms.' + firstName;
        }
      } else {
        if (user['gender'] == 'Male') {
          user['firstName'] = 'Mr. ' + firstName;
        } else if (user['gender'] == 'Female') {
          user['firstName'] = 'Ms. ' + firstName;
        }
      }
    }
    if (lastName != null) {
      user['lastName'] = lastName;
    }
    if (email != null) {
      user['email'] = email;
    }
    if (gender != 'Select') {
      user['gender'] = gender;
    }
    if (bloodGroup != 'Select') {
      user['bloodGrp'] = bloodGroup;
    }
    if (disease != 'Select') {
      user['disease'] = disease;
    }
    if(highestQualification!='Select'){
      user['highestQualification']=highestQualification;
    }
    if(professionalCareer!=null){
      user['professionalCareer']=professionalCareer;
    }
    if(hobbies!=null){
      user['hobbies']=hobbies;
    }
    if (dob != null) {
      user['dob'] = dob;
    }
    if (adhaar != null) {
      user['adhaar'] = adhaar;
    }
    if (address != null) {
      user['address'] = address;
    }
    if (locality != null) {
      user['locality'] = locality;
    }
    if (city != null) {
      user['city'] = city;
    }
    if (state != null) {
      user['state'] = state;
    }
    if (pincode != null) {
      user['pinCode'] = pincode;
    }
    if (emergencyContact != null) {
      user['emergencyContact'] = emergencyContact;
    }
    if (emergencyName != null) {
      user['emergencyName'] = emergencyName;
    }
    if (emergencyRelationship != null) {
      user['emergencyRelation'] = emergencyRelationship;
    }
  }

  uploadFile() async {
    int uploaded = 0;
    FirebaseStorage storage = FirebaseStorage.instance;
    if (adhaarpic != null) {
      Reference ref = storage.ref().child(
          "$uid/adhaar" + DateTime.now().millisecondsSinceEpoch.toString());
      ref.putFile(adhaarpic).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['adhaar'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                uploadComplete();
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
      Reference ref = storage.ref().child(
          "$uid/voterId" + DateTime.now().millisecondsSinceEpoch.toString());
      ref.putFile(voterId).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['voterId'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                uploadComplete();
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
      Reference ref = storage.ref().child("$uid/drivingLicense" +
          DateTime.now().millisecondsSinceEpoch.toString());
      ref.putFile(drivingLicense).then((data) => {
            data.ref.getDownloadURL().then((url) {
              print(url.toString());
              user['kyc']['drivingLicense'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                uploadComplete();
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
      Reference ref = storage.ref().child(
          "$uid/passport" + DateTime.now().millisecondsSinceEpoch.toString());
      ref.putFile(passport).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['kyc']['passport'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                uploadComplete();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload Passport');
            })
          });
    }
    if (profilePic != null) {
      Reference ref = storage.ref().child(
          "$uid/profilePic" + DateTime.now().millisecondsSinceEpoch.toString());
      ref.putFile(profilePic).then((data) => {
            data.ref.getDownloadURL().then((url) {
              user['profilePic'] = url.toString();
              uploaded += 1;
              if (uploaded == uploads) {
                uploadComplete();
              }
            }).catchError((onError) {
              setState(() {
                uploading = false;
              });
              snackBar('Unable to upload ProfilePic');
            })
          });
    }
  }

  uploadComplete() async {
    setState(() {
      uploading = false;
    });
    await updateUser();
    await saveLocally();
  }

  updateUser() async {
    final userRef = FirebaseFirestore.instance.collection('/users');
    await userRef.doc(uid).set(user).catchError((e) {
      print(e);
      snackBar('Something went wrong!! Please try again Later');
      setState(() {
        updatingUser = false;
      });
    });
    setState(() {
      updatingUser = false;
    });
    snackBar('Profile Updated!!');
  }

  saveLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMap = jsonEncode(user);
    await prefs.setString('userDetailsLocal', userMap);
  }
}
