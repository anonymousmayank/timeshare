import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/drawer/drawer.dart';
import 'package:timeshare/homepage.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  String name, email, message;

   @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('userDetailsLocal') ?? '';
    if (userDetailsString != null) {
      Map userSavedDetails = json.decode(userDetailsString);
       setState(() {
        name=userSavedDetails['firstName']+' '+userSavedDetails['lastName'];
        email=userSavedDetails['email'];
      });
    } else {
      snackBar('Something went wrong. Please sign in again!!');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer.getDrawer(context, height, width),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                height: height,
                width: width,
                decoration: linerGradient,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: height * 0.1),
                    Center(child: logo),
                    SizedBox(height: height * 0.05),
                    Text('CONTACT US', style: kHeading2Style),
                    SizedBox(height: height * 0.03),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      'Name',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            enabled: name==null,
                            controller: _controller1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: name),
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'E-mail',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            enabled: email==null,
                            controller: _controller2,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: email),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'Message',
                      style: kHeading4Style,
                    ),
                    Card(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.005),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.01),
                          child: TextField(
                            controller: _controller3,
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 7,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Message'),
                            onChanged: (value) {
                              message = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Center(
                      child: Container(
                        decoration: inputFieldDecorationWhite,
                        child: TextButton(
                          child: Container(
                            height: height * 0.035,
                            width: width * 0.9,
                            child: Center(
                              child: Text(
                                "SEND",
                                style: kButtonText,
                              ),
                            ),
                          ),
                          onPressed: () {
                            sendMessage();
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
                      ),
                    )
                  ],
                )),
            Positioned(
                top: height * 0.06,
                left: width * 0.05,
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
                          child: FaIcon(FontAwesomeIcons.bars, color: blue3))),
                )),
          ],
        ));
  }

  sendMessage() async {
    final dbRef = FirebaseFirestore.instance.collection('/messages');
    if (validate()) {
      await dbRef.add(
          {'name': name, 'email': email, 'message': message}).catchError((e) {
        snackBar('Something went Wrong!! Please try again Later');
      });
      _controller1.clear();
      _controller2.clear();
      _controller3.clear();
      snackBar('Message sent!!');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(currentTab: 0)));
    }
  }

  bool validate() {
    if (email != null && name != null && message != null) {
      return true;
    } else {
      snackBar('Enter Details Correctly');
      return false;
    }
  }
}
