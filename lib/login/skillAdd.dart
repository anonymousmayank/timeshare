import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/login/termsandconditions.dart';

import 'kyc.dart';

class SkillAddPage extends StatefulWidget {
  bool termsAndConditions;
  Map userData;
  SkillAddPage({@required this.termsAndConditions, @required this.userData});
  @override
  _SkillAddPageState createState() =>
      _SkillAddPageState(termsAndConditions, userData);
}

class _SkillAddPageState extends State<SkillAddPage> {
  Map user;
  String uid=FirebaseAuth.instance.currentUser.uid;
  String requestedSkill='';
  
  TextEditingController textEditingController = TextEditingController();
  bool termsConditions;
  _SkillAddPageState(this.termsConditions, this.user);
  bool gettingSkillSet = true;
  List<String> skillSet = ['Select'];

  List<String> skillsAdded = [];

  initState(){
    getSkills();
    print(uid);
    super.initState();
  }
  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (!gettingSkillSet)
          ? Container(
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
                                  Text('  ADD SKILLSET', style: kHeading2Style),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Choose Skills',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                height: height * 0.05,
                                                width: width * 0.9,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons.scroll,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          hint:
                                                              Text(skillSet[0]),
                                                          isExpanded: true,
                                                          items: skillSet.map(
                                                              (String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (input) {
                                                            if (input !=
                                                                    'Select' &&
                                                                !(skillsAdded
                                                                    .contains(
                                                                        input))) {
                                                              setState(() {
                                                                skillsAdded
                                                                    .add(input);
                                                              });
                                                              snackBar(
                                                                  'Successfully added Skill');
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        color: Color(0xFFF0F1F5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: height * 0.07,
                                                width: width * 0.7,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .solidPlusSquare,
                                                        size: height * 0.022,
                                                        color: Colors.black),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            textEditingController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Request a new skill',
                                                          labelStyle: TextStyle(
                                                              fontSize:
                                                                  height * 0.02,
                                                              color:
                                                                  Colors.black),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        onChanged: (input) {
                                                          requestedSkill=input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Container(
                                        width: width * 0.15,
                                        height: height * 0.07,
                                        child: ButtonTheme(
                                          child: TextButton(
                                            onPressed: () async{
                                              await skillRequest();
                                              snackBar(
                                                  'Request Sent !! Skill Set will be added once approved');
                                              textEditingController.clear();
                                            },
                                            child: Center(
                                                child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: height * 0.04,
                                            )),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  CheckboxListTile(
                                    activeColor: Color(0xFF70A6EF),
                                    checkColor: Colors.white,
                                    dense: true,
                                    title: Row(
                                      children: [
                                        Text('Accept our'),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TermsAndConditionsPage()));
                                          },
                                          child: Text('Terms & Conditions'),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text('before Uploading KYC Docs'),
                                    value: termsConditions,
                                    onChanged: (newValue) {
                                      setState(() {
                                        termsConditions = newValue;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Added Skills',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.008),
                                                    color:
                                                        blue3.withOpacity(0.8)),
                                                width: width * 0.9,
                                                height: skillsAdded.length == 1
                                                    ? skillsAdded.length *
                                                        height *
                                                        0.032
                                                    : skillsAdded.length *
                                                        height *
                                                        0.03,
                                                child: ListView.builder(
                                                    itemCount:
                                                        skillsAdded.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: index == 0
                                                                    ? height *
                                                                        0.008
                                                                    : height *
                                                                        0.002),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  height * 0.03,
                                                            ),
                                                            Text(
                                                                (index + 1)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.022,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                              width:
                                                                  height * 0.01,
                                                            ),
                                                            Text(
                                                                skillsAdded[
                                                                    index],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.022,
                                                                    color: Colors
                                                                        .black))
                                                          ],
                                                        ),
                                                      );
                                                    }))
                                          ]),
                                    ],
                                  ),
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
                                      if (termsConditions) {
                                        saveUser();
                                      } else {
                                        snackBar(
                                            'Please Accept Terms and Conditions to move Further');
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

  saveUser() {
    user['skillSet'] = skillsAdded;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => KYCPage(user)));
  }

  getSkills() async {
    final skillsRef = FirebaseFirestore.instance.collection('/skills');
    List snapshots;
    await skillsRef.get().then((querySnapshot) {
      snapshots = querySnapshot.docs;
    });
    snapshots.forEach((element) {
      skillSet.add(element['skillName']);
    });
    print(skillSet);
    setState(() {
      gettingSkillSet = false;
    });
  }

  skillRequest() async{
    final requestRef = FirebaseFirestore.instance.collection('/skillRequests');
    if(requestedSkill!=''){
      await requestRef.add({
      'skillName':requestedSkill,
      'id':uid
    }).catchError((e) {
    });

  }
  }
}
