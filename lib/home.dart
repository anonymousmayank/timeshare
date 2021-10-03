import 'package:flutter/material.dart';
import 'package:timeshare/constants.dart';

import 'login/login.dart';
import 'login/signup.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        decoration: linerGradient,
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            logo,
            SizedBox(height: height*0.04,),
            Text('Elders',
                style: kHeading1Style),
            Text('Social Connect',
                style: kHeading1Style),
            SizedBox(height: height * 0.15),
            Expanded(
              child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(height * 0.02),
                          topRight: Radius.circular(height * 0.02)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.05),
                          Text('Welcome',
                              style: kHeading2Style.copyWith(color: Color(0xFF70A6EF))),
                          SizedBox(height: height*0.01,),
                          Text(
                              'Elders in the society living away from family members and children, sometimes find it difficult to utilise time effectively. ',
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: height*0.005,),
                          Text(
                              'This app facilitates for effective utilisation of time. You can share your time with others having a common interest area by arranging meetings at your place or join meetings arranged by others.',
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: height*0.03,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Container(
                                  height: height * 0.035,
                                  width: width * 0.35,
                                  child: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: kButtonText,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LoginPage()));
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
                                          BorderRadius.circular(height * 0.05),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              TextButton(
                                child: Container(
                                  height: height * 0.035,
                                  width: width * 0.35,
                                  child: Center(
                                    child: Text(
                                      "REGISTER",
                                      style: kButtonText,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SignupPage()));
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                         Colors.white ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF70A6EF)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.05),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
