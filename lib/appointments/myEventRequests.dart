import 'package:flutter/material.dart';
import 'package:timeshare/customDatatypes/eventAttendeeDatatype.dart';

import '../constants.dart';

class EventRequestPage extends StatelessWidget {
  List<Attendee> requests;
  EventRequestPage({this.requests});

  Widget makeRequestsList(height, width) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal:width*0.05, vertical:height*0.005),
        child: Card(
            child: Container(
          padding: EdgeInsets.all(height * 0.01),
          child: Column(
            children: [
              Text(
                requests[index].name,
                style: TextStyle(
                    fontSize: height * 0.025, fontWeight: FontWeight.bold),
              ),
              Text(
                requests[index].address,
                style: TextStyle(
                  fontSize: height * 0.02,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: new Text(
                          "Accept",
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                      onPressed: null,
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height * 0.01),
                            side: BorderSide(color: Colors.black, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: new Text(
                          "Cancel",
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                      onPressed: null,
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height * 0.01),
                            side: BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  decoration: linerGradient,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.08),
                      Text(
                        'Inhouse Ludo',
                        style: kHeading1Style.copyWith(fontFamily: 'PoorStory', fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Text(
                          '24-April-2021',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              color:Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Text(
                                '12:30 p.m',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * 0.004,
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD),
                                        Color(0xFFCFE4FD)
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 0.3, 0.6, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Text(
                                '2:30 p.m',
                                style: TextStyle(
                                    fontSize: height * 0.023,
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: Center(child: makeRequestsList(height, width)),
                )
              ],
            ),
            Positioned(
              top: height * 0.26,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Card(
                          color: Colors.black,
                          child: Container(
                            height: height * 0.06,
                            width: height * 0.06,
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color:Colors.white,
                                    fontFamily: 'PoorStory'),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Allowed',
                          style: TextStyle(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          color: Colors.black,
                          child: Container(
                            height: height * 0.06,
                            width: height * 0.06,
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color:Colors.white,
                                    fontFamily: 'PoorStory'),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Accepted',
                          style: TextStyle(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          color: Colors.black,
                          child: Container(
                            height: height * 0.06,
                            width: height * 0.06,
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color:Colors.white,
                                    fontFamily: 'PoorStory'),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
