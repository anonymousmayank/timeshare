import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/login/skillAdd.dart';

import 'kyc.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
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
    List<String> terms = [
      '1.	Elder couples in the society living away from family members and children, sometimes find it difficult to utilise time effectively.',
      '2.	They find it difficult to connect with suitable person of similar age group and skill set of mutual liking.',
      '3.	In order to find such company, Share2care Foundation has developed this application for elder members for society to get connected with elder persons having similar skills. ',
      '4.	By registering on this platform, you agree to follow the rules of the application.',
      '5.	You will use this platform with very high moral, integrity and respect to guest members.',
      '6.	You will not in any case harm other member of this platform.',
      '7.	There will be no financial involvement for joining such meeting.',
      '8.	Share2care Foundation shall be in no way responsible for any misconduct of either party and/or financial transaction, if any. ',
      '9.	Share2care Foundation is attempting to provide the platform for good social purpose. ',
      '10.	On exchange of the contact number between Guest(s) and Host, Share2care Foundation is not aware of further development amongst them. Hence total responsibility is of Guest and the host.  '
    ];
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
                            Text('Terms & Conditions',
                                style: kHeading2Style),
                            SizedBox(
                              height: height * 0.04,
                            ),
                          ] +
                          terms.map((term) => Padding(
                            padding: EdgeInsets.symmetric(vertical:height*0.01),
                            child: Text(term,style:kInputLabelStyle),
                          )).toList() +
                          [
                            SizedBox(height: height * 0.05),
                            TextButton(
                              child: Container(
                                height: height * 0.035,
                                width: width * 0.9,
                                child: Center(
                                  child: Text(
                                    "ACCEPT",
                                    style: kButtonText,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SkillAddPage(
                                            termsAndConditions: true)));
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
                ))
          ],
        ),
      ),
    );
  }
}
