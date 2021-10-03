import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/login/register.dart';

import '../homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}
BuildContext ctxt;

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  // bool hasError = false;
  bool otpEnabled = false;
  bool logginIn = false;
  String mobileNumber = "";
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
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

  timer(){
    Future.delayed(const Duration(seconds: 60), () {
      setState(() {
        logginIn=false;
      });
  });
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
                        height: height * 0.73,
                        width: width,
                        decoration: roundedBox,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.05),
                                Text('LOGIN', style: kHeading2Style),
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
                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                      maxLength: 10,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        
                                                        hintText: 'Mobile Number',
                                                        labelStyle: TextStyle(
                                                            fontSize: height * 0.02,
                                                            color: Colors.black),
                                                        border: InputBorder.none,
                                                        counterText: ''
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
                                            if (mobileNumber.length == 10) {
                                              startPhoneAuth(
                                                  '+91' + mobileNumber.trim());
                                              setState(() {
                                                otpEnabled = true;
                                                snackBar(
                                                    'OTP has been sent to provided number !!');
                                              });
                                            } else {
                                              snackBar('Invalid Mobile Number');
                                            }
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
                                        obscureText: false,
                                        // obscuringCharacter: '*',
                                        // obscuringWidget: FaIcon(
                                        //     FontAwesomeIcons.key,
                                        //     color: blue3),
                                        // blinkWhenObscuring: true,
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
                                          activeFillColor: Colors.blue.shade100,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't receive the code? ",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15),
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          if (mobileNumber.length == 10) {
                                              startPhoneAuth(
                                                  '+91' + mobileNumber.trim());
                                              setState(() {
                                                otpEnabled = true;
                                                snackBar("OTP resend!!");
                                              });
                                            } else {
                                              snackBar('Invalid Mobile Number');
                                            }
                                          
                                          },
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
                                        
                                        setState(() {
                                          logginIn=true;
                                          timer();
                                          ctxt = context;
                                          signIn(currentText);
                                        });
                                      },
                                      child: Center(
                                          child: Text(
                                        "LOGIN",
                                        style: kButtonText.copyWith(
                                            color: Colors.white),
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
          logginIn?Container(
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
                        center: Text("Logging In...",
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

  startPhoneAuth(String number) {
    instantiate(phoneNumber: number);
  }

  signIn(otp) async {
    print(otp);
    if (otp.length != 6) {
      snackBar('OTP must be of six digits');
      // setState(() {
      //   //errorMssg = "Invalid OTP";
      //   verifyingOtp = false;
      // });
    } else {
      await signInWithPhoneNumber(smsCode: otp);
    }
  }

  static var _authCredential, actualCode, phone, status;
  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
      StreamController.broadcast();
  Stream stateStream = phoneAuthState.stream;

  instantiate({String phoneNumber}) async {
    phone = phoneNumber;
    print(phone);
    startAuth();
  }

  startAuth() {
    FireBase.auth
        .verifyPhoneNumber(
            phoneNumber: phone.toString().trim(),
            timeout: Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: (String verificationId, [int forceResendingToken]) async {actualCode = verificationId;},
            codeAutoRetrievalTimeout: (String verificationId) {actualCode = verificationId;}
            )
        .then((value) {
      print('code Sent');
    }).catchError((error) {
      snackBar('Number Blocked !! Please try again after 24 hours.');
      print('Error  --  '+error);
    });
  }

  PhoneVerificationFailed verificationFailed(
      FirebaseAuthException authException) {
    PhoneVerificationFailed val;
    if (authException.message.contains('phone number')) {
      snackBar('Invalid Number');
    } else if (authException.message.contains('Network')) {
      snackBar('Check Internet Connection');
    }else if (authException.message.contains('blocked') || authException.message.contains('unknown status code')) {
      snackBar('Number Blocked !! Please try again after 24 hours.');
    } else {
      print(authException.message);
      snackBar("Something went wrong! Please try again");
    }
    return val;
  }

  PhoneVerificationCompleted verificationCompleted = (AuthCredential auth) {
    FireBase.auth.signInWithCredential(auth).then((UserCredential value) {
      if (value.user != null) {
        onAuthenticationSuccessful(value);
      }
    }).catchError((error) {
      print(error);
    });
  };

  signInWithPhoneNumber({String smsCode}) async {
      _authCredential = PhoneAuthProvider.credential(
          verificationId: actualCode, smsCode: smsCode);
          try{
            UserCredential user = await  FireBase.auth.signInWithCredential(_authCredential);
            if(user!=null){
              onAuthenticationSuccessful(user);
            }
          }
          catch (e) {
            setState(() {
              snackBar('Invalid OTP');
              logginIn=false;
            });
            errorController.add(ErrorAnimationType.shake);
            textEditingController.clear();
            
          }

  }

  static onAuthenticationSuccessful(user) async {
    //////  what to do after authentications //////
    String uid=user.user.uid;
    if(user.additionalUserInfo.isNewUser){
      Navigator.push(ctxt, MaterialPageRoute(builder: (ctxt) => RegisterPage()));
    }
    else{
      bool exists=await checkUser(uid);
      if(exists){
        await getUserData(uid);
        Navigator.push(ctxt, MaterialPageRoute(builder: (ctxt) =>  HomePage(currentTab: 0)));
      }
      else{
        Navigator.push(ctxt, MaterialPageRoute(builder: (ctxt) => RegisterPage()));
      }
      
    }
  }
  static Future<bool> checkUser(uid) async{
    try {
    var userRef = FirebaseFirestore.instance.collection('/users');
    var doc = await userRef.doc(uid).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
  }
  static getUserData(uid) async {
    print(uid);
    Map user;
    final userRef = FirebaseFirestore.instance.collection('/users');
    await userRef.doc(uid).get().then((DocumentSnapshot) {
      user = DocumentSnapshot.data();
    }).whenComplete(() async{
      await saveLocally(user, uid);
    });
  }
  static saveLocally(user, uid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMap=jsonEncode(user);
    await prefs.setString('userDetailsLocal', userMap);
    await prefs.setString('UserID', uid);
  }

}

class FireBase {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static instantiate() {}
}
