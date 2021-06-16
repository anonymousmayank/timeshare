import 'package:flutter/material.dart';
import 'package:timeshare/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/profile/updateProfile.dart';

class ProfilePage extends StatelessWidget {
  Widget makeTile(
      {Color color,
      double width,
      double screenHeight,
      String heading,
      IconData icon,
      String value}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenHeight * 0.015, vertical: screenHeight * 0.001),
        child: Text(heading, style: kInputLabelStyle),
      ),
      Container(
          decoration: inputFieldDecorationWhite,
          height: screenHeight * 0.05,
          width: width,
          child: Row(
            children: [
              SizedBox(
                width: screenHeight * 0.015,
              ),
              FaIcon(
                icon,
                size: screenHeight * 0.02,
                color: Color(0xFF70A6EF),
              ),
              SizedBox(
                width: screenHeight * 0.01,
              ),
              Text(value,
                  style: TextStyle(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.w500)),
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        SizedBox(height: height * 0.1),
        userDetails,
        SizedBox(height: height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeTile(
                icon: FontAwesomeIcons.userAlt,
                screenHeight: height,
                width: width * 0.425,
                heading: 'First Name',
                value: 'Ritika'),
            SizedBox(width: width * 0.05),
            makeTile(
                icon: FontAwesomeIcons.userAlt,
                screenHeight: height,
                width: width * 0.425,
                heading: 'Last Name',
                value: 'Malik')
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        makeTile(
            icon: FontAwesomeIcons.solidEnvelope,
            screenHeight: height,
            width: width * 0.9,
            heading: 'E-mail',
            value: 'ritika.malik10123@gmail.com'),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeTile(
                icon: FontAwesomeIcons.transgender,
                screenHeight: height,
                width: width * 0.425,
                heading: 'Gender',
                value: 'Female'),
            SizedBox(width: width * 0.05),
            makeTile(
                icon: FontAwesomeIcons.solidCalendar,
                screenHeight: height,
                width: width * 0.425,
                heading: 'Date of Birth',
                value: '15/08/2000')
          ],
        ),
        SizedBox(height: height * 0.01),
        makeTile(
            icon: FontAwesomeIcons.solidAddressCard,
            screenHeight: height,
            width: width * 0.9,
            heading: 'Adhaar Card Number',
            value: 'XXXX-XXXX-XXXX'),
        SizedBox(height: height * 0.01),
        makeTile(
            icon: FontAwesomeIcons.solidBuilding,
            screenHeight: height,
            width: width * 0.9,
            heading: 'House Number / Street',
            value: '21, Prakash Vihar'),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeTile(
                icon: FontAwesomeIcons.mapMarkerAlt,
                screenHeight: height,
                width: width * 0.425,
                heading: 'Locality',
                value: 'Dharmpur'),
            SizedBox(width: width * 0.05),
            makeTile(
                icon: FontAwesomeIcons.mapMarkedAlt,
                screenHeight: height,
                width: width * 0.425,
                heading: 'District/City',
                value: 'Dehradun')
          ],
        ),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            makeTile(
                icon: FontAwesomeIcons.mapMarkedAlt,
                screenHeight: height,
                width: width * 0.425,
                heading: 'State',
                value: 'Uttarakhand'),
            SizedBox(width: width * 0.05),
            makeTile(
                icon: FontAwesomeIcons.mapPin,
                screenHeight: height,
                width: width * 0.425,
                heading: 'Pin Code',
                value: '248001')
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
                  Container(
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
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                "EDIT PROFILE",
                style: kButtonText,
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateProfilePage()));
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
        SizedBox(height: height*0.1,),
      ],
    );
  }
}
