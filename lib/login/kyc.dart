import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/homepage.dart';

class KYCPage extends StatefulWidget {
  Map userData;
  KYCPage(this.userData);
  @override
  _KYCPageState createState() => _KYCPageState(this.userData);
}

class _KYCPageState extends State<KYCPage> {
  Map user;
  String dob;
  File _image;
  final picker = ImagePicker();
  List<String> skillSet = [
    'Select',
    'Skill 1',
    'Skill 2',
    'Skill 3',
    'Skill 4',
    'Skill 5',
    'Skill 6'
  ];
  bool checkedValue = false;
  List<String> skillsAdded = [];

  _KYCPageState(this.user);
  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.05),
                            Text('KYC',
                                style: kHeading2Style),
                            Text(
                              '(Please Upload atleast 2 of the below document to complete your KYC)',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.015,
                                        vertical: height * 0.001),
                                    child: Text('Date of Birth (As per documents submitted)',
                                        style: kInputLabelStyle.copyWith(fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                      decoration: inputFieldDecoration,
                                      height: height * 0.05,
                                      width: width * 0.9,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: height * 0.015,
                                          ),
                                          FaIcon(FontAwesomeIcons.solidCalendar,
                                              size: height * 0.02,
                                              color: Colors.black),
                                          SizedBox(
                                            width: height * 0.01,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'dd/mm/yyyy'),
                                              onChanged: (input) {
                                                dob = input;
                                              },
                                            ),
                                          ),
                                        ],
                                      ))
                                ]),
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: getImage,
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
                                  child: Image.asset('assets/id.png',
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
                                  onTap: getImage,
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
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      )),
                                ),
                                Spacer(),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.asset('assets/id.png',
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
                                  onTap: getImage,
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
                                  child: Image.asset('assets/id.png',
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
                                  onTap: getImage,
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
                                  child: Image.asset('assets/id.png',
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(currentTab: 0,)));
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
                                    borderRadius: BorderRadius.circular(5.0),
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
    );
  }
}
