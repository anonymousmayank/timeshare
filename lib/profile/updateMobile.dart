import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timeshare/constants.dart';

import '../homepage.dart';

class UpdateMobilePage extends StatefulWidget {
  @override
  _UpdateMobilePageState createState() => _UpdateMobilePageState();
}

class _UpdateMobilePageState extends State<UpdateMobilePage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  bool otpEnabled = false;
  String generatedOTP = "123456";
  String mobileNumber = "";
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
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
                    height: height * 0.73,
                    width: width,
                    decoration: roundedBox,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.05),
                            Text('UPDATE',
                                style: kHeading2Style),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  color: Color(0xFFF0F1F5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: height * 0.07,
                                          width: width * 0.6,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.phoneAlt,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Mobile Number',
                                                    labelStyle: TextStyle(
                                                        fontSize: height * 0.02,
                                                        color: Colors.black),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (input) {
                                                    mobileNumber = input;
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
                                      onPressed: () {
                                        setState(() {
                                          otpEnabled = true;
                                          snackBar(
                                              'OTP has been sent to provided number !!');
                                        });
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
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Form(
                              key: formKey,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 30),
                                  child: PinCodeTextField(
                                    enabled: otpEnabled,
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    obscureText: true,
                                    obscuringCharacter: '*',
                                    obscuringWidget: FaIcon(
                                        FontAwesomeIcons.key,
                                        color: blue3),
                                    blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v.length < 6) {
                                        return "Please Enter OTP Correctly";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: width * 0.1,
                                      inactiveFillColor: blue3,
                                      inactiveColor: blue3,
                                      activeColor: Colors.black,
                                      activeFillColor: hasError
                                          ? Colors.blue.shade100
                                          : Colors.white,
                                    ),
                                    cursorColor: Colors.black,
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    errorAnimationController: errorController,
                                    controller: textEditingController,
                                    keyboardType: TextInputType.number,
                                    boxShadows: [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],
                                    onCompleted: (v) {
                                      print("Completed");
                                    },
                                    // onTap: () {
                                    //   print("Pressed");
                                    // },
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        currentText = value;
                                      });
                                    },
                                  )),
                            ),
                            Text(
                              hasError ? "Invalid OTP" : "",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive the code? ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                TextButton(
                                    onPressed: () => snackBar("OTP resend!!"),
                                    child: Text(
                                      "RESEND",
                                      style: TextStyle(
                                          color: blue3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    formKey.currentState.validate();
                                    // conditions for validating
                                    if (currentText.length != 6 ||
                                        currentText != generatedOTP) {
                                      errorController.add(ErrorAnimationType
                                          .shake); // Triggering error shake animation
                                      setState(() {
                                        snackBar("Please Enter Correct OTP");
                                        hasError = true;
                                      });
                                      textEditingController.clear();
                                    } else {
                                      setState(
                                        () {
                                          hasError = false;
                                        },
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage(currentTab: 4,)));
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    "UPDATE",
                                    style: kButtonText.copyWith(color:Colors.white)
                                  )),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
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
