import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:io';
import 'package:timeshare/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeshare/profile/updateMobile.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File _image;
  final picker = ImagePicker();
  String firstName,
      lastName,
      email,
      adhaar,
      address1,
      address2,
      city,
      state,
      pincode,
      dob,
      gender;
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageCamera() async {
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
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
                                    onPressed: getImageCamera,
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              blue3),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
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
                              size: height * 0.02, color: Color(0xFF70A6EF)),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Text('Update Profile Pic', style: kHeading4Style),
                        ],
                      )),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jfif'),
                  radius: height * 0.05,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
                    child: Text('First Name', style: kInputLabelStyle),
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
                                  border: InputBorder.none, hintText: 'Ritika'),
                              onChanged: (input) {
                                firstName = input;
                              },
                            ),
                          ),
                        ],
                      ))
                ]),
                SizedBox(width: width * 0.05),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
                    child: Text('Last Name', style: kInputLabelStyle),
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
                                  border: InputBorder.none, hintText: 'Malik'),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: height * 0.015, vertical: height * 0.001),
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
                              hintText: 'ritika.malik10123@gmail.com'),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
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
                                hint: Text('Female'),
                                isExpanded: true,
                                items: ['Male', 'Female'].map((String value) {
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
                    child: Text('Date of Birth', style: kInputLabelStyle),
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
                                  hintText: '15/08/2000'),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: height * 0.015, vertical: height * 0.001),
                child: Text('Adhaar Card Number', style: kInputLabelStyle),
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
                              hintText: 'XXXX-XXXX-XXXX'),
                          onChanged: (input) {
                            adhaar = input;
                          },
                        ),
                      ),
                    ],
                  ))
            ]),
            SizedBox(height: height * 0.01),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: height * 0.015, vertical: height * 0.001),
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
                              hintText: '21, Prakash Vihar'),
                          onChanged: (input) {
                            address1 = input;
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
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
                                  hintText: 'Dharmpur'),
                              onChanged: (input) {
                                address2 = input;
                              },
                            ),
                          ),
                        ],
                      ))
                ]),
                SizedBox(width: width * 0.05),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
                    child: Text('District/City', style: kInputLabelStyle),
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
                                  hintText: 'Dehradun'),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
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
                                  hintText: 'Uttarakhand'),
                              onChanged: (input) {
                                state = input;
                              },
                            ),
                          ),
                        ],
                      ))
                ]),
                SizedBox(width: width * 0.05),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
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
                                  border: InputBorder.none, hintText: '248001'),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: height * 0.015, vertical: height * 0.001),
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
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: '7905084484'),
                          onChanged: (input) {
                            address1 = input;
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
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
                                  hintText: 'Mayankesh Mishra'),
                              onChanged: (input) {
                                state = input;
                              },
                            ),
                          ),
                        ],
                      ))
                ]),
                SizedBox(width: width * 0.05),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.015, vertical: height * 0.001),
                    child: Text('Relationship', style: kInputLabelStyle),
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
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Son'),
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
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.06),
                    topRight: Radius.circular(height * 0.01),
                    bottomLeft: Radius.circular(height * 0.01),
                    bottomRight: Radius.circular(height * 0.01)
                  ),
                  color: Colors.white),
              padding: EdgeInsets.all(height*0.01),
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
                        onTap: getImageCamera,
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
                                    size: height * 0.02, color: Colors.black),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset('assets/id.png',
                            height: height * 0.1,
                            width: height * 0.15,
                            fit: BoxFit.cover),
                      )
                    ],
                  ),
                  SizedBox(height:height*0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: getImageCamera,
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
                                    size: height * 0.02, color: Colors.black),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset('assets/id.png',
                            height: height * 0.1,
                            width: height * 0.15,
                            fit: BoxFit.cover),
                      )
                    ],
                  ),
                  SizedBox(height:height*0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: getImageCamera,
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
                                    size: height * 0.02, color: Colors.black),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset('assets/id.png',
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
              onPressed: () {},
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
            SizedBox(
              height: height * 0.02,
            ),
            TextButton(
              child: Container(
                height: height * 0.035,
                width: width * 0.9,
                child: Center(
                  child: Text(
                    "UPDATE MOBILE NUMBER",
                    style: kButtonText,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateMobilePage()));
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(blue3),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
