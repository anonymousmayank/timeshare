import 'package:flutter/material.dart';
import 'package:timeshare/constants.dart';

class EventPage extends StatelessWidget {
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
                  color: Color(0xFF70A6EF),
                  child: Center(
                    child: Text(
                      'Inhouse Ludo',
                      style: TextStyle(
                          fontSize: height * 0.08,
                          fontWeight: FontWeight.w600,
                          color:Colors.white,
                          fontFamily: 'PoorStory'),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: width * 0.35),
                    Column(
                      children: [
                        Card(
                          color: Color(0xFF70A6EF),
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
                          color: Color(0xFF70A6EF),
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
                          color: Color(0xFF70A6EF),
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
                Container(
                  padding: EdgeInsets.all(width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr. Rakesh Sharma',
                        style: TextStyle(
                            fontSize: height * 0.035,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text('Crossings Republik, Ghaziabad',style: TextStyle(fontSize: height * 0.023)),
                      SizedBox(height:height*0.05),
                      Center(
                        child: Text(
                          '24-April-2021',
                          style: TextStyle(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Text(
                              '12:30 p.m',
                              style: TextStyle(
                                fontSize: height * 0.023,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: height * 0.004,
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      Color(0xFF70A6EF),
                                      Color(0xFFCFE4FD),
                                      Color(0xFFCFE4FD),
                                      Color(0xFF70A6EF)
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0,0.3,0.6, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Text(
                              '2:30 p.m',
                              style: TextStyle(
                                fontSize: height * 0.023,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: height*0.05,),
                      Center(
                        child: TextButton(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.3),
                                  child: new Text(
                                    "JOIN",
                                    style: TextStyle(fontSize: height * 0.025,letterSpacing: 2),
                                  ),
                                ),
                                onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>EventPage()));},
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(height*0.01),
                                      side: BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: height * 0.24,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset('assets/profile.jfif',
                    fit: BoxFit.fill, width: width * 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(left: width * 0.05),
              ),
            )
          ],
        ),
      ),
    );
  }
}
